// scripts\mp\br\gametypes\br_gametype_truckwar.gsc  (hash_75fa5e2835aeb1ae.gscc) (size: 57693 Bytes / 0xe15d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43beb236 (1136570934)
// size ...... 57693 (0xe15d)
// includes .. 50  (offset: 0xd109)
// strings ... 240 (offset: 0xd299)
// dev strs .. 4   (offset: 0xe0b1)
// exports ... 126 (offset: 0x9065)
// cseg ...... 0x178d + 0x78d8 (0x9065)
// imports ... 351 (offset: 0xa415)
// animtree1 . 2   (offset: 0xe0e1)
// animtree2 . 6   (offset: 0xe0fd)
#using script_16ea1b94f0f381b3;
#using script_be7da0439d09064;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\deathicons;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\loot\common_kiosk_data;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\supers;

#namespace br_gametype_truckwar;

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xf22e563d, Offset: 0x17ab
// Size: 0x26
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
    
    /#
        br_dev::registerhandlecommand( &handledevcommand );
    #/
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x7ec66bd1, Offset: 0x17d9
// Size: 0xbb
function init()
{
    level thread brtruck_initfeatures();
    level thread brtruck_initpostmain();
    level thread brtruck_initdialog();
    level thread brtruck_initexternalfeatures();
    level.respawntimedisable = getdvarint( @"hash_e12689cc1f69a798", 0 );
    level.var_b72044e6a28b0fee = 0;
    level.var_56856119e1f4aeab = 1;
    level.var_32cd3f9427fdc5d9 = 1;
    level.var_5aaf90dc70b33ffa = 1;
    level.var_6beba419b29a0d9a = getdvarint( @"hash_e1a4b7a04f5a3725", 1 );
    scriptable::scriptable_addusedcallbackbypart( "tag_buystation", &function_1f7bd6492d2cb8c4 );
    level init_airdrop_anims();
    level thread function_1b0f8de5bbacb8a8();
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnectcallback );
    
    /#
        setdevdvarifuninitialized( @"scr_brtruck_debug", 0 );
    #/
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x28aa2d02, Offset: 0x189c
// Size: 0x83
function brtruck_initfeatures()
{
    if ( getdvarint( @"scr_brtruck_debug", 0 ) )
    {
        br_gametypes::disablefeature( #"dropbag" );
        br_gametypes::enablefeature( #"allowlatejoiners" );
    }
    
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"hash_3be0ee0c8d77495b" );
    br_gametypes::disablefeature( #"hash_de234998671449be" );
    br_gametypes::enablefeature( #"tabletreplace" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x5de7d64e, Offset: 0x1927
// Size: 0x298
function brtruck_initpostmain()
{
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &brtruck_playerwelcomesplashes );
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &onstartgametype );
    utility::registersharedfunc( #"gametype", #"playerkilledspawn", &playerkilledspawn );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &markplayeraseliminatedonkilled );
    utility::registersharedfunc( #"gametype", #"mayconsiderplayerdead", &mayconsiderplayerdead );
    utility::registersharedfunc( #"gametype", #"isteameliminated", &isteameliminated );
    utility::registersharedfunc( #"gametype", #"infilsequence", &function_da2d7b41e0f0c1de );
    utility::registersharedfunc( #"gametype", #"playernakeddroploadout", &function_c559e80362faafd9 );
    utility::registersharedfunc( #"gametype", #"hash_787878f1f37fb59c", &function_ef8cda80afe9762f );
    callback::add( #"hash_440e335c78393d75", &function_a027f48d03a84f14 );
    callback::add( #"hash_440e335c78393d75", &function_26f67459cca2c108 );
    callback::add( #"hash_8ba167d45892409f", &function_12a764dabfc89d9f );
    callback::add( #"hash_3aad9cf39ea1d0b5", &function_d5f349836dfd62c6 );
    callback::add( #"hash_d887e9a56615924c", &function_b4c7c90a45e7e9fd );
    waittillframeend();
    flags::gameflaginit( "use_truck_respawn", 0 );
    level.ontimelimit = &brtruck_ontimelimit;
    level.modeplayerkilledspawn = &playerkilledspawn;
    brtruck_cleanupents();
    level.validautoassignquests = [];
    level.validautoassignquests[ 0 ] = "assassination";
    level.validautoassignquests[ 1 ] = "domination";
    level.validautoassignquests[ 2 ] = "scavenger";
    
    if ( !isdefined( level.var_7d2432d8f71c014a ) )
    {
        level.var_7d2432d8f71c014a = vehicle_interact::get_data( %"hash_1c8a00baf3a72043" ).maxfuel;
    }
    
    if ( !vehicle::has_data( %"hash_1c8a00baf3a72043" ) )
    {
        vehicle::generic_init( %"hash_1c8a00baf3a72043" );
    }
    
    spawnorigins = utility::getstructarray( "mp_truckwar_team_start_spawn", "targetname" );
    
    if ( spawnorigins.size == 0 )
    {
        function_8f4c559dabb85ea2();
    }
    
    function_e4e0ef6739c29dbd();
    
    /#
        if ( level.br_infils_disabled )
        {
            level waittill( #"prematch_started" );
            function_da2d7b41e0f0c1de( level.players );
        }
    #/
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xf9cc3b5, Offset: 0x1bc7
// Size: 0x13e
function brtruck_initdialog()
{
    level endon( #"game_ended" );
    game[ "dialog" ][ "match_start" ] = "trkw_wzan_mdnt";
    game[ "dialog" ][ "primary_objective" ] = "trkw_wzan_mdbs";
    game[ "dialog" ][ "vehicle_spawn_enabled" ] = "trkw_wzan_vsnb";
    game[ "dialog" ][ "vehicle_spawn_disabled" ] = "trkw_wzan_vsds";
    game[ "dialog" ][ "vehicle_under_attack" ] = "trkw_wzan_vndt";
    game[ "dialog" ][ "vehicle_destroyed" ] = "trkw_wzan_vhcd";
    game[ "dialog" ][ "vehicle_spawn_over" ] = "trkw_wzan_vsvr";
    game[ "dialog" ][ "armor_upgraded" ] = "trkw_wzan_armr";
    game[ "dialog" ][ "trophy_activated" ] = "trkw_wzan_trph";
    game[ "dialog" ][ "uav_activated" ] = "trkw_wzan_uav0";
    game[ "dialog" ][ "barrel_activated" ] = "trkw_wzan_brrl";
    game[ "dialog" ][ "grenade_turret_activated" ] = "trkw_wzan_trrt";
    game[ "dialog" ][ "engine_activated" ] = "trkw_wzan_engn";
    game[ "dialog" ][ "smoke_activated" ] = "trkw_wzan_smke";
    game[ "dialog" ][ "reminder_purchase" ] = "trkw_wzan_rmdp";
    game[ "dialog" ][ "resurgence_on_player_disconnect" ] = "rsrg_wzan_tmrd";
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xc75d2988, Offset: 0x1d0d
// Size: 0x3d
function brtruck_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x5498f0bb, Offset: 0x1d52
// Size: 0x1b
function brtruck_initexternalfeatures()
{
    level._effect[ "light_tank_land" ] = loadfxasset( "vfx_iw8_mp_strk_tank_dropoff_dust" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xbe444c8a, Offset: 0x1d75
// Size: 0x19
function onstartgametype()
{
    initspawns();
    level thread function_4602cb8ff3f27e83();
    level thread function_eb63a210f2a01d1();
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x30b09d0e, Offset: 0x1d96
// Size: 0xe7
function brtruck_playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    
    if ( !self.pers[ "streamSyncComplete" ] )
    {
        self waittill( #"player_active" );
    }
    
    wait 1;
    hud_message::showsplash( "br_gametype_truckwar_prematch_welcome" );
    self waittill( #"hash_6f9c96fc31ef495f" );
    wait 2;
    soundalias = br_public::function_98922162e13bc0aa( "match_start", "dx_br_bds5_" );
    soundlength = undefined;
    
    if ( isdefined( soundalias ) && soundexists( soundalias ) )
    {
        soundlength = lookupsoundlength( soundalias ) * 0.001 + 2;
    }
    
    thread function_9a239f9311a3d2e2( "match_start", [ self ] );
    thread function_9a239f9311a3d2e2( "primary_objective", [ self ], soundlength );
    br_gametype_dmz::showdmzsplash( "truckwar_welcome", [ self ] );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x9f567027, Offset: 0x1e85
// Size: 0x23
function brtruck_ontimelimit()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xed15849, Offset: 0x1eb0
// Size: 0xe, Type: bool
function mayconsiderplayerdead( player )
{
    return true;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xacb76265, Offset: 0x1ec7
// Size: 0x4, Type: bool
function markplayeraseliminatedonkilled()
{
    return true;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x34ae9b15, Offset: 0x1ed4
// Size: 0x6b
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    return spawndata;
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xa5cece95, Offset: 0x1f48
// Size: 0xb4
function vehiclespawn_mrap( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    spawndata.var_c95d646de6b9216c = 1;
    spawndata.disablepopsmoke = 1;
    spawndata.var_5deb24d6fac0806b = 1;
    spawndata.var_be20d52d9ea88e67 = 1;
    mrap = vehicle::spawn( %"hash_1c8a00baf3a72043", spawndata, faildata );
    mrap setscriptablepartstate( "tag_buystation", "buystation_usable" );
    return mrap;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x148afcd3, Offset: 0x2005
// Size: 0x2aa
function function_54562d0670f3676d()
{
    vehiclespawnlocs = [];
    level.var_c79684ec84b304ff = [];
    vehiclespawnlocs = gettruckspawns( %"hash_1c8a00baf3a72043" );
    
    /#
        if ( getdvarint( @"hash_5b092e4db5e16870", 0 ) )
        {
            foreach ( loc in vehiclespawnlocs )
            {
                thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
                thread debug::drawangles( loc.origin, loc.angles, 1000, 100 );
            }
        }
    #/
    
    vehiclespawnlocs = arrayrandomize( vehiclespawnlocs );
    iter = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( teams::getteamdata( entry, "players" ).size == 0 )
        {
            continue;
        }
        
        while ( iter < vehiclespawnlocs.size )
        {
            loc = vehiclespawnlocs[ iter ];
            
            if ( isdefined( loc ) )
            {
                level.var_c79684ec84b304ff[ entry ] = loc;
                iter++;
                break;
            }
            
            iter++;
        }
    }
    
    /#
        if ( getdvarint( @"hash_5dcf2d7ccd054652", 0 ) )
        {
            foreach ( loc in level.var_c79684ec84b304ff )
            {
                thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
                thread debug::drawangles( loc.origin, loc.angles, 1000, 100 );
            }
        }
    #/
    
    flags::gameflagset( "trucks_spawn_complete" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xce522f18, Offset: 0x22b7
// Size: 0x98
function spawnvehicles()
{
    level.teamvehicles = [];
    
    foreach ( team, loc in level.var_c79684ec84b304ff )
    {
        vehicle = vehiclespawn_mrap( loc );
        function_172dbee6aed28df8( vehicle, team );
    }
}

// Namespace br_gametype_truckwar
// Params 3
// Checksum 0x642dcac6, Offset: 0x2357
// Size: 0x1c5
function function_172dbee6aed28df8( vehicle, team, revive )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    level.teamvehicles[ team ] = vehicle;
    level.teamcanrespawn[ team ] = 1;
    setomnvar( "ui_truckwar_trucks_remaining", level.teamvehicles.size );
    level thread watchvehicleingas( vehicle, team );
    level thread function_bc61637f47712260( vehicle, team );
    level thread function_c8f4a5aed4ee8038( vehicle, team );
    level thread notifyteamonvehicledeath( vehicle, team );
    level thread function_bbec6c2902ed71cf( vehicle, team );
    level thread function_d6e00c251f78e440( vehicle, team );
    vehicle_occupancy::set_team( vehicle, team );
    vehicle setscriptablepartstate( "objective", "on" );
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", vehicle.health );
        player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", vehicle.maxhealth );
        
        if ( revive && getdvarint( @"hash_51df9c2ca5ee638", 1 ) == 1 && !level.var_17422c7ae7ff00b )
        {
            if ( player.br_iseliminated )
            {
                player.setspawnpoint = undefined;
                player thread playerrespawn( 1 );
            }
        }
    }
    
    function_9dc94b913e50a1ae( vehicle );
    function_11aa8ee05b7575e2( team );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x91ae4481, Offset: 0x2524
// Size: 0x4a6
function watchvehicleingas( vehicle, team )
{
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    vehicle.var_5e6f28c62a40dbc = 0;
    vehicle.var_b615ac03e89528d7 = 0;
    vehicle.var_e1e3711b9a0e03f9 = 0;
    var_2b26a1893be2cf49 = getdvarfloat( @"hash_6e9602adcd53f742", 15 );
    var_c4a2a0247538a34c = getdvarfloat( @"hash_88fad367b10fc4cd", 30 );
    var_c5ac7928352d02e8 = getdvarfloat( @"hash_593518c70a322693", 45 );
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player utility::ent_flag_init( "respawn_vehicle_in_gas" );
    }
    
    while ( isdefined( vehicle ) )
    {
        if ( vehicle.infilling )
        {
            waitframe();
            continue;
        }
        
        if ( level.circleclosing )
        {
            if ( !vehicle.var_5e6f28c62a40dbc && checkdangerradius( vehicle.origin, var_2b26a1893be2cf49 ) )
            {
                showsplashtoteam( team, "truckwar_gas_close" );
                vehicle.var_5e6f28c62a40dbc = 1;
                vehicle.var_b615ac03e89528d7 = 1;
                vehicle.var_e1e3711b9a0e03f9 = 1;
            }
            else if ( !vehicle.var_b615ac03e89528d7 && checkdangerradius( vehicle.origin, var_c4a2a0247538a34c ) )
            {
                showsplashtoteam( team, "truckwar_gas_medium" );
                vehicle.var_b615ac03e89528d7 = 1;
                vehicle.var_e1e3711b9a0e03f9 = 1;
            }
            else if ( !vehicle.var_e1e3711b9a0e03f9 && checkdangerradius( vehicle.origin, var_c5ac7928352d02e8 ) )
            {
                showsplashtoteam( team, "truckwar_gas_far" );
                vehicle.var_e1e3711b9a0e03f9 = 1;
            }
        }
        else
        {
            vehicle.var_5e6f28c62a40dbc = 0;
            vehicle.var_b615ac03e89528d7 = 0;
            vehicle.var_e1e3711b9a0e03f9 = 0;
        }
        
        dangercircleorigin = br_circle::getdangercircleorigin();
        dangercircleradius = br_circle::getdangercircleradius();
        var_3677494f3b58c5a3 = getdvarint( @"hash_54e04086872e7d2c", 0 );
        
        if ( var_3677494f3b58c5a3 || distance2dsquared( dangercircleorigin, vehicle.origin ) > dangercircleradius * dangercircleradius )
        {
            vehicle thread function_cb8d358555502bc9();
            
            if ( level.teamcanrespawn[ team ] == 1 )
            {
                level.teamcanrespawn[ team ] = 0;
                players = teams::getteamdata( team, "players" );
                
                foreach ( player in players )
                {
                    player utility::ent_flag_set( "respawn_vehicle_in_gas" );
                }
                
                showsplashtoteam( team, "truckwar_vehicle_spawn_disabled" );
                thread function_9a239f9311a3d2e2( "vehicle_spawn_disabled", level.teamdata[ team ][ "players" ] );
                level thread [[ level.updategameevents ]]();
            }
        }
        else if ( level.teamcanrespawn[ team ] == 0 )
        {
            vehicle notify( #"hash_90d1da948bbbf5ae" );
            vehicle.var_2495c3aace0bfb8d = 0;
            level.teamcanrespawn[ team ] = 1;
            players = teams::getteamdata( team, "players" );
            
            foreach ( player in players )
            {
                player utility::ent_flag_clear( "respawn_vehicle_in_gas" );
            }
            
            showsplashtoteam( team, "truckwar_vehicle_spawn_enabled" );
            thread function_9a239f9311a3d2e2( "vehicle_spawn_enabled", level.teamdata[ team ][ "players" ] );
            level thread [[ level.updategameevents ]]();
        }
        
        waitframe();
    }
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xb7dfc33b, Offset: 0x29d2
// Size: 0x91
function function_cb8d358555502bc9()
{
    self endon( #"death" );
    self endon( #"hash_90d1da948bbbf5ae" );
    
    if ( self.var_2495c3aace0bfb8d )
    {
        return;
    }
    
    self.var_2495c3aace0bfb8d = 1;
    damagepct = getdvarfloat( @"hash_a705a5caa6ea4daf", 0.05 );
    damageamount = self.maxhealth * damagepct;
    
    while ( isdefined( self ) )
    {
        wait 1;
        self dodamage( damageamount, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x5afbee54, Offset: 0x2a6b
// Size: 0x21b
function function_bc61637f47712260( vehicle, team )
{
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    vehicle.oobtime = 0;
    var_54e745a8433a6c4a = getdvarfloat( @"hash_38e9f472cca85346", 15 );
    var_69c8363c2604bc2f = getdvarfloat( @"hash_32657fe607d73d8c", 5 );
    wasempty = vehicle.isempty;
    wasoob = 0;
    emptytime = undefined;
    
    while ( true )
    {
        if ( !wasempty && vehicle.isempty )
        {
            emptytime = gettime() + var_54e745a8433a6c4a * 1000;
        }
        
        wasempty = vehicle.isempty;
        
        if ( gettime() < emptytime || wasoob )
        {
            isoob = 0;
            inflictor = undefined;
            
            foreach ( trigger in level.outofboundstriggers )
            {
                if ( vehicle istouching( trigger ) )
                {
                    vehicle.oobtime += level.framedurationseconds;
                    isoob = 1;
                    inflictor = trigger;
                    break;
                }
            }
            
            wasoob = isoob;
            
            if ( !isoob )
            {
                vehicle.oobtime -= level.framedurationseconds;
            }
            
            vehicle.oobtime = clamp( vehicle.oobtime, 0, var_69c8363c2604bc2f );
            
            if ( vehicle.oobtime == var_69c8363c2604bc2f )
            {
                vehicle dodamage( 999999, vehicle.origin, inflictor, inflictor, "MOD_TRIGGER_HURT" );
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x352a92bd, Offset: 0x2c8e
// Size: 0x219
function function_c8f4a5aed4ee8038( vehicle, team )
{
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    ignoretime = getdvarfloat( @"hash_def42f45937be461", 15 ) * 1000;
    lastplayedtime = undefined;
    
    while ( isdefined( vehicle ) )
    {
        vehicle waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        vehicle.lastdamagedtime = gettime();
        function_11aa8ee05b7575e2( team );
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", vehicle.health );
            player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", vehicle.maxhealth );
        }
        
        if ( smeansofdeath == "MOD_TRIGGER_HURT" || isdefined( eattacker ) && eattacker.classname == "worldspawn" )
        {
            continue;
        }
        
        if ( lastplayedtime + ignoretime > gettime() )
        {
            continue;
        }
        
        lastplayedtime = gettime();
        players = teams::getteamdata( team, "players" );
        showsplashtoteam( team, "truckwar_vehicle_under_attack" );
        thread function_9a239f9311a3d2e2( "vehicle_under_attack", level.teamdata[ team ][ "players" ] );
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x65a883aa, Offset: 0x2eaf
// Size: 0x78
function blockhealing( team )
{
    self endon( #"death" );
    self notify( #"blockhealing" );
    self endon( #"blockhealing" );
    self.healingblocked = 1;
    function_11aa8ee05b7575e2( team );
    ignoretime = getdvarfloat( @"hash_aa27dea6d1c24ca3", 15 );
    wait ignoretime;
    self.healingblocked = 0;
    function_11aa8ee05b7575e2( team );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xbefd4c2b, Offset: 0x2f2f
// Size: 0x99
function function_bbec6c2902ed71cf( vehicle, team )
{
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    
    while ( isdefined( vehicle ) )
    {
        vehicle waittill( #"upgrade_message", message );
        
        if ( message != "trophy_ammo_used" )
        {
            if ( message == "trophy_no_ammo" )
            {
                showsplashtoteam( team, "truckwar_vehicle_trophy_no_ammo" );
            }
            
            thread function_9a239f9311a3d2e2( message, level.teamdata[ team ][ "players" ] );
        }
        
        function_11aa8ee05b7575e2( team );
    }
}

// Namespace br_gametype_truckwar
// Params 2, eflags: 0x4
// Checksum 0x3ce953f1, Offset: 0x2fd0
// Size: 0xc5
function private function_d6e00c251f78e440( vehicle, team )
{
    level endon( #"game_ended" );
    vehicle endon( #"death" );
    vehicle endon( #"give_upgrade" );
    wait 60;
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player br_ftue_popups::ftue_triggertip( "br_ftue_truckwar_upgrade" );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xe663aaf2, Offset: 0x309d
// Size: 0x1d1
function notifyteamonvehicledeath( vehicle, team )
{
    level endon( #"game_ended" );
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player utility::ent_flag_init( "respawn_vehicle_death" );
    }
    
    vehicle waittill( #"death" );
    level.teamcanrespawn[ team ] = 0;
    level.teamvehicles[ team ] = undefined;
    setomnvar( "ui_truckwar_trucks_remaining", level.teamvehicles.size );
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", 0 );
        player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", 1 );
        player utility::ent_flag_set( "respawn_vehicle_death" );
    }
    
    showsplashtoteam( team, "truckwar_vehicle_destroyed" );
    thread function_9a239f9311a3d2e2( "vehicle_destroyed", level.teamdata[ team ][ "players" ] );
    thread function_175c5fdcc55f777e( team );
    level thread [[ level.updategameevents ]]();
    function_11aa8ee05b7575e2( team );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x23165027, Offset: 0x3276
// Size: 0x68
function function_175c5fdcc55f777e( team )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waittime = randomfloatrange( 180, 300 );
        wait waittime;
        
        if ( level.teamcanrespawn[ team ] )
        {
            break;
        }
        
        thread function_9a239f9311a3d2e2( "reminder_purchase", level.teamdata[ team ][ "players" ] );
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x35f57637, Offset: 0x32e6
// Size: 0x222
function gettruckspawns( vehicleref )
{
    if ( getdvarint( @"hash_692b4b274d3b7bdc", 0 ) == 0 )
    {
        spawns = getpresettruckspawns( vehicleref );
        
        if ( spawns.size > 0 )
        {
            return spawns;
        }
    }
    
    numvehicles = level.teamnamelist.size;
    validteamcount = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( teams::getteamdata( entry, "players" ).size > 0 )
        {
            validteamcount++;
        }
    }
    
    numvehicles = validteamcount;
    anglestep = 360 / numvehicles;
    circlecenter = ( 0, 0, 100 );
    
    if ( level.mapname == "mp_rew_mechanics" )
    {
        circlecenter = ( 0, 0, 100 );
        circleradius = 5000;
    }
    else
    {
        circlecenter = ( 0, 0, 100 );
        circleradius = 40000;
    }
    
    tracecontents = trace::create_default_contents( 1 );
    spawns = [];
    
    for ( i = 0; i < numvehicles ; i++ )
    {
        angles = i * anglestep;
        forward = anglestoforward( ( 0, angles, 0 ) );
        origin = circlecenter + forward * circleradius;
        groundorigin = br_public::droptogroundmultitrace( origin, 10000, -20000, tracecontents );
        origin = ( origin[ 0 ], origin[ 1 ], groundorigin[ 2 ] + 200 );
        vehicle = spawnstruct();
        vehicle.origin = origin;
        vehicle.angles = vectortoangles( forward * -1 );
        vehicle.script_vehiclebundle = vehicleref;
        spawns[ spawns.size ] = vehicle;
    }
    
    return spawns;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x47b78498, Offset: 0x3511
// Size: 0x1b6
function getpresettruckspawns( vehicleref )
{
    spawnorigins = [];
    spawnorigins = utility::getstructarray( "mp_truckwar_team_start_spawn", "targetname" );
    
    if ( spawnorigins.size == 0 )
    {
        return;
    }
    
    spawnorigins = arrayrandomize( spawnorigins );
    tracecontents = trace::create_default_contents( 1 );
    var_7e00d769be845b83 = 0;
    
    foreach ( struct in spawnorigins )
    {
        groundorigin = br_public::droptogroundmultitrace( struct.origin, 10000, -20000, tracecontents );
        origin = ( struct.origin[ 0 ], struct.origin[ 1 ], groundorigin[ 2 ] + 200 );
        struct.origin = origin;
        var_7e00d769be845b83++;
        
        if ( var_7e00d769be845b83 >= 5 )
        {
            var_7e00d769be845b83 = 0;
            waitframe();
        }
    }
    
    spawns = [];
    numvehicles = spawnorigins.size;
    
    for ( i = 0; i < numvehicles ; i++ )
    {
        vehicle = spawnstruct();
        vehicle.origin = spawnorigins[ i ].origin;
        vehicle.angles = spawnorigins[ i ].angles;
        vehicle.script_vehiclebundle = vehicleref;
        spawns[ spawns.size ] = vehicle;
    }
    
    return spawns;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x8348df59, Offset: 0x36d0
// Size: 0xea
function gethelispawns( vehicleref )
{
    spawns = [];
    numvehicles = 3;
    anglestep = 360 / numvehicles;
    circlecenter = ( 0, 0, 100 );
    var_9970e3563eb440ae = 1000;
    
    for ( i = 0; i < numvehicles ; i++ )
    {
        angles = i * anglestep;
        forward = anglestoforward( ( 0, angles, 0 ) );
        origin = circlecenter + forward * var_9970e3563eb440ae;
        vehicle = spawnstruct();
        vehicle.origin = origin;
        vehicle.angles = vectortoangles( forward * -1 );
        vehicle.script_vehiclebundle = vehicleref;
        spawns[ spawns.size ] = vehicle;
    }
    
    return spawns;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x2793e3de, Offset: 0x37c3
// Size: 0x49, Type: bool
function isteameliminated( team )
{
    if ( !isdefined( level.teamcanrespawn ) )
    {
        return false;
    }
    
    return teams::getteamdata( team, "aliveCount" ) == 0 && ( !level.teamcanrespawn[ team ] || level.var_17422c7ae7ff00b );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x9e24ba94, Offset: 0x3815
// Size: 0x53, Type: bool
function playerkilledspawn( deathdata, finaldeath )
{
    if ( !flags::gameflag( "use_truck_respawn" ) )
    {
        return false;
    }
    
    deathdata.victim thread playerrespawn( 0, deathdata, finaldeath );
    deathdata.victim thread br_spectate::spawnspectator( deathdata, finaldeath );
    return true;
}

// Namespace br_gametype_truckwar
// Params 3
// Checksum 0xc79879a8, Offset: 0x3871
// Size: 0x482
function playerrespawn( fastrespawn, deathdata, finaldeath )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"gulag_auto_win" );
    self notify( #"hash_4aa49f3172087f84" );
    self endon( #"hash_4aa49f3172087f84" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( level.var_17422c7ae7ff00b || isteameliminated( self.team ) || utility::ent_flag_exist( "respawn_vehicle_death" ) && utility::ent_flag( "respawn_vehicle_death" ) )
    {
        thread br_spectate::triggereliminatedoverlay();
        return;
    }
    
    if ( getdvarint( @"hash_1560eca11fd78307", 1 ) )
    {
        self endon( #"hash_36e455a1fbf78b10" );
    }
    
    spawnwait = getplayerrespawndelay( self );
    
    if ( fastrespawn )
    {
        spawnwait = 0;
    }
    
    var_7ae41cb151b43258 = getdvarint( @"hash_de56eb4b8051c0e", 5 );
    
    if ( spawnwait < var_7ae41cb151b43258 )
    {
        spawnwait = var_7ae41cb151b43258;
    }
    
    if ( level.respawntimedisable != 0 )
    {
        spawnwait = 0;
    }
    
    utility::ent_flag_init( "playerRespawn_intermission_spawned" );
    self.intermissionspawnorigin = undefined;
    self.intermissionspawntime = undefined;
    prestreamwait = spawnwait - var_7ae41cb151b43258;
    var_5061bd2ffc2167a1 = spawnwait - prestreamwait;
    
    if ( spawnwait > 0 )
    {
        function_48f47bc7ebb0f49f( self );
        thread function_3c36689d86bb7a4d( self, spawnwait );
    }
    
    result = utility::waittill_notify_or_timeout_return( "respawn_vehicle_death", prestreamwait );
    
    if ( result != "respawn_vehicle_death" )
    {
        thread updateprestreamrespawn();
        result = utility::waittill_notify_or_timeout_return( "respawn_vehicle_death", var_5061bd2ffc2167a1 );
    }
    
    self notify( #"hash_90ac94f1376250d4" );
    thread fadeoutin();
    function_961895d2525b22fe( self );
    wait 0.5;
    
    if ( utility::ent_flag_exist( "respawn_vehicle_death" ) && utility::ent_flag( "respawn_vehicle_death" ) )
    {
        thread br_spectate::setbuybackpingmessage();
    }
    else if ( utility::ent_flag( "respawn_vehicle_in_gas" ) )
    {
        lower_message::setlowermessageomnvar( "vehicle_in_gas" );
    }
    
    while ( utility::ent_flag_exist( "respawn_vehicle_death" ) && !utility::ent_flag( "respawn_vehicle_death" ) && !level.teamcanrespawn[ self.team ] || utility::isusingremote() )
    {
        waitframe();
    }
    
    if ( utility::ent_flag_exist( "respawn_vehicle_death" ) && utility::ent_flag( "respawn_vehicle_death" ) )
    {
        thread br_spectate::setbuybackpingmessage();
    }
    
    if ( isteameliminated( self.team ) || utility::ent_flag_exist( "respawn_vehicle_death" ) && utility::ent_flag( "respawn_vehicle_death" ) )
    {
        thread br_spectate::spawnspectator( deathdata, finaldeath );
        thread br_spectate::triggereliminatedoverlay();
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
        br_spawnrespawn::function_24b79e9319c6f02f();
        return;
    }
    
    spawnpoint = getspawnpoint();
    streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
    flareorigin = level.teamvehicles[ self.team ].origin;
    
    if ( !getdvarint( @"scr_skip_respawn_gate", 1 ) )
    {
        streamhint::playerwaittillstreamhintcomplete();
    }
    
    utility::ent_flag_clear( "playerRespawn_intermission_spawned" );
    self.intermissionspawnorigin = undefined;
    self.intermissionspawntime = undefined;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    playerlogic::spawnplayer( undefined, 0 );
    self.cachedomnars = [];
    execution::_clearexecution();
    br_pickups::initplayer();
    br_gulag::gulagwinnerrespawn( 1, undefined, spawnpoint, 1, streamorigin, 1, undefined, 0, 0, 1 );
    spawnangles = vectortoangles( flareorigin - streamorigin );
    self setplayerangles( spawnangles );
    self notify( #"hash_e6e12d076dc31b0a" );
    br_utility::unmarkplayeraseliminated( self );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_respawn" );
    
    if ( isdefined( level.teamvehicles[ self.team ] ) )
    {
        flareorigin = level.teamvehicles[ self.team ].origin;
        omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", level.teamvehicles[ self.team ].health );
        omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", level.teamvehicles[ self.team ].maxhealth );
    }
    
    level thread br_quest_util::utilflare_shootflare( flareorigin, "revive" );
    omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
    function_11aa8ee05b7575e2( self.team );
}

// Namespace br_gametype_truckwar
// Params 0, eflags: 0x4
// Checksum 0x72c1e9d3, Offset: 0x3cfb
// Size: 0x20e
function private function_b4a7448f7473d6d6()
{
    level.brgametype.respawndelay[ "_solos" ][ 0 ] = getdvarint( @"hash_bc01b0a06d2dbde9", 15 );
    level.brgametype.respawndelay[ "_solos" ][ 1 ] = getdvarint( @"hash_bc01ada06d2db750", 20 );
    level.brgametype.respawndelay[ "_solos" ][ 2 ] = getdvarint( @"hash_bc01aea06d2db983", 30 );
    level.brgametype.respawndelay[ "_duos" ][ 0 ] = getdvarint( @"hash_fc1ef4784978935a", 15 );
    level.brgametype.respawndelay[ "_duos" ][ 1 ] = getdvarint( @"hash_fc1ef37849789127", 20 );
    level.brgametype.respawndelay[ "_duos" ][ 2 ] = getdvarint( @"hash_fc1ef27849788ef4", 30 );
    level.brgametype.respawndelay[ "_trios" ][ 0 ] = getdvarint( @"hash_cc07978496a297a0", 20 );
    level.brgametype.respawndelay[ "_trios" ][ 1 ] = getdvarint( @"hash_cc079a8496a29e39", 30 );
    level.brgametype.respawndelay[ "_trios" ][ 2 ] = getdvarint( @"hash_cc07998496a29c06", 40 );
    level.brgametype.respawndelay[ "_quads" ][ 0 ] = getdvarint( @"hash_f5bdd5587fd7f1f9", 25 );
    level.brgametype.respawndelay[ "_quads" ][ 1 ] = getdvarint( @"hash_f5bdd2587fd7eb60", 35 );
    level.brgametype.respawndelay[ "_quads" ][ 2 ] = getdvarint( @"hash_f5bdd3587fd7ed93", 45 );
}

// Namespace br_gametype_truckwar
// Params 1, eflags: 0x4
// Checksum 0x6c83f076, Offset: 0x3f11
// Size: 0x10c
function private function_1aaa7925671e019c( player )
{
    suffixindex = game_utility::function_f24780eadd3fb772() - 1;
    
    if ( level.brgametype.var_b814b89099323daf )
    {
        players = player::getteamarray( player.team );
        suffixindex = players.size - 1;
        
        foreach ( player in players )
        {
            if ( isdefined( player ) && player rejoin_utility::function_e421863f0f4de34() )
            {
                suffixindex--;
            }
        }
    }
    
    suffixindex = int( max( min( suffixindex, level.brgametype.var_d6e8c19828251ec.size - 1 ), 0 ) );
    return level.brgametype.var_d6e8c19828251ec[ suffixindex ];
}

// Namespace br_gametype_truckwar
// Params 1, eflags: 0x4
// Checksum 0x6576fa4e, Offset: 0x4026
// Size: 0xa8
function private getplayerrespawndelay( player )
{
    var_3f19c998c4c894e8 = function_1aaa7925671e019c( player );
    
    if ( level.br_circle.circleindex < 0 )
    {
        return level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ 0 ];
    }
    
    circleindex = int( min( level.br_circle.circleindex, level.brgametype.respawndelay[ var_3f19c998c4c894e8 ].size - 1 ) );
    return level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ circleindex ];
}

// Namespace br_gametype_truckwar
// Params 2, eflags: 0x4
// Checksum 0x4facf157, Offset: 0x40d7
// Size: 0x65
function private function_3c36689d86bb7a4d( player, time )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"respawn_vehicle_death" );
    
    while ( time >= 0 )
    {
        function_d31e3da1741dcefc( player, time );
        player br_public::updatebrscoreboardstat( "respawnInSeconds", time );
        time--;
        wait 1;
    }
}

// Namespace br_gametype_truckwar
// Params 1, eflags: 0x4
// Checksum 0x61b6be2a, Offset: 0x4144
// Size: 0x41
function private function_48f47bc7ebb0f49f( player )
{
    currentvalue = player getclientomnvar( "ui_resurgenceRespawnTimer" );
    newvalue = currentvalue | 16384;
    player setclientomnvar( "ui_resurgenceRespawnTimer", newvalue );
}

// Namespace br_gametype_truckwar
// Params 1, eflags: 0x4
// Checksum 0x835b5f71, Offset: 0x418d
// Size: 0x42
function private function_961895d2525b22fe( player )
{
    currentvalue = player getclientomnvar( "ui_resurgenceRespawnTimer" );
    newvalue = currentvalue & ~16384;
    player setclientomnvar( "ui_resurgenceRespawnTimer", newvalue );
}

// Namespace br_gametype_truckwar
// Params 2, eflags: 0x4
// Checksum 0xd4b8d2e5, Offset: 0x41d7
// Size: 0x67
function private function_d31e3da1741dcefc( player, value )
{
    assert( value <= 16383 );
    currentvalue = player getclientomnvar( "ui_resurgenceRespawnTimer" );
    otherbits = currentvalue & ~16383;
    newvalue = otherbits | value;
    player setclientomnvar( "ui_resurgenceRespawnTimer", newvalue );
}

// Namespace br_gametype_truckwar
// Params 0, eflags: 0x4
// Checksum 0x88d69988, Offset: 0x4246
// Size: 0x3d4
function private function_eb63a210f2a01d1()
{
    level endon( #"game_ended" );
    level.brgametype.respawnenable = 1;
    level.brgametype.respawndelay = [];
    level.brgametype.var_d6e8c19828251ec = [ "_solos", "_duos", "_trios", "_quads" ];
    level.brgametype.var_b814b89099323daf = getdvarint( @"hash_ecd9594bd7c0b2ad", 1 );
    level.brgametype.var_93e3aff6526320c = getdvarint( @"hash_ca8ddd67c2b5771a", 1 );
    level.brgametype.var_90ce4bd9339d98df = getdvarint( @"hash_24d595ecd1de09dc", 1 ) && level.brgametype.var_b814b89099323daf;
    level.brgametype.var_fe19b5fef3861981 = getdvarint( @"hash_895f0d248f2c4008", 1 ) && level.brgametype.var_93e3aff6526320c;
    level.brgametype.issolos = game_utility::function_f24780eadd3fb772() == 1;
    setomnvar( "ui_br_resurgence_respawn_enabled", 1 );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "prematch_fade_done" );
    thread function_b4a7448f7473d6d6();
    thread function_ff69cfc40d1a03c8();
    endcircle = function_e574c9fcbabc21e2();
    
    foreach ( var_3f19c998c4c894e8 in level.brgametype.var_d6e8c19828251ec )
    {
        for ( i = 0; i < endcircle ; i++ )
        {
            overridedelay = getdvarint( hashcat( @"hash_fd72eab87b422f51", i + 1, var_3f19c998c4c894e8 ), -1 );
            
            if ( overridedelay >= 0 )
            {
                level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ i ] = overridedelay;
                continue;
            }
            
            if ( i >= level.brgametype.respawndelay[ var_3f19c998c4c894e8 ].size )
            {
                level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ i ] = level.brgametype.respawndelay[ var_3f19c998c4c894e8 ][ i - 1 ];
            }
        }
    }
    
    waittime = 0;
    
    for ( i = 0; i < endcircle ; i++ )
    {
        waittime += level.br_level.br_circleclosetimes[ i ] + level.br_level.br_circledelaytimes[ i ];
    }
    
    waittimems = int( waittime * 1000 );
    maxwaittimems = getdvarint( @"hash_342776b421ce99fa", 90000 );
    level waittill( #"infils_ready" );
    var_7328c0eb42203f74 = waittimems - maxwaittimems;
    
    if ( var_7328c0eb42203f74 > 0 )
    {
        wait var_7328c0eb42203f74 * 0.001;
        waittimems = maxwaittimems;
    }
    
    setomnvarforallclients( "ui_br_resurgence_will_disable", 1 );
    setomnvarforallclients( "ui_br_timed_feature_end_time", int( gettime() + waittimems ) );
    wait waittimems * 0.001;
    setomnvarforallclients( "ui_br_timed_feature_end_time", 0 );
    level.brgametype.respawnenable = 0;
    level.brgametype.var_93e3aff6526320c = 0;
    level.brgametype.var_fe19b5fef3861981 = 0;
}

// Namespace br_gametype_truckwar
// Params 0, eflags: 0x4
// Checksum 0x2bb42174, Offset: 0x4622
// Size: 0x7c
function private function_ff69cfc40d1a03c8()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    level.brgametype.var_43128cc0ca31e60f = rejoin_utility::function_5ed88373949103a8() && getdvarint( @"hash_925f7dceb8e6205e", 0 ) && getdvarint( @"hash_fa76fc54e37da65d", 1 );
    
    if ( level.brgametype.var_43128cc0ca31e60f )
    {
        rejoin_utility::function_70467cdf042579e5( &function_daa0a1414322c582 );
    }
}

// Namespace br_gametype_truckwar
// Params 1, eflags: 0x4
// Checksum 0xfd0ad363, Offset: 0x46a6
// Size: 0x10e
function private function_daa0a1414322c582( player )
{
    if ( !flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( level.brgametype.issolos )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    if ( !level.brgametype.var_b814b89099323daf )
    {
        return;
    }
    
    if ( level.brgametype.var_90ce4bd9339d98df )
    {
        remainingplayers = player::getteamarray( player.team );
        
        foreach ( remainingplayer in remainingplayers )
        {
            remainingplayer thread hud_message::showsplash( "truckwar_ally_rejoin_improvement", undefined, player );
        }
    }
}

// Namespace br_gametype_truckwar
// Params 1, eflags: 0x4
// Checksum 0x412d8dd4, Offset: 0x47bc
// Size: 0x15d
function private onplayerdisconnectcallback( player )
{
    if ( !flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( level.brgametype.issolos )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    remainingplayers = level.teamdata[ player.team ][ "players" ];
    
    if ( remainingplayers.size == 1 )
    {
        if ( level.brgametype.var_fe19b5fef3861981 )
        {
            remainingplayers[ 0 ] thread hud_message::showsplash( "truckwar_left_behind_improvement" );
        }
    }
    else
    {
        foreach ( remainingplayer in remainingplayers )
        {
            if ( level.brgametype.var_90ce4bd9339d98df )
            {
                remainingplayer thread hud_message::showsplash( "truckwar_ally_left_improvement", undefined, player, undefined, 1 );
            }
        }
    }
    
    if ( level.brgametype.var_b814b89099323daf )
    {
        br_public::brleaderdialog( "resurgence_on_player_disconnect", 1, remainingplayers, undefined, 0, undefined );
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x1118cec3, Offset: 0x4921
// Size: 0x175
function fadetogearingup( waittime )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self notify( #"hash_910faf4d1446a162" );
    self endon( #"hash_910faf4d1446a162" );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( isteameliminated( self.team ) || !level.teamcanrespawn[ self.team ] )
    {
        return;
    }
    
    pre_spawn_delay = 1;
    thread fadeoutin();
    wait pre_spawn_delay - 0.25;
    br::function_db10c8f42ea08ad5();
    omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 2 );
    wait 0.25;
    
    if ( isteameliminated( self.team ) || !level.teamcanrespawn[ self.team ] )
    {
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
        return;
    }
    
    if ( getdvarint( @"hash_e912e88184530f28", 1 ) == 1 )
    {
        br_public::playerclearstreamhintorigin();
        spawnpoint = getspawnpoint();
        br_spectate::playerclearspectatekillchainsystem();
        br::spawnintermission( spawnpoint.origin, spawnpoint.angles );
        spectating::setdisabled();
        self.intermissionspawnorigin = spawnpoint.origin;
        self.intermissionspawntime = gettime();
        utility::ent_flag_set( "playerRespawn_intermission_spawned" );
    }
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xda9d02b2, Offset: 0x4a9e
// Size: 0x7d
function fadeoutin()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    br_spawnrespawn::function_1d2f70d591e967bc();
    result = utility::waittill_any_return_no_endon_death( "spawned_player", "respawn_vehicle_in_gas", "gulag_auto_win" );
    
    if ( result == "spawned_player" || result == "respawn_vehicle_in_gas" )
    {
        self waittill( #"hash_e6e12d076dc31b0a" );
    }
    else
    {
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
    }
    
    br_spawnrespawn::function_24b79e9319c6f02f();
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x1ef53a98, Offset: 0x4b23
// Size: 0xdf
function updateprestreamrespawn()
{
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self endon( #"hash_90ac94f1376250d4" );
    self endon( #"respawn_vehicle_death" );
    
    while ( true )
    {
        if ( utility::ent_flag( "playerRespawn_intermission_spawned" ) )
        {
            spawnpoint = getspawnpoint();
            currenttime = gettime();
            assert( isdefined( self.intermissionspawntime ) );
            assert( self.intermissionspawntime <= currenttime );
            
            if ( currenttime - self.intermissionspawntime >= getdvarfloat( @"hash_b72fc168d3582ece", 2 ) * 1000 )
            {
                spawnpoint = getspawnpoint();
                br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
            }
        }
        else
        {
            spawnpoint = getspawnpoint();
            br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
        }
        
        wait 1;
    }
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x416e37ec, Offset: 0x4c0a
// Size: 0x1b
function initspawns()
{
    level.spawnheight = getdvarfloat( @"scr_spawn_height", 2500 );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x39c1baf3, Offset: 0x4c2d
// Size: 0x29f
function getspawnpoint( isplanejump )
{
    if ( !isdefined( self.redeployspawn ) )
    {
        self.redeployspawn = spawnstruct();
        return generatespawnpoint( istrue( isplanejump ) );
    }
    
    self.ti_spawn = 0;
    
    if ( isdefined( self.setspawnpoint ) )
    {
        if ( !self.setspawnpoint.notti )
        {
            self.ti_spawn = 1;
            self playlocalsound( "tactical_spawn" );
            
            foreach ( entry in level.teamnamelist )
            {
                if ( entry != self.team )
                {
                    self playsoundtoteam( "tactical_spawn", entry );
                }
            }
        }
        
        spawnorigin = self.setspawnpoint.playerspawnpos;
        tracecontents = trace::create_default_contents( 1 );
        groundorigin = br_public::droptogroundmultitrace( spawnorigin, 10000, -20000, tracecontents );
        spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], groundorigin[ 2 ] );
        spawnorigin += ( 0, 0, 1 ) * level.brtdm_config.spawnheight[ self.team ];
        
        if ( getdvarint( @"hash_53b56fcd1ad4a8ce", 0 ) )
        {
            thread debug::drawline( spawnorigin, groundorigin, 15, ( 1, 1, 0 ) );
        }
        
        self.redeployspawn.origin = spawnorigin;
        self.redeployspawn.angles = self.setspawnpoint.playerspawnangles;
        self.redeployspawn.lifeid = self.lifeid;
        self.redeployspawn.time = gettime();
        playerlogic::spawnpoint_clearspawnpoint( 0, 1 );
    }
    else if ( self.redeployspawn.team != self.team || self.redeployspawn.lifeid != self.lifeid || self.redeployspawn.isplanejump )
    {
        return generatespawnpoint( istrue( isplanejump ) );
    }
    
    return self.redeployspawn;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x9d74f12f, Offset: 0x4ed5
// Size: 0x32a
function generatespawnpoint( isplanejump )
{
    spawnorigin = level.teamvehicles[ self.team ].origin;
    tracecontents = trace::create_default_contents( 1 );
    result = trace::ray_trace( spawnorigin + ( 0, 0, 10000 ), spawnorigin - ( 0, 0, 20000 ), undefined, tracecontents )[ "position" ];
    spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], result[ 2 ] + level.spawnheight );
    
    if ( getdvarint( @"hash_202e933fd3431d24", 1 ) && level.circleclosing )
    {
        safecircleorigin = br_circle::getsafecircleorigin();
        safecircleradius = br_circle::getsafecircleradius();
        var_db92689eee729726 = safecircleorigin - spawnorigin;
        var_120542e74ec3cc61 = distance2d( safecircleorigin, spawnorigin );
        
        if ( var_120542e74ec3cc61 > safecircleradius )
        {
            var_8a311dbb6370ccc = vectornormalize( var_db92689eee729726 );
            var_6a2be3e67301087c = 0;
            
            if ( level.br_circle.circleindex == 0 )
            {
                previousradii = level.br_level.br_circleradii[ level.br_circle.circleindex ];
                var_6a2be3e67301087c = previousradii - safecircleradius;
            }
            else
            {
                var_5042e606df2342de = level.br_level.br_circlecenters[ level.br_circle.circleindex ];
                var_6a2be3e67301087c = distance2d( safecircleorigin, var_5042e606df2342de );
            }
            
            closetime = level.br_level.br_circleclosetimes[ level.br_circle.circleindex + 1 ];
            velocity = var_6a2be3e67301087c / closetime;
            var_9393fae91f7255ef = velocity * getdvarfloat( @"hash_4f1aee380c4c64f8", 10 );
            spawnorigin += var_8a311dbb6370ccc * var_9393fae91f7255ef;
            dangercircleorigin = br_circle::getdangercircleorigin();
            dangercircleradius = br_circle::getdangercircleradius();
            
            if ( distance2dsquared( spawnorigin, dangercircleorigin ) > dangercircleradius * dangercircleradius )
            {
                var_210ca71699fec867 = vectornormalize( spawnorigin - dangercircleorigin );
                spawnorigin = dangercircleorigin + var_210ca71699fec867 * dangercircleradius * 0.99;
            }
        }
    }
    
    self.redeployspawn.origin = spawnorigin;
    self.redeployspawn.angles = level.teamvehicles[ self.team ].angles;
    self.redeployspawn.time = gettime();
    self.redeployspawn.team = self.team;
    self.redeployspawn.index = -1;
    self.redeployspawn.lifeid = self.lifeid;
    self.redeployspawn.isplanejump = isplanejump;
    return self.redeployspawn;
}

#using_animtree( "script_model" );

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xc100c425, Offset: 0x5208
// Size: 0xa9
function init_airdrop_anims()
{
    level.scr_animtree[ "ac130" ] = #animtree;
    level.scr_anim[ "ac130" ][ "truck_drop" ] = %mp_mkilo23_gunner_drop_acharlie130;
    level.scr_anim[ "ac130" ][ "truck_drop_trimmed" ] = %mp_mkilo23_gunner_drop_acharlie130_trimmed;
    level.scr_animtree[ "parachute" ] = #animtree;
    level.scr_anim[ "parachute" ][ "truck_drop" ] = %mp_mkilo23_gunner_drop_parachute;
    level.scr_anim[ "parachute" ][ "truck_drop_trimmed" ] = %mp_mkilo23_gunner_drop_parachute_trimmed;
    init_airrop_vehicle_anims();
}

// Namespace br_gametype_truckwar
// Params 0, eflags: 0x4
// Checksum 0xdda0f956, Offset: 0x52b9
// Size: 0x8d
function private function_1b0f8de5bbacb8a8()
{
    utility::flag_wait( "vehicle_init_complete" );
    
    if ( !vehicle::has_data( %"hash_1c8a00baf3a72043" ) )
    {
        return;
    }
    
    data = vehicle::get_data( %"hash_1c8a00baf3a72043" );
    data.damage.class = "heavy";
    vehicle_damage::function_f80dee5b045a4ee8( %"hash_1c8a00baf3a72043" );
    data.damage.var_ad08183ba8a73943 = getdvarint( @"hash_e20f6b4a3c18e03a", 3 );
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x36f1dbbb, Offset: 0x534e
// Size: 0x52
function init_airrop_vehicle_anims()
{
    level.scr_animtree[ "truck" ] = #animtree;
    level.scr_anim[ "truck" ][ "truck_drop" ] = %mp_mkilo23_gunner_drop_mkilo23;
    level.scr_anim[ "truck" ][ "truck_drop_trimmed" ] = %mp_mkilo23_gunner_drop_mkilo23_trimmed;
}

// Namespace br_gametype_truckwar
// Params 4
// Checksum 0xc2a76924, Offset: 0x53a8
// Size: 0x2be
function truck_airdrop( vehicle, position, angles, showc130 )
{
    animation = showc130 ? "truck_drop" : "truck_drop_trimmed";
    vehicle.animname = "truck";
    vehicle.var_7b04f608cc6ab604 = 1;
    vehicle vehphys_forcekeyframedmotion();
    vehicle hide();
    scenenode = spawn( "script_model", position );
    scenenode.angles = angles;
    scenenode setmodel( "tag_origin" );
    parachute = spawn( "script_model", position );
    parachute.angles = angles;
    parachute.animname = "parachute";
    parachute setmodel( "veh8_mil_lnd_bromeo_parachute" );
    parachute animation::setanimtree();
    parachute forcenetfieldhighlod( 1 );
    parachute hide();
    carrier = undefined;
    
    if ( showc130 )
    {
        carrier = spawn( "script_model", position );
        carrier.angles = angles;
        carrier.animname = "ac130";
        carrier setmodel( "veh9_mil_air_cargo_plane_wm" );
        carrier animation::setanimtree();
        carrier hide();
    }
    
    scenenode.vehicle = vehicle;
    scenenode.parachute = parachute;
    scenenode.carrier = carrier;
    scenestarttime = gettime() + level.frameduration;
    scenenode.endtime = gettime();
    scenenode.vehicleendtime = scenestarttime + getanimlength( level.scr_anim[ "truck" ][ animation ] ) * 1000;
    
    if ( scenenode.vehicleendtime > scenenode.endtime )
    {
        scenenode.endtime = scenenode.vehicleendtime;
    }
    
    scenenode.parachuteendtime = scenestarttime + getanimlength( level.scr_anim[ "parachute" ][ animation ] ) * 1000;
    
    if ( scenenode.parachuteendtime > scenenode.endtime )
    {
        scenenode.endtime = scenenode.parachuteendtime;
    }
    
    scenenode.carrierendtime = scenestarttime + getanimlength( level.scr_anim[ "ac130" ][ animation ] ) * 1000;
    
    if ( scenenode.carrierendtime > scenenode.endtime )
    {
        scenenode.endtime = scenenode.carrierendtime;
    }
    
    scenenode thread truck_airdropinternal( animation );
    return vehicle;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xa441d0ee, Offset: 0x566f
// Size: 0x234
function truck_airdropinternal( animation )
{
    animation::anim_first_frame_solo( self.vehicle, animation );
    animation::anim_first_frame_solo( self.parachute, animation );
    
    if ( isdefined( self.carrier ) )
    {
        animation::anim_first_frame_solo( self.carrier, animation );
    }
    
    waitframe();
    
    if ( isdefined( self.vehicle ) )
    {
        self.vehicle show();
        self.vehicle.infilling = 1;
        thread animation::anim_single_solo( self.vehicle, animation );
    }
    
    if ( isdefined( self.parachute ) )
    {
        self.parachute show();
        thread animation::anim_single_solo( self.parachute, animation );
    }
    
    if ( isdefined( self.carrier ) )
    {
        self.carrier show();
        self.carrier playloopsound( "iw8_cargotruck_drop_c130" );
        self.carrier setscriptablepartstate( "lights2", "on", 0 );
        self.carrier setscriptablepartstate( "contrails", "on", 0 );
        thread animation::anim_single_solo( self.carrier, animation );
    }
    
    while ( gettime() <= self.endtime )
    {
        if ( !isdefined( self.vehicle ) || self.vehicle.isdestroyed || gettime() >= self.vehicleendtime )
        {
            thread truck_detachvehiclefromairdropsequence( self.vehicle );
        }
        
        if ( isdefined( self.parachute ) && gettime() >= self.parachuteendtime )
        {
            self.parachute delete();
        }
        
        if ( isdefined( self.carrier ) && gettime() >= self.carrierendtime )
        {
            self.carrier delete();
        }
        
        waitframe();
    }
    
    thread truck_detachvehiclefromairdropsequence( self.vehicle );
    
    if ( isdefined( self.parachute ) )
    {
        self.parachute delete();
    }
    
    if ( isdefined( self.carrier ) )
    {
        self.carrier delete();
    }
    
    self delete();
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x562f04e8, Offset: 0x58ab
// Size: 0x2c
function truck_detachvehiclefromairdropsequence( vehicle )
{
    self.vehicle = undefined;
    
    if ( isdefined( vehicle ) )
    {
        vehicle vehphys_setdefaultmotion();
        vehicle thread truck_startfreefall();
    }
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xfce388d3, Offset: 0x58df
// Size: 0xe2
function truck_startfreefall()
{
    self endon( #"death" );
    self physics_registerforcollisioncallback();
    waitframe();
    endtime = gettime() + 5000;
    var_67cd5a6a3fcf314c = undefined;
    var_c6bb52a9f00cd9d7 = undefined;
    
    while ( gettime() < endtime )
    {
        if ( !isdefined( var_67cd5a6a3fcf314c ) )
        {
            var_67cd5a6a3fcf314c = vectordot( self vehicle_getvelocity(), ( 0, 0, -1 ) );
        }
        else
        {
            var_9fc6a63d3c3c3ec0 = vectordot( self vehicle_getvelocity(), ( 0, 0, -1 ) );
            var_147a174ce6deff73 = ( var_9fc6a63d3c3c3ec0 - var_67cd5a6a3fcf314c ) / level.framedurationseconds;
            
            if ( isdefined( var_c6bb52a9f00cd9d7 ) )
            {
                if ( var_c6bb52a9f00cd9d7 - var_147a174ce6deff73 >= 300 )
                {
                    truck_land( self.origin, self.angles );
                    break;
                }
            }
            
            var_67cd5a6a3fcf314c = var_9fc6a63d3c3c3ec0;
            var_c6bb52a9f00cd9d7 = var_147a174ce6deff73;
        }
        
        waitframe();
    }
    
    self physics_unregisterforcollisioncallback();
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x148ec78e, Offset: 0x59c9
// Size: 0x79
function truck_land( position, angles )
{
    self.infilling = 0;
    thread function_ab3047138def638c( self );
    thread function_fb403d7f38efc744( self );
    playfx( utility::getfx( "light_tank_land" ), position, anglestoforward( angles ) );
    earthquake( 0.3, 0.7, position, 800 );
    playrumbleonposition( "grenade_rumble", position );
    physicsexplosionsphere( position, 800, 400, 0.5 );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xe80af14a, Offset: 0x5a4a
// Size: 0x30
function showsplashtoteam( team, splashname )
{
    br_gametype_dmz::showdmzsplash( splashname, level.teamdata[ team ][ "players" ] );
}

// Namespace br_gametype_truckwar
// Params 3
// Checksum 0xe8119ef0, Offset: 0x5a82
// Size: 0x4e
function function_9a239f9311a3d2e2( ref, players, delay )
{
    if ( isdefined( game[ "dialog" ][ ref ] ) )
    {
        assert( players.size > 0 );
        br_public::brleaderdialog( ref, 0, players, undefined, delay, undefined, "dx_br_bds5_" );
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x5c35372d, Offset: 0x5ad8
// Size: 0x33b
function function_da2d7b41e0f0c1de( players )
{
    thread function_a7e5797d31bed7f8( players );
    level.var_33a2a7698de9cb4f = getdvarint( @"scr_truckwar_repair_station", 0 );
    level.var_43223092d3d9fcff = getdvarint( @"scr_truckwar_repair_station_objective", 0 );
    
    foreach ( station in level.gasstations )
    {
        if ( !station.var_95a80d5cd68cee0e )
        {
            station setscriptablepartstate( station function_84ad2f70189ee7c3(), "idle" );
        }
    }
    
    if ( level.var_33a2a7698de9cb4f )
    {
        level thread function_c2036b93a6999590();
    }
    
    if ( !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        level.disablespawning = 1;
        level.numlives = 1;
        setdynamicdvar( @"scr_br_numlives", 1 );
    }
    
    deathicons::removealldeathicons();
    flags::gameflaginit( "trucks_spawn_complete", 0 );
    level thread function_54562d0670f3676d();
    flags::gameflagwait( "trucks_spawn_complete" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            player playerlogic::spawnplayer( 0 );
        }
        
        if ( player.br_iseliminated )
        {
            br_utility::unmarkplayeraseliminated( player );
        }
        
        player setclientomnvar( "ui_br_infil_started", 1 );
        player setclientomnvar( "ui_br_infiled", 1 );
        player br_spawnrespawn::function_1d2f70d591e967bc();
        player thread function_7e944610e6d48d77();
    }
    
    wait 2;
    flags::gameflagset( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "tw_ac130_flyby", player, player );
    }
    
    wait 2;
    spawnvehicles();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread function_30b142ae24731131();
    }
    
    level thread function_d7c89b28b9680b77();
    flags::gameflagset( "use_truck_respawn" );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xaa5bdd7d, Offset: 0x5e1b
// Size: 0xc
function function_a7e5797d31bed7f8( players )
{
    
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x7bcb4900, Offset: 0x5e2f
// Size: 0x60
function function_7e944610e6d48d77()
{
    spawnpoint = spawnstruct();
    spawnpoint.origin = level.var_c79684ec84b304ff[ self.team ].origin;
    spawnpoint.height = getdvarint( @"hash_7b079d61a6a1b553", 3000 );
    br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xba89878b, Offset: 0x5e97
// Size: 0x19d
function function_30b142ae24731131()
{
    streamhint::playerwaittillstreamhintcomplete();
    
    if ( !isalive( self ) )
    {
        playerlogic::spawnplayer( 0 );
    }
    
    if ( self.br_iseliminated )
    {
        br_utility::unmarkplayeraseliminated( self );
    }
    
    vehicle = level.teamvehicles[ self.team ];
    
    if ( !vehicle.var_7b04f608cc6ab604 )
    {
        level thread truck_airdrop( vehicle, vehicle.origin, vehicle.angles, 0 );
    }
    
    getspawnpoint( 1 );
    var_91864ef49701b9e7 = anglestoforward( ( 0, randomint( 360 ), 0 ) );
    offset = getdvarint( @"hash_152992667994717b", 500 );
    height = getdvarint( @"hash_7b079d61a6a1b553", 3000 );
    spawnorigin = self.redeployspawn.origin + var_91864ef49701b9e7 * offset + ( 0, 0, 1 ) * height;
    spawnangles = vectortoangles( self.redeployspawn.origin - spawnorigin );
    
    while ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        waitframe();
    }
    
    waitframe();
    armor::givestartingarmor();
    self setorigin( spawnorigin, 1 );
    self setplayerangles( spawnangles );
    thread br_c130::parachute( undefined, 0, undefined, 0 );
    br_spawnrespawn::function_24b79e9319c6f02f();
    self.plotarmor = undefined;
    self clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
    self clearsoundsubmix( "deaths_door_mp", 1 );
    self notify( #"hash_6f9c96fc31ef495f" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x54dd8b6f, Offset: 0x603c
// Size: 0x34a
function function_c2036b93a6999590()
{
    level.repairstations = [];
    
    if ( level.var_43223092d3d9fcff )
    {
        _setdomflagiconinfo( "waypoint_repair_station_idle", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_idle", 0 );
        _setdomflagiconinfo( "waypoint_repair_station_in_use", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_in_use", 0 );
    }
    
    if ( getdvarint( @"hash_e9acc6ac1a49f7c0", 0 ) != 1 )
    {
        var_eb1a0a9b736e0424 = getdvarint( @"hash_b4a41eb239a45bb2", 90000 );
        origins = function_2d258d8c8e442ef3();
        
        foreach ( origin in origins )
        {
            station = function_1f7dd4bfa533dbe8( origin, sqrt( var_eb1a0a9b736e0424 ) );
            station.var_eb1a0a9b736e0424 = var_eb1a0a9b736e0424;
            level.repairstations[ level.repairstations.size ] = station;
        }
    }
    
    var_eb1a0a9b736e0424 = getdvarint( @"hash_15f14ba39b98e2d7", 90000 );
    origins = function_38b5a4947c5870de();
    
    foreach ( origin in origins )
    {
        station = function_1f7dd4bfa533dbe8( origin, sqrt( var_eb1a0a9b736e0424 ) );
        station.var_eb1a0a9b736e0424 = var_eb1a0a9b736e0424;
        level.repairstations[ level.repairstations.size ] = station;
    }
    
    var_eb1a0a9b736e0424 = getdvarint( @"hash_c266f4671f4c6f79", 90000 );
    origins = function_a13c7fee69c88b70();
    
    foreach ( origin in origins )
    {
        station = function_1f7dd4bfa533dbe8( origin, sqrt( var_eb1a0a9b736e0424 ) );
        station.var_eb1a0a9b736e0424 = var_eb1a0a9b736e0424;
        level.repairstations[ level.repairstations.size ] = station;
    }
    
    var_eb1a0a9b736e0424 = getdvarint( @"hash_a2c43cbb69aa6a83", 90000 );
    origins = function_979d881555bc92a();
    
    foreach ( origin in origins )
    {
        station = function_1f7dd4bfa533dbe8( origin, sqrt( var_eb1a0a9b736e0424 ) );
        station.var_eb1a0a9b736e0424 = var_eb1a0a9b736e0424;
        level.repairstations[ level.repairstations.size ] = station;
    }
}

// Namespace br_gametype_truckwar
// Params 6
// Checksum 0xcb7900b8, Offset: 0x638e
// Size: 0x7f
function _setdomflagiconinfo( name, bgtype, colors, string, image, pulses )
{
    level.waypointcolors[ name ] = colors;
    level.waypointbgtype[ name ] = bgtype;
    level.waypointstring[ name ] = string;
    level.waypointshader[ name ] = image;
    level.waypointpulses[ name ] = pulses;
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x80aff1b5, Offset: 0x6415
// Size: 0x11f
function function_1f7dd4bfa533dbe8( origin, radius )
{
    station = undefined;
    
    if ( level.var_43223092d3d9fcff )
    {
        trigger = spawn( "trigger_radius", origin, 0, int( radius ), int( radius ) );
        station = obj_dom::setupobjective( trigger );
        station.pinobj = 0;
        station gameobjects::allowuse( "none" );
        station.flagmodel hide();
        objidpoolmanager::update_objective_position( station.objidnum, station.curorigin + ( 0, 0, 60 ) );
        function_44a344c68a68f28d( station.objidnum, 1 );
        station gameobjects::setobjectivestatusicons( "waypoint_repair_station_idle" );
        function_ac9886e0e2860e18( station.objidnum, 2000, 2500 );
    }
    else
    {
        station = spawnscriptable( "truckwar_repair_station", origin, ( 0, 0, 1 ) );
    }
    
    station.inuse = 0;
    station.inuseprev = 0;
    return station;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x67534cb4, Offset: 0x653d
// Size: 0x11
function function_2d258d8c8e442ef3()
{
    origins = [];
    return origins;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xf40cac5, Offset: 0x6557
// Size: 0x11
function function_38b5a4947c5870de()
{
    origins = [];
    return origins;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x280a380, Offset: 0x6571
// Size: 0x11
function function_a13c7fee69c88b70()
{
    origins = [];
    return origins;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xd89070a7, Offset: 0x658b
// Size: 0x11
function function_979d881555bc92a()
{
    origins = [];
    return origins;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xbfda5379, Offset: 0x65a5
// Size: 0x413
function function_d7c89b28b9680b77()
{
    if ( !level.var_33a2a7698de9cb4f )
    {
        return;
    }
    
    repairpct = getdvarfloat( @"hash_e7c32b801c5b43a2", 0.025 );
    repairinterval = getdvarfloat( @"hash_9e06adb574328430", 1 );
    
    while ( true )
    {
        foreach ( station in level.repairstations )
        {
            station.var_869f6b1bbffd4aa = 0;
        }
        
        foreach ( team, truck in level.teamvehicles )
        {
            if ( !isdefined( truck ) )
            {
                continue;
            }
            
            washealing = istrue( truck.healing );
            anyinrange = 0;
            
            foreach ( station in level.repairstations )
            {
                distsq = distancesquared( truck.origin, station.origin ?? station.curorigin );
                
                if ( distsq < station.var_eb1a0a9b736e0424 )
                {
                    station markinuse();
                    station.var_869f6b1bbffd4aa = 1;
                    anyinrange = 1;
                    
                    if ( truck.healingblocked )
                    {
                        continue;
                    }
                    
                    if ( truck.health == truck.maxhealth )
                    {
                        continue;
                    }
                    
                    truck.healing = 1;
                    
                    if ( !washealing )
                    {
                        function_11aa8ee05b7575e2( team );
                    }
                    
                    var_5fc006a5e7de01d9 = int( repairpct * truck.maxhealth );
                    truck vehicle_damage::add_health( var_5fc006a5e7de01d9 );
                    players = teams::getteamdata( team, "players" );
                    
                    foreach ( player in players )
                    {
                        if ( getdvarint( @"hash_38d15e2d7ddbf066", 0 ) == 1 )
                        {
                            player damagefeedback::hudicontype( "truckheal" );
                        }
                        
                        player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", truck.health );
                        player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", truck.maxhealth );
                    }
                    
                    break;
                }
            }
            
            if ( washealing && !anyinrange )
            {
                truck.healing = 0;
                function_11aa8ee05b7575e2( team );
            }
        }
        
        foreach ( station in level.repairstations )
        {
            if ( !station.var_869f6b1bbffd4aa )
            {
                station markidle();
            }
        }
        
        wait repairinterval;
    }
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x78e17a98, Offset: 0x69c0
// Size: 0x4d
function markinuse()
{
    self.inuseprev = self.inuse;
    self.inuse = 1;
    
    if ( self.inuse != self.inuseprev )
    {
        if ( level.var_43223092d3d9fcff )
        {
            gameobjects::setobjectivestatusicons( "waypoint_repair_station_in_use" );
        }
    }
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x72ab8dfb, Offset: 0x6a15
// Size: 0x4c
function markidle()
{
    self.inuseprev = self.inuse;
    self.inuse = 0;
    
    if ( self.inuse != self.inuseprev )
    {
        if ( level.var_43223092d3d9fcff )
        {
            gameobjects::setobjectivestatusicons( "waypoint_repair_station_idle" );
        }
    }
}

// Namespace br_gametype_truckwar
// Params 0, eflags: 0x4
// Checksum 0xd8cab8ec, Offset: 0x6a69
// Size: 0x55
function private function_e574c9fcbabc21e2()
{
    var_1cfe7768eb975fb2 = getdvarint( @"hash_856015437dc2f753", 5 );
    
    if ( var_1cfe7768eb975fb2 > level.br_level.br_circleclosetimes.size - 1 )
    {
        var_1cfe7768eb975fb2 = level.br_level.br_circleclosetimes.size - 1;
    }
    
    return var_1cfe7768eb975fb2;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x8bf0dbc5, Offset: 0x6ac7
// Size: 0x127
function function_4602cb8ff3f27e83()
{
    level endon( #"game_ended" );
    level.var_17422c7ae7ff00b = 0;
    level waittill( #"infils_ready" );
    var_1cfe7768eb975fb2 = function_e574c9fcbabc21e2();
    var_2687aca5dc3c5f0e = 0;
    
    for ( i = 0; i < var_1cfe7768eb975fb2 - 1 ; i++ )
    {
        var_2687aca5dc3c5f0e += level.br_level.br_circleclosetimes[ i ];
        var_2687aca5dc3c5f0e += level.br_level.br_circledelaytimes[ i ];
    }
    
    endtimems = gettime() + var_2687aca5dc3c5f0e * 1000;
    setomnvar( "ui_gulag_timer", int( endtimems ) );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        
        if ( level.br_circle.circleindex == var_1cfe7768eb975fb2 )
        {
            br_gametype_dmz::showdmzsplash( "truckwar_spawn_disabled", level.players );
            thread function_9a239f9311a3d2e2( "vehicle_spawn_over", level.players );
            level.var_17422c7ae7ff00b = 1;
            setomnvar( "ui_gulag_timer", 0 );
            break;
        }
    }
}

/#

    // Namespace br_gametype_truckwar
    // Params 0
    // Checksum 0x90db9d3, Offset: 0x6bf6
    // Size: 0xfe, Type: dev
    function function_d2b5f45c17171e52()
    {
        level endon( #"game_ended" );
        testplayer = undefined;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                testplayer = player;
                break;
            }
        }
        
        testdvar = @"hash_419dc795b2a889e0";
        setdevdvarifuninitialized( testdvar, 0 );
        
        while ( true )
        {
            if ( getdvarint( testdvar, 0 ) == 0 )
            {
                waitframe();
                continue;
            }
            
            playervehicle = testplayer player_utility::getvehicle();
            
            if ( isdefined( playervehicle ) && !playervehicle.radaron )
            {
                function_5d6ce2543d80b47b( playervehicle );
            }
            
            waitframe();
        }
    }

#/

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x6dee7923, Offset: 0x6cfc
// Size: 0x1b6, Type: bool
function checkdangerradius( point, time )
{
    safecircleorigin = br_circle::getsafecircleorigin();
    safecircleradius = br_circle::getsafecircleradius();
    var_db92689eee729726 = safecircleorigin - point;
    var_120542e74ec3cc61 = distance2d( safecircleorigin, point );
    
    if ( var_120542e74ec3cc61 < safecircleradius )
    {
        return false;
    }
    
    translationdist = 0;
    translationvec = ( 0, 0, 0 );
    translationvelocity = 0;
    shrinkdist = 0;
    shrinkvec = 0;
    shrinkvelocity = 0;
    closetime = level.br_level.br_circleclosetimes[ level.br_circle.circleindex ];
    
    if ( level.br_circle.circleindex > 0 )
    {
        var_5042e606df2342de = level.br_level.br_circlecenters[ level.br_circle.circleindex ];
        translationdist = distance2d( safecircleorigin, var_5042e606df2342de );
        translationvec = vectornormalize( safecircleorigin - var_5042e606df2342de );
    }
    
    translationvelocity = translationdist / closetime;
    previousradii = level.br_level.br_circleradii[ level.br_circle.circleindex ];
    shrinkdist = previousradii - safecircleradius;
    shrinkvec = vectornormalize( var_db92689eee729726 );
    shrinkvelocity = shrinkdist / closetime;
    testpoint = point + translationvec * -1 * time * translationvelocity + shrinkvec * -1 * time * shrinkvelocity;
    return br_circle::function_6bf5d4e680297398( testpoint );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x17922b74, Offset: 0x6ebb
// Size: 0x6c
function function_ab3047138def638c( vehicle )
{
    vehicle endon( #"death" );
    
    while ( true )
    {
        vehicle waittill( #"give_upgrade", upgradetype, player );
        upgradeinfo = function_6c7a95abbde3f7ca( upgradetype );
        utility::function_704b6016a179b4ab( upgradeinfo.onactivatefunc, vehicle, player );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x9927e141, Offset: 0x6f2f
// Size: 0x61
function function_848c29aa0c414660( vehicle, player )
{
    function_e80e774a7affa200( vehicle );
    vehicle.armoractive = 1;
    vehicle notify( #"upgrade_message", "armor_upgraded" );
    playsoundatpos( vehicle.origin + ( 0, 0, 20 ), "veh_truckwars_add_armor" );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x44002d52, Offset: 0x6f98
// Size: 0x2dc
function function_e80e774a7affa200( vehicle )
{
    armor = [ "tag_armor_body_back_01", "tag_armor_body_back_02", "tag_armor_body_back_03", "tag_armor_body_back_04", "tag_armor_body_back_05", "tag_armor_body_back_06", "tag_armor_body_back_07", "tag_armor_body_back_08", "tag_armor_body_back_09", "tag_armor_body_back_10", "tag_armor_body_back_11", "tag_armor_body_back_12", "tag_armor_body_left_01", "tag_armor_body_left_02", "tag_armor_body_left_03", "tag_armor_body_left_04", "tag_armor_body_left_05", "tag_armor_body_left_06", "tag_armor_body_left_07", "tag_armor_body_left_08", "tag_armor_body_left_09", "tag_armor_body_left_10", "tag_armor_body_left_11", "tag_armor_body_right_01", "tag_armor_body_right_02", "tag_armor_body_right_03", "tag_armor_body_right_04", "tag_armor_body_right_05", "tag_armor_body_right_06", "tag_armor_body_right_07", "tag_armor_body_right_08", "tag_armor_body_right_09", "tag_armor_body_right_10", "tag_armor_body_right_11", "tag_armor_bumper_back", "tag_armor_bumper_front", "tag_armor_cabin_front_01", "tag_armor_cabin_front_02", "tag_armor_cabin_front_03", "tag_armor_cabin_front_04", "tag_armor_cabin_front_05", "tag_armor_cabin_front_06", "tag_armor_cabin_front_07", "tag_armor_cabin_front_09", "tag_armor_cabin_left_01", "tag_armor_cabin_left_02", "tag_armor_cabin_left_03", "tag_armor_cabin_left_04", "tag_armor_cabin_left_05", "tag_armor_cabin_right_01", "tag_armor_cabin_right_02", "tag_armor_cabin_right_03", "tag_armor_cabin_right_04", "tag_armor_cabin_right_05", "tag_armor_cabin_top", "tag_armor_door_left", "tag_armor_door_right", "tag_armor_wheel_back_left", "tag_armor_wheel_back_right", "tag_armor_wheel_front_left", "tag_armor_wheel_front_right", "tag_armor_wheel_middle1_left", "tag_armor_wheel_middle1_right", "tag_armor_wheel_middle2_left", "tag_armor_wheel_middle2_right", "tag_armor_wheel_middle2_right" ];
    
    foreach ( tag in armor )
    {
        vehicle_damage::activate_part( vehicle, tag );
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xaa68a450, Offset: 0x727c
// Size: 0xae
function function_b685b7bab062d6bd( vehicle )
{
    doors = [ "tag_door_front_left", "tag_door_front_right", "tag_windshield_front" ];
    
    foreach ( tag in doors )
    {
        vehicle_damage::activate_part( vehicle, tag );
    }
    
    vehicle_damage::function_b0ba8090957b72f3( vehicle );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x83f975cf, Offset: 0x7332
// Size: 0x10f
function function_97924ce70b4368e3( vehicle, player )
{
    if ( utility::issharedfuncdefined( #"vehicle_trophy", #"init" ) )
    {
        vehicle setscriptablepartstate( "trophy", "on" );
        var_f27de7843ae6a88e = utility::getsharedfunc( #"vehicle_trophy", #"init" );
        vehicle.trophyammo = 3;
        vehicle.isdisabled = 0;
        vehicle.owner = player;
        vehicle.weapon_object = vehicle.objweapon;
        vehicle thread [[ var_f27de7843ae6a88e ]]( 72, 530, &function_77f58809e548a0be, &trophy_protectionsuccessful );
        
        if ( utility::issharedfuncdefined( #"hash_8fbc7580ee7f4ca9", #"init" ) )
        {
            vehicle.explosion = [[ utility::getsharedfunc( #"hash_8fbc7580ee7f4ca9", #"init" ) ]]( vehicle );
        }
        
        vehicle notify( #"upgrade_message", "trophy_activated" );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x761ef555, Offset: 0x7449
// Size: 0x42
function function_9961ef81ad0e8566( vehicle, player )
{
    vehicle.trophyammo = 3;
    vehicle.isdisabled = 0;
    vehicle notify( #"upgrade_message", "trophy_ammo_refill" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xaa43e0a4, Offset: 0x7493
// Size: 0x4, Type: bool
function function_77f58809e548a0be()
{
    return true;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x238be021, Offset: 0x74a0
// Size: 0x123
function trophy_protectionsuccessful( trophytarget )
{
    explorigin = trophytarget.origin;
    
    if ( utility::issharedfuncdefined( #"hash_37a09a3f61fad325", #"init" ) )
    {
        [[ utility::getsharedfunc( #"hash_37a09a3f61fad325", #"init" ) ]]( trophytarget );
    }
    
    tag = "tag_origin";
    dirangles = vectortoangles( self gettagorigin( tag ) - explorigin );
    explangles = combineangles( dirangles, ( -90, 0, 0 ) );
    
    if ( utility::issharedfuncdefined( #"hash_5af790a704e01be7", #"init" ) )
    {
        self.explosion thread [[ utility::getsharedfunc( #"hash_5af790a704e01be7", #"init" ) ]]( explorigin, explangles );
    }
    
    if ( self.trophyammo > 0 )
    {
        self.trophyammo--;
    }
    
    if ( self.trophyammo == 0 )
    {
        self.isdisabled = 1;
        self notify( #"upgrade_message", "trophy_no_ammo" );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xa0377550, Offset: 0x75cb
// Size: 0x30
function function_5d6ce2543d80b47b( vehicle, player )
{
    vehicle thread function_86a54074881e1f19();
    vehicle notify( #"upgrade_message", "uav_activated" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x150ee347, Offset: 0x7603
// Size: 0x78
function function_86a54074881e1f19()
{
    self endon( #"death" );
    radius = getdvarint( @"hash_bc348a829ed932", 12000 );
    time = getdvarint( @"hash_4523720be81f63ad", 5 );
    timems = time * 1000;
    
    while ( true )
    {
        triggerportableradarpingteam( self.origin, self.team, radius, timems );
        wait time;
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x8ede3fe, Offset: 0x7683
// Size: 0x72
function function_3c413542b4330035( vehicle, player )
{
    turret = vehicle::function_95e3c2e0c6eec800( vehicle, "iw9_mg_mrap_mp" );
    turret function_b261b7658e3b143d( getdvarfloat( @"hash_6b8ca746928c55dd", 0.07 ) );
    turret function_2c12bb2c33b2fd19( getdvarfloat( @"hash_8282dfac90ba34d7", 0.35 ) );
    vehicle notify( #"upgrade_message", "barrel_activated" );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x8f40dee2, Offset: 0x76fd
// Size: 0xd7
function function_d0613c21b838433b( vehicle, player )
{
    spawndata = spawnstruct();
    
    if ( isdefined( vehicle.var_95d0840a9a8356d1 ) )
    {
        spawndata.var_305ce2bb6ec0993d = vehicle.var_95d0840a9a8356d1;
    }
    
    if ( utility::issharedfuncdefined( %"hash_1c8a00baf3a72043", #"hash_9cd5a5ad2f0c37c7" ) )
    {
        turret = [[ utility::getsharedfunc( %"hash_1c8a00baf3a72043", #"hash_9cd5a5ad2f0c37c7" ) ]]( vehicle, spawndata );
        vehicle::register_turret( vehicle, turret, makeweapon( "iw9_tur_mrap_mp" ) );
        vehicle.occupantsreserving[ "gunner" ] = undefined;
        vehicle.var_5deb24d6fac0806b = undefined;
        vehicle_occupancy::update_occupancy( vehicle );
    }
    
    vehicle notify( #"upgrade_message", "grenade_turret_activated" );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xc9c6d323, Offset: 0x77dc
// Size: 0x42
function function_ef73a9141de20aaa( vehicle, player )
{
    vehicle.disablepopsmoke = 0;
    vehicle.popsmokeready = 1;
    vehicle notify( #"upgrade_message", "smoke_activated" );
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0xeae3c5bd, Offset: 0x7826
// Size: 0x41
function function_19f8a59ac361aab7( vehicle, player )
{
    vehicle vehicle_settopspeedforward( 42 );
    vehicle.fuelmultiplier = 0.5;
    vehicle notify( #"upgrade_message", "engine_activated" );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x48e3cff2, Offset: 0x786f
// Size: 0x36
function function_42955969fa9da035()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( isdefined( self.radar ) )
    {
        self.radar delete();
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xaa049845, Offset: 0x78ad
// Size: 0xc1
function function_9dc94b913e50a1ae( vehicle )
{
    if ( !isdefined( level.var_c6fa96a8e4fae376 ) )
    {
        level.var_c6fa96a8e4fae376 = level.common_kiosk_data common_kiosk_data::function_9d041619b6fccf18( "rew_truckupgrade" );
    }
    
    spawnorigin = vehicle gettagorigin( "tag_screen_left" );
    buystation = spawn( "script_model", spawnorigin );
    buystation linkto( vehicle, "tag_screen_left" );
    buystation.index = level.var_c6fa96a8e4fae376;
    buystation.overrideindex = level.var_c6fa96a8e4fae376;
    buystation.playersusing = [];
    buystation.var_435658721cd2f3f5 = 1;
    vehicle.buystation = buystation;
}

// Namespace br_gametype_truckwar
// Params 6
// Checksum 0xf28844b4, Offset: 0x7976
// Size: 0xaa
function function_1f7bd6492d2cb8c4( instance, part, state, player, bautouse, usestring )
{
    player.var_d5168c882218a620 = level.teamvehicles[ player.team ];
    buystation = level.teamvehicles[ player.team ].buystation;
    buystation.playersusing[ buystation.playersusing.size ] = player;
    player thread common_kiosk::_runpurchasemenu( buystation );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x688e91f0, Offset: 0x7a28
// Size: 0x39
function function_fb403d7f38efc744( vehicle )
{
    vehicle endon( #"death" );
    
    while ( true )
    {
        function_11aa8ee05b7575e2( vehicle.team );
        wait 0.1;
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x7eab3586, Offset: 0x7a69
// Size: 0x309
function function_11aa8ee05b7575e2( team, player )
{
    vehicle = level.teamvehicles[ team ];
    omnvarvalue = 0;
    
    if ( isdefined( vehicle ) && !vehicle.isdestroyed )
    {
        foreach ( vehicleupgrade in level.truckwarupgrades )
        {
            if ( isdefined( vehicleupgrade.upgradebit ) && vehicle_interact::upgrade_activated( vehicle, vehicleupgrade.ref ) )
            {
                omnvarvalue += 1 << vehicleupgrade.upgradebit;
            }
        }
        
        if ( vehicle_interact::upgrade_activated( vehicle, "trophy" ) )
        {
            omnvarvalue += vehicle.trophyammo << 3;
            
            if ( vehicle.trophyammo == 3 )
            {
                omnvarvalue += 32;
            }
        }
        
        if ( vehicle.health == vehicle.maxhealth )
        {
            omnvarvalue += 8192;
        }
        else if ( !vehicle vehicle_interact::function_72e531fd35c679d9() )
        {
            omnvarvalue += 2048;
        }
        else if ( isdefined( vehicle.refuelingpercentage ) )
        {
            omnvarvalue += 4096;
        }
        
        if ( vehicle.flipped )
        {
            omnvarvalue += 16384;
        }
    }
    else if ( function_5600eb428823ffdb( team ) )
    {
        omnvarvalue += 32768;
    }
    else
    {
        omnvarvalue += 1024;
    }
    
    healthvalue = 0;
    fuelvalue = 0;
    
    if ( isdefined( vehicle ) )
    {
        healthvalue = clamp( vehicle.health / vehicle.maxhealth, 0, 1 );
        fuelvalue = clamp( vehicle.fuel / level.var_7d2432d8f71c014a, 0, 1 );
    }
    
    if ( isdefined( player ) )
    {
        player omnvar_utility::setcachedclientomnvar( "ui_armored_truck_status", omnvarvalue );
        player omnvar_utility::setcachedclientomnvar( "ui_armored_truck_health", healthvalue );
        player omnvar_utility::setcachedclientomnvar( "ui_armored_truck_fuel", fuelvalue );
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    
    foreach ( p in players )
    {
        p omnvar_utility::setcachedclientomnvar( "ui_armored_truck_status", omnvarvalue );
        p omnvar_utility::setcachedclientomnvar( "ui_armored_truck_health", healthvalue );
        p omnvar_utility::setcachedclientomnvar( "ui_armored_truck_fuel", fuelvalue );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x75869fd5, Offset: 0x7d7a
// Size: 0x134
function function_f1b88a2d31bc96b0( itemname, var_91bea7963bae05e4 )
{
    if ( !isdefined( var_91bea7963bae05e4 ) )
    {
        return;
    }
    
    player = self;
    assert( isdefined( player ) );
    upgradestring = "";
    
    switch ( itemname )
    {
        case #"hash_816539877a1d1fdc":
            upgradestring = "armor";
            break;
        case #"hash_ad9b9dd5f299d159":
            upgradestring = "barrel";
            break;
        case #"hash_72146e01d3915d7":
            upgradestring = "uav";
            break;
        case #"hash_7f669e169bdba303":
            upgradestring = "engine";
            break;
        case #"hash_b7d856499be19287":
            upgradestring = "turret";
            break;
        case #"hash_f7b4d170b800b77e":
            upgradestring = "smoke";
            break;
        case #"hash_1bbe99c97bde7d67":
            upgradestring = "trophy";
            break;
    }
    
    if ( upgradestring != "" )
    {
        vehicle = level.teamvehicles[ player.team ];
        
        if ( !isdefined( vehicle ) )
        {
            return;
        }
        
        if ( vehicle_interact::upgrade_activated( vehicle, upgradestring ) )
        {
            return 0;
        }
        else
        {
            return 1;
        }
        
        return;
    }
    
    return var_91bea7963bae05e4;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x62d9a20d, Offset: 0x7eb6
// Size: 0xd7, Type: bool
function function_26f67459cca2c108( params )
{
    if ( params.itemdata.type != "vehicle" )
    {
        return true;
    }
    
    assetname = getxhashasset( "itemspawnentry:" + params.itemdata.ref );
    vehref = getscriptbundlefieldvalue( assetname, #"ref" );
    
    if ( vehref != %"hash_1c8a00baf3a72043" )
    {
        return true;
    }
    
    canreplace = params.player function_bfb7a6440103603();
    
    if ( !canreplace )
    {
        params.player namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"MP/VEHICLE_PURCHASE_FAILED" );
        params.player common_kiosk::_closepurchasemenuwithresponse( 2 );
        return false;
    }
    
    return true;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xd47acffe, Offset: 0x7f96
// Size: 0x1c
function function_d5f349836dfd62c6( params )
{
    thread function_337995b87b58fe3c( self.team );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x1de72792, Offset: 0x7fba
// Size: 0xb4
function function_b4c7c90a45e7e9fd( params )
{
    vehicle = params.vehicle;
    
    if ( isteameliminated( params.team ) )
    {
        waittillframeend();
        
        if ( isdefined( vehicle ) )
        {
            deletetruck( vehicle );
        }
        
        return;
    }
    
    function_172dbee6aed28df8( vehicle, self.team, 1 );
    thread function_ab3047138def638c( vehicle );
    thread function_fb403d7f38efc744( vehicle );
    vehicle setscriptablepartstate( "tag_buystation", "buystation_usable" );
    function_5ab4f3006e8c8ff0( self.team );
    thread br_gametype_dmz::showdmzsplash( "truckwar_vehicle_spawn_enabled", level.teamdata[ self.team ][ "alivePlayers" ] );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x49206609, Offset: 0x8076
// Size: 0x10
function function_fe8835b9f00d3c4d()
{
    return getdvarint( @"hash_9e315c398cde8b75", 0 );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x5dff0104, Offset: 0x808f
// Size: 0x79
function function_337995b87b58fe3c( team )
{
    if ( !( isdefined( self ) && isdefined( self.team ) ) )
    {
        return 0;
    }
    
    team = self.team;
    
    if ( !isdefined( level.vehicledrop ) )
    {
        level.vehicledrop = [];
    }
    
    level.vehicledrop[ self.team ] = 1;
    function_11aa8ee05b7575e2( self.team, self );
    
    if ( function_fe8835b9f00d3c4d() )
    {
        thread function_503469ed5c61dbe5();
    }
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x94d0e893, Offset: 0x8110
// Size: 0x50, Type: bool
function function_5600eb428823ffdb( team )
{
    if ( !isdefined( team ) )
    {
        if ( !( isdefined( self ) && isdefined( self.team ) ) )
        {
            return false;
        }
        
        team = self.team;
    }
    
    if ( !isdefined( level.vehicledrop ) )
    {
        return false;
    }
    
    return istrue( level.vehicledrop[ team ] );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xb57aea1, Offset: 0x8169
// Size: 0x2a
function function_5ab4f3006e8c8ff0( team )
{
    if ( !isdefined( team ) )
    {
        return 0;
    }
    
    level.vehicledrop[ team ] = undefined;
    function_11aa8ee05b7575e2( team );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xd0b224f9, Offset: 0x819b
// Size: 0x6f
function function_503469ed5c61dbe5()
{
    level endon( #"game_ended" );
    self endon( #"vehicle_drop_success" );
    
    if ( !( isdefined( self ) && isdefined( self.team ) ) )
    {
        return;
    }
    
    team = self.team;
    level notify( "monitor_death_for_airdrop_" + team );
    level endon( "monitor_death_for_airdrop_" + team );
    self waittill( #"death_or_disconnect" );
    function_5ab4f3006e8c8ff0( team );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x36f6f1c0, Offset: 0x8212
// Size: 0x56, Type: bool
function function_c559e80362faafd9()
{
    respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
    level.br_standard_loadout = respawnloadout[ 0 ];
    noextraammo = respawnloadout[ 1 ];
    br::givestandardtableloadout( 0, 1, noextraammo );
    
    if ( !isdefined( self.equipment[ "health" ] ) )
    {
        armor::function_f63c7d587db4fca7();
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x380e6bed, Offset: 0x8271
// Size: 0x17, Type: bool
function function_ef8cda80afe9762f()
{
    return !isdefined( level.teamvehicles[ self.team ] );
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x1525f005, Offset: 0x8291
// Size: 0x4f
function function_69613cfdb96f05b8()
{
    istruckwar = game_utility::getgametype() == "truckwar";
    
    if ( !istruckwar )
    {
        return;
    }
    
    var_5597aee8b9ae115c = function_fe8835b9f00d3c4d();
    
    if ( var_5597aee8b9ae115c )
    {
        if ( function_9ed0c737daeeb6b0() )
        {
            return 0;
        }
    }
    
    if ( !function_bfb7a6440103603() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x8825cdcb, Offset: 0x82e9
// Size: 0x124, Type: bool
function function_9ed0c737daeeb6b0()
{
    player = self;
    squad = teams::getteamdata( player.team, "players" );
    
    foreach ( squadmate in squad )
    {
        if ( isdefined( squadmate ) )
        {
            superref = squadmate supers_mp::getcurrentsuperref();
            
            if ( superref == "super_vehicle_drop" )
            {
                if ( squadmate getammocount( squadmate.super.staticdata.weapon ) > 0 )
                {
                    return true;
                }
                
                continue;
            }
            
            if ( squadmate br_default_inventory::function_46da5d3784eb9b40( 9245 ) )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( level.var_8828b182d5497d81 ) && level.var_8828b182d5497d81[ player.team ] )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x11cf43d7, Offset: 0x8416
// Size: 0x37, Type: bool
function function_bfb7a6440103603()
{
    if ( function_5600eb428823ffdb() )
    {
        return false;
    }
    
    if ( isdefined( level.teamvehicles ) && !isdefined( level.teamvehicles[ self.team ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0xe5f1df0e, Offset: 0x8456
// Size: 0xed
function function_e4e0ef6739c29dbd()
{
    level.truckwarupgrades = [];
    function_f9aaa83616bcd39( "armor", 1, "truckwar_vehicle_armor_upgraded", &function_848c29aa0c414660 );
    function_f9aaa83616bcd39( "trophy", 2, "truckwar_vehicle_trophy_upgraded", &function_97924ce70b4368e3 );
    function_f9aaa83616bcd39( "trophy_refill", undefined, "truckwar_vehicle_trophy_refilled", &function_9961ef81ad0e8566, &function_51cf7c5155f03c09, &function_d41a3420504e87e5 );
    function_f9aaa83616bcd39( "uav", 0, "truckwar_vehicle_portable_radar_upgraded", &function_5d6ce2543d80b47b );
    function_f9aaa83616bcd39( "barrel", 6, "truckwar_vehicle_barrel_upgraded", &function_3c413542b4330035 );
    function_f9aaa83616bcd39( "turret", 7, "truckwar_vehicle_turret_upgraded", &function_d0613c21b838433b );
    function_f9aaa83616bcd39( "smoke", 8, "truckwar_vehicle_smoke_upgraded", &function_ef73a9141de20aaa );
    function_f9aaa83616bcd39( "engine", 9, "truckwar_vehicle_engine_upgraded", &function_19f8a59ac361aab7 );
    function_f9aaa83616bcd39( "vehicle_repair", undefined, undefined, undefined, &function_d1ff77addfcea8d2, &_handlevehiclerepair );
}

// Namespace br_gametype_truckwar
// Params 6
// Checksum 0x712b39fc, Offset: 0x854b
// Size: 0x96
function function_f9aaa83616bcd39( ref, upgradebit, splashref, onactivatefunc, var_c097748b2028fafd, var_93846e1797136a3e )
{
    upgradeinfo = { #var_93846e1797136a3e:var_93846e1797136a3e, #var_c097748b2028fafd:var_c097748b2028fafd, #onactivatefunc:onactivatefunc, #splashref:splashref, #upgradebit:upgradebit, #ref:ref };
    level.truckwarupgrades[ ref ] = upgradeinfo;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xf5fa079e, Offset: 0x85e9
// Size: 0x3f
function function_6c7a95abbde3f7ca( ref )
{
    upgradeinfo = level.truckwarupgrades[ ref ];
    assert( isdefined( upgradeinfo ), "<dev string:x24>" + ref + "<dev string:x41>" );
    return upgradeinfo;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xb325e46a, Offset: 0x8631
// Size: 0xda, Type: bool
function function_12a764dabfc89d9f( params )
{
    if ( params.itemdata.type != "truckwar_upgrade" )
    {
        return false;
    }
    
    upgradeinfo = function_6c7a95abbde3f7ca( params.itemdata.ref );
    player = params.player;
    
    if ( isdefined( upgradeinfo.var_93846e1797136a3e ) )
    {
        player [[ upgradeinfo.var_93846e1797136a3e ]]( upgradeinfo.ref );
    }
    else
    {
        player function_3d46d0a4b47ce05d( upgradeinfo.ref );
    }
    
    splashref = upgradeinfo.splashref;
    
    if ( isdefined( splashref ) )
    {
        showsplashtoteam( player.team, splashref );
    }
    
    return true;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xc82034e0, Offset: 0x8714
// Size: 0xdf, Type: bool
function function_a027f48d03a84f14( params )
{
    if ( params.itemdata.type != "truckwar_upgrade" )
    {
        return true;
    }
    
    upgradeinfo = function_6c7a95abbde3f7ca( params.itemdata.ref );
    
    if ( isdefined( upgradeinfo.var_c097748b2028fafd ) )
    {
        purchasesuccess = [[ upgradeinfo.var_c097748b2028fafd ]]( upgradeinfo.ref );
    }
    else
    {
        purchasesuccess = params.player function_f6d3df6bd8daadaf( upgradeinfo.ref );
    }
    
    if ( !purchasesuccess )
    {
        params.player namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"MP/VEHICLE_PURCHASE_FAILED" );
        params.player common_kiosk::_closepurchasemenuwithresponse( 2 );
        return false;
    }
    
    return true;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x2a54ab7e, Offset: 0x87fc
// Size: 0x54, Type: bool
function function_d1ff77addfcea8d2( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle.health == vehicle.maxhealth )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x1bd64883, Offset: 0x8859
// Size: 0x5d, Type: bool
function function_51cf7c5155f03c09( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( !vehicle_interact::upgrade_activated( vehicle, "trophy" ) || vehicle.trophyammo == 3 )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x76c88b7c, Offset: 0x88bf
// Size: 0x49, Type: bool
function function_f6d3df6bd8daadaf( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle_interact::upgrade_activated( vehicle, upgradetype ) )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xb8a92a52, Offset: 0x8911
// Size: 0x1ab, Type: bool
function _handlevehiclerepair( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle.health == vehicle.maxhealth )
        {
            return false;
        }
        
        var_5cc8bd1686cafb31 = getdvarfloat( @"hash_3c1b0adf9da014a0", 0.25 );
        var_7ce4277b31b82c7e = int( vehicle.maxhealth * var_5cc8bd1686cafb31 );
        vehicle vehicle_damage::add_health( var_7ce4277b31b82c7e );
        playsoundatpos( vehicle.origin + ( 0, 0, 20 ), "veh_truckwars_repair" );
        function_b685b7bab062d6bd( vehicle );
        
        if ( vehicle.armoractive )
        {
            function_e80e774a7affa200( vehicle );
        }
        
        players = teams::getteamdata( self.team, "players" );
        
        foreach ( player in players )
        {
            if ( getdvarint( @"hash_38d15e2d7ddbf066", 1 ) == 1 )
            {
                player damagefeedback::hudicontype( "truckheal" );
            }
            
            player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", vehicle.health );
            player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", vehicle.maxhealth );
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xda9eb0aa, Offset: 0x8ac5
// Size: 0x43, Type: bool
function function_d41a3420504e87e5( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        vehicle_interact::give_upgrade( vehicle, upgradetype, player );
        return true;
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0xe1696d89, Offset: 0x8b11
// Size: 0x54, Type: bool
function function_3d46d0a4b47ce05d( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle_interact::upgrade_activated( vehicle, upgradetype ) )
        {
            return false;
        }
        else
        {
            vehicle_interact::give_upgrade( vehicle, upgradetype, player );
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_truckwar
// Params 0
// Checksum 0x2d9de477, Offset: 0x8b6e
// Size: 0x2f8
function function_8f4c559dabb85ea2()
{
    if ( level.mapname == "mp_rex_tumen" )
    {
        function_beff62687f9846c3( ( 3778, 1865, 465 ) );
        function_beff62687f9846c3( ( -19092, -32758, 1050 ) );
        function_beff62687f9846c3( ( 17735, -12827, 450 ) );
        function_beff62687f9846c3( ( 29558, -3566, 342 ) );
        function_beff62687f9846c3( ( 41900, -22687, 392 ) );
        function_beff62687f9846c3( ( 40266, -36349, 324 ) );
        function_beff62687f9846c3( ( 27148, -24434, 451 ) );
        function_beff62687f9846c3( ( -3849, -13134, 1268 ) );
        function_beff62687f9846c3( ( 7270, -22152, 1038 ) );
        function_beff62687f9846c3( ( 10350, -34343, 482 ) );
        function_beff62687f9846c3( ( 29929, -39371, 458 ) );
        function_beff62687f9846c3( ( 10436, -39963, 607 ) );
        function_beff62687f9846c3( ( -2469, -20381, 3284 ) );
        function_beff62687f9846c3( ( -13909, -3905, 806 ) );
        function_beff62687f9846c3( ( -15002, -17769, 1239 ) );
        function_beff62687f9846c3( ( -9618, -28120, 1563 ) );
        function_beff62687f9846c3( ( 362, -36861, 1386 ) );
        function_beff62687f9846c3( ( -19969, -49237, 1166 ) );
        function_beff62687f9846c3( ( -35011, -48988, 1266 ) );
        function_beff62687f9846c3( ( -45462, -34204, 1118 ) );
        function_beff62687f9846c3( ( -38132, -23580, 1142 ) );
        function_beff62687f9846c3( ( -33234, -7005, 1137 ) );
        function_beff62687f9846c3( ( -45936, -11066, 2143 ) );
        function_beff62687f9846c3( ( -46618, -341, 2208 ) );
        function_beff62687f9846c3( ( -22059, 7977, 812 ) );
        function_beff62687f9846c3( ( -19548, 23693, 1145 ) );
        function_beff62687f9846c3( ( -40494, 10053, 2752 ) );
        function_beff62687f9846c3( ( -33886, 21766, 2758 ) );
        function_beff62687f9846c3( ( 20752, -48242, 758 ) );
        function_beff62687f9846c3( ( 20152, -35903, 546 ) );
        function_beff62687f9846c3( ( 7112, -5656, 830 ) );
        function_beff62687f9846c3( ( -5852, 4621, 608 ) );
        function_beff62687f9846c3( ( -27699, -41236, 1014 ) );
        function_beff62687f9846c3( ( 5337, -56305, 769 ) );
        function_beff62687f9846c3( ( 18333, 3166, 569 ) );
        function_beff62687f9846c3( ( -34903, -33588, 1560 ) );
        function_beff62687f9846c3( ( 33090, -13847, 513 ) );
    }
}

// Namespace br_gametype_truckwar
// Params 2
// Checksum 0x53674c6f, Offset: 0x8e6e
// Size: 0x63
function function_beff62687f9846c3( origin, angles = ( 0, 0, 0 ) )
{
    struct = { #targetname:"mp_truckwar_team_start_spawn", #angles:angles, #origin:origin };
    utility::addstruct( struct );
}

// Namespace br_gametype_truckwar
// Params 1
// Checksum 0x41792e10, Offset: 0x8ed9
// Size: 0x32
function deletetruck( vehicle )
{
    vehicle utility::callsharedfunc( vehicle.vehicletype, #"delete", vehicle );
    vehicle delete();
}

/#

    // Namespace br_gametype_truckwar
    // Params 2
    // Checksum 0x6cf0f7d9, Offset: 0x8f13
    // Size: 0x152, Type: dev
    function handledevcommand( command, args )
    {
        firstplayer = level.players[ 0 ];
        vehicle = level.teamvehicles[ firstplayer.team ];
        
        switch ( command )
        {
            case #"hash_daf9b522ac1db9f0":
                damage = isdefined( args[ 0 ] ) ? int( args[ 0 ] ) : 1000;
                
                if ( isdefined( vehicle ) )
                {
                    vehicle dodamage( damage, vehicle.origin );
                }
                
                break;
            case #"hash_e624cce9e63b643d":
                if ( isdefined( vehicle ) )
                {
                    deletetruck( vehicle );
                }
                
                break;
            case #"hash_93bd7b05706c80bb":
                assert( isdefined( args[ 0 ] ), "<dev string:x6f>" );
                upgraderef = args[ 0 ];
                fakeparams = { #player:firstplayer };
                fakeparams.itemdata = { #ref:upgraderef, #type:"<dev string:xa0>" };
                firstplayer.var_d5168c882218a620 = vehicle;
                
                if ( function_a027f48d03a84f14( fakeparams ) )
                {
                    function_12a764dabfc89d9f( fakeparams );
                }
                
                firstplayer.var_d5168c882218a620 = undefined;
                break;
        }
    }

#/
