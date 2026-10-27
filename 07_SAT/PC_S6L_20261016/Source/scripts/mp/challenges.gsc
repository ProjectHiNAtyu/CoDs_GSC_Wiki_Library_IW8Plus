// scripts\mp\challenges.gsc  (hash_1576a58623076050.gscc) (size: 140071 Bytes / 0x22327 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8b76020 (3099025440)
// size ...... 140071 (0x22327)
// includes .. 39  (offset: 0x212bb)
// strings ... 186 (offset: 0x213f3)
// dev strs .. 97  (offset: 0x21df7)
// exports ... 313 (offset: 0x18997)
// cseg ...... 0x138d + 0x1760a (0x18997)
// imports ... 468 (offset: 0x1ba7f)
// animtree1 . 0   (offset: 0x22327)
// animtree2 . 0   (offset: 0x22327)
#using scripts\common\ae_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\ai_fortress;
#using scripts\mp\bounty_wanted;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\challenges_super;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\playerachievements;
#using scripts\mp\sprays;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace challenges;

// Namespace challenges
// Params 0
// Checksum 0xb332f990, Offset: 0x13ab
// Size: 0x893
function init()
{
    if ( !challengesenabled() )
    {
        return;
    }
    
    if ( getdvarint( @"hash_d6adc2f3d29cea24", 0 ) )
    {
        function_5466111bdb1c76a5();
        gamemode = getchallengegamemode();
        gametype = function_9edd00e9e48c0821();
        var_366bbc2b00f0a2b = [];
        var_366bbc2b00f0a2b[ ae_utility::function_85018ebf5b896513( #"version" ) ] = 1;
        var_366bbc2b00f0a2b[ ae_utility::function_85018ebf5b896513( #"gamemode" ) ] = gamemode;
        var_366bbc2b00f0a2b[ ae_utility::function_85018ebf5b896513( #"gametype" ) ] = gametype;
        var_366bbc2b00f0a2b[ ae_utility::function_85018ebf5b896513( #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
        function_1adeff7923cc64cb( var_366bbc2b00f0a2b );
    }
    
    function_aa1fed84c5b8453f();
    callback::add( #"uav_tower_used", &onuavtowerused );
    callback::add( "vehicle_out_of_fuel", &onvehicleoutoffuel );
    callback::add( #"player_enter_poi", &function_1e78b9d91bf1d271 );
    callback::add( "player_enter_area", &function_4fac60d6b8d8497e );
    callback::add( "request_team_assim", &onrequestteamassimilate );
    callback::add( "player_open_supply_drop", &onopensupplydrop );
    callback::add( "player_refuel_vehicle_with_gas_can", &ongascanrefuel );
    callback::add( "player_pop_tire", &function_56fe274ff87ed071 );
    callback::add( "player_pop_enemy_tire", &function_6c06e212d17a83bb );
    callback::add( "player_shatter_window", &function_7f031af18c0d80d5 );
    callback::add( "player_siphoned_vehicle", &onvehiclesiphoned );
    callback::add( "team_engaged_activity", &function_2a24fb223cef78d6 );
    callback::add( #"player_unlock_door", &function_fdae19e8656d7037 );
    callback::add( "stronghold_cleared", &function_b826e89ae082c296 );
    callback::add( #"on_squad_wiped", &onsquadwiped );
    callback::add( "on_heal_done", &function_3c9a237d3a836cc9 );
    callback::add( "on_player_spawn", &onspawn );
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"hash_244314ef9125e636", &function_a34aef984160a893 );
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"game_ended", &function_cf7e0fbbd1e7f02c );
    callback::add( #"round_ended", &onroundend );
    callback::add( #"equipment_reclaimed", &function_357d6dd4398b72b1 );
    callback::add( #"equipment_stuck", &function_382d10bdfa3df537 );
    callback::add( "player_exit_bubble_shield", &function_a6d8e0e4dc1af072 );
    callback::add( #"equipment_destroyed", &function_f56cc326196bc3b8 );
    callback::add( #"hash_6fbac24ba0a39999", &function_6dbcd6a03cc2995 );
    callback::add( #"equipment_bounce", &function_8ef70448286a463f );
    callback::add( #"hash_47d8289e20141bc6", &function_89b9d583de74725c );
    callback::add( #"star_system_level", &function_1d1f7091b3bbad40 );
    callback::add( #"hash_bb2b63d9cf172bfa", &function_35a7c37cc251fab1 );
    callback::add( #"hash_e34050110d93f51e", &function_749d24e2330d50e8 );
    callback::add( #"hash_10e686549630fd9f", &function_a0a78ce46ff39e07 );
    callback::add( #"playerexitsmoke", &function_852de430774c0908 );
    callback::add( #"on_heal", &function_3c9a237d3a836cc9 );
    callback::add( #"field_upgrade_hit", &function_56741bf9f7e6cf94 );
    callback::add( #"field_upgrade_respawn", &function_91abe0d8db7d5339 );
    callback::add( #"hash_2af4adf11224c49a", &function_f3ffc3fa6aa3a992 );
    callback::add( #"hash_35b417d415734a36", &function_709c656f19357131 );
    callback::add( #"mission_manager_mission_assigned", &function_548724e2d845e340 );
    callback::add( #"hash_3b624ee937e164e7", &function_548724e2d845e340 );
    callback::add( #"activity_complete", &function_99019a61c5e82233 );
    callback::add( #"on_player_enters_location", &function_bc0e025637b91902 );
    callback::add( #"gasmask_dropped", &function_46cac71384f3e55e );
    callback::add( #"gasmask_equipped", &function_60129a10c37d5c5 );
    callback::add( "dmz_vehicle_refueled_at_gas_station", &function_5c3667480287d225 );
    callback::add( "dmz_looted_airdrop", &function_2bda238d3137cb52 );
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_8f5fb7dd4d5c586f )
    {
        function_a88e01ba79fb2a02();
        function_31317dfecad821b0( #"capture", #"hash_a836ce9ab43d9e2", &function_ec101d3f878494bf );
        function_31317dfecad821b0( #"capture_defense", #"hash_a4277d17a7a228c9", &function_5ffc53c827692fa4 );
        function_31317dfecad821b0( #"hash_f20cb38bfebefb7e", #"hash_3c955b1e6fcd76eb", &function_9608ed71aa7de8f0 );
        function_31317dfecad821b0( #"hash_f20cb38bfebefb7e", #"hash_45277be78cb54c51", &function_58eb48ff5906a8c2 );
        function_31317dfecad821b0( #"neutralized", #"hash_33ab895f04e4eec9", &function_489ca7f201fde686 );
        function_31317dfecad821b0( #"pick_up", #"hash_249e26f937238db4", &onpickedup );
        function_31317dfecad821b0( #"drop", #"hash_a21546ba725310a2", &ondropped );
        function_31317dfecad821b0( #"hash_c877d40e1571dbd7", #"hash_754b791c5072837b", &function_e47a24fd9221ed8b );
        function_31317dfecad821b0( #"plant_bomb", #"hash_4b88ae7136a85bfd", &onplanted );
        function_31317dfecad821b0( #"defuse_bomb", #"hash_e19a9f3d97f3e18f", &ondefused );
        function_31317dfecad821b0( #"detonate_bomb", #"hash_3a1fe5e4df493585", &ondetonated );
        function_31317dfecad821b0( #"objective_deactivated", #"hash_89cf712b23a4d7b5", &function_f6f69ec70065b12d );
        function_31317dfecad821b0( #"objective_activated", #"hash_92c01688276809dc", &function_d510bc68cca04cf2 );
        function_31317dfecad821b0( #"collect_friendly", #"hash_64d5ef3aec7665f8", &function_2f8940e6d018a0df );
        function_31317dfecad821b0( #"collect_hostile", #"hash_163ce3e6ccfcab8d", &function_355c3101e536f3bc );
    }
    
    level.var_d5d1baab32eedb10 = {};
    
    if ( isdefined( level.gamemodebundle ) )
    {
        if ( level.gamemodebundle.var_c0635ebb0978e50c )
        {
            callback::add( #"player_extracted", &onextract );
        }
        
        if ( level.gamemodebundle.var_7bfee98161b86c51 )
        {
            callback::add( #"hash_79fff19f74169f8e", &function_c8a2ae95b4786b5f );
        }
        
        if ( level.gamemodebundle.var_8cd66285a2f6605b )
        {
            callback::add( #"player_item_pickup", &function_a9cc756d803543a5 );
        }
        
        if ( !getdvarint( @"hash_ab96d4e560e43394", 0 ) && !level.gamemodebundle.var_168d3f1d0b6cf209 )
        {
            callback::add( #"hash_476254565e0a712c", &function_57ea1e5a2a77666 );
        }
    }
    
    callback::add( #"player_assimilated", &function_1d339a64becbde9b );
    
    /#
        thread function_3a80faeb43be0c69();
        level thread dev::devcommandwatcher( @"debug_challenge", &function_26ef1cb49afeb946 );
    #/
    
    utility::registersharedfunc( #"challenges", #"reportchallengeuserserializedeventwrapper", &reportchallengeuserserializedeventwrapper );
    utility::registersharedfunc( #"challenges", #"reportchallengeuserserializeddicteventinternal", &reportchallengeuserserializeddicteventinternal );
    utility::registersharedfunc( #"challenges", #"hash_4dbee06d8fb19056", &set_medal_challenge );
    utility::registersharedfunc( #"challenges", #"hash_ffd58417e2580271", &getchallengegamemode );
    utility::registersharedfunc( #"challenges", #"hash_6f34c2d719d3024a", &function_9edd00e9e48c0821 );
    utility::registersharedfunc( #"challenges", #"hash_abec5b6ff2cce352", &challengesenabledforplayer );
    utility::registersharedfunc( #"challenges", #"hash_20d6b9ff2d84e1e7", &function_f4c306eea6673ab0 );
    utility::registersharedfunc( #"challenges", #"hash_c1ac67fc66891430", &function_a0936b0e5b4550f3 );
    
    if ( getdvarint( @"hash_2e40cf82b0bb8fed" ) )
    {
        level thread function_3c4885f4872e0a86();
    }
    
    if ( !isdefined( level.var_431d3dd6b0605770 ) )
    {
        level.var_431d3dd6b0605770 = getdvarint( @"hash_bd2bb9f10c3af5e8", 1 );
    }
}

/#

    // Namespace challenges
    // Params 0
    // Checksum 0x98b15e39, Offset: 0x1c46
    // Size: 0x49, Type: dev
    function function_3a80faeb43be0c69()
    {
        while ( true )
        {
            wait 1;
            
            if ( !getdvarint( @"hash_48ae63d778571691", 0 ) )
            {
                continue;
            }
            
            setdvar( @"force_challenges", 1 );
            setdvar( @"pmc_mission_enabled", 1 );
            return;
        }
    }

#/

// Namespace challenges
// Params 0
// Checksum 0x9d50d678, Offset: 0x1c97
// Size: 0x86
function function_aa1fed84c5b8453f()
{
    foreach ( team in level.teamnamelist )
    {
        level.teamdata[ team ][ "poisVisited" ] = [];
    }
}

// Namespace challenges
// Params 0
// Checksum 0xda90767d, Offset: 0x1d25
// Size: 0x41
function challengesenabled()
{
    if ( level.challengesallowed && getdvarint( @"hash_ee0e5c147b44222", 0 ) )
    {
        level.challengesallowed = 0;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return 0;
        }
    #/
    
    return level.challengesallowed;
}

// Namespace challenges
// Params 0
// Checksum 0x319714e3, Offset: 0x1d6f
// Size: 0x97, Type: bool
function challengesenabledforplayer()
{
    /#
        if ( getdvarint( @"hash_8f8f9636a23ed652", 0 ) )
        {
            return true;
        }
    #/
    
    if ( !challengesenabled() )
    {
        return false;
    }
    
    if ( level.var_9b3243830eeafdbd )
    {
        return false;
    }
    
    if ( isdefined( self.var_15dfdd0e99a759e5 ) )
    {
        return false;
    }
    
    /#
        if ( !isdefined( level.var_28f304862f43ac5d ) )
        {
            level.var_28f304862f43ac5d = getdvarint( @"hash_455ed09fe13bd89d", 0 );
        }
        
        if ( level.var_28f304862f43ac5d != 0 )
        {
            if ( isbot( self ) )
            {
                return true;
            }
        }
    #/
    
    if ( !isplayer( self ) || isai( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace challenges
// Params 0, eflags: 0xc
// Checksum 0x65e1163a, Offset: 0x1e0f
// Size: 0x107
function private function_3c4885f4872e0a86()
{
    self notify( #"hash_778b94518c400e7f" );
    self endon( #"hash_778b94518c400e7f" );
    reportinginterval = getdvarfloat( @"hash_87bae6334863567" );
    assert( reportinginterval, "<dev string:x24>" );
    
    if ( !isdefined( reportinginterval ) )
    {
        reportinginterval = 30;
    }
    
    self waittill( #"matchstarttimer_done" );
    
    while ( true )
    {
        if ( !level.var_89fedc7ebd00b7c8.size )
        {
            wait reportinginterval / 10;
            continue;
        }
        
        var_61c4c7985891912a = arraycopy( level.var_89fedc7ebd00b7c8 );
        var_48386fe02f63e8b0 = reportinginterval / var_61c4c7985891912a.size;
        
        if ( var_48386fe02f63e8b0 <= level.framedurationseconds )
        {
            var_48386fe02f63e8b0 = level.framedurationseconds;
        }
        
        for ( playerindex = var_61c4c7985891912a.size - 1; playerindex >= 0 ; playerindex-- )
        {
            if ( !var_61c4c7985891912a[ playerindex ] )
            {
                wait var_48386fe02f63e8b0;
                continue;
            }
            
            player = var_61c4c7985891912a[ playerindex ];
            player thread function_d90cae87925ded51( player function_27fcee7af9809e93() );
            wait var_48386fe02f63e8b0;
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xbd4c6af0, Offset: 0x1f1e
// Size: 0x1bd
function private function_d90cae87925ded51( var_5a47096df71effa6 )
{
    if ( var_5a47096df71effa6.var_74c4e5c924ede948 <= 0 )
    {
        return;
    }
    
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = getplaylistid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"cumulative_score" ) ] = var_5a47096df71effa6.cumulativescore;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"score_since_last_report" ) ] = var_5a47096df71effa6.var_74c4e5c924ede948;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"cumulative_objective_score" ) ] = var_5a47096df71effa6.var_928e002165b9266;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"objective_score_since_last_report" ) ] = var_5a47096df71effa6.var_c3384eab5293e2b3;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_ce8f351716fb24b" ) ] = var_5a47096df71effa6.var_34b723fb5b9376a5;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_85eab6b0a74a66f8" ) ] = var_5a47096df71effa6.var_c50d1dcf3a6b28b0;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0xad82af5e, Offset: 0x20e3
// Size: 0x179
function function_982c8e69cf3fa5c4( ltmtype, var_9e7dc634a2f42a9 )
{
    if ( !var_9e7dc634a2f42a9.var_4c35d13f1c15573 )
    {
        return;
    }
    
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !ltmtype )
    {
        assert( 0, "<dev string:x81>" );
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = getplaylistid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_8a8506f95166653f" ) ] = ae_utility::function_357622cc2d8da787( ltmtype );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9da4ff6bae49e6cf" ) ] = var_9e7dc634a2f42a9.var_5b13a5f3f7a14abe;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ltm_score_since_last_report" ) ] = var_9e7dc634a2f42a9.var_4c35d13f1c15573;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0x117db25f, Offset: 0x2264
// Size: 0x1f, Type: bool
function challengetimersenabledforplayer()
{
    if ( !level.challengetimersenabled )
    {
        return false;
    }
    
    if ( !challengesenabledforplayer() )
    {
        return false;
    }
    
    return true;
}

// Namespace challenges
// Params 1
// Checksum 0xde5a8d2b, Offset: 0x228c
// Size: 0x31, Type: bool
function validchallengetimer( challengename )
{
    if ( !isdefined( self.challengestarttime ) )
    {
        return false;
    }
    
    if ( !isdefined( self.challengestarttime[ challengename ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace challenges
// Params 0
// Checksum 0x63e15705, Offset: 0x22c6
// Size: 0x16, Type: bool
function function_c658162aaf8367f1()
{
    return istrue( level.gamemodebundle.var_c658162aaf8367f1 );
}

// Namespace challenges
// Params 5
// Checksum 0x4547a316, Offset: 0x22e5
// Size: 0x1a5
function reportchallengeuserserializeddicteventinternal( eventplayer, aeeventname, params, var_b263f31ce0e76beb, reportdelay )
{
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    
    if ( !isdefined( aeeventid ) )
    {
        /#
            iprintln( "<dev string:xdf>" );
        #/
        
        return;
    }
    
    isintvalue = isint( aeeventid );
    var_73812bc5a84a14ee = isintvalue && aeeventid > 0;
    
    if ( !var_73812bc5a84a14ee && !isstring( aeeventid ) )
    {
        /#
            iprintln( "<dev string:x147>" );
        #/
        
        return;
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, params );
    #/
    
    eventplayer function_2e45314624fdfdb8( aeeventid, params, reportdelay );
    
    if ( function_c658162aaf8367f1() && ( var_b263f31ce0e76beb ?? 1 ) )
    {
        if ( isdefined( eventplayer.team ) )
        {
            var_42d8b64ff73708b0 = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squad_event" );
            
            if ( isdefined( var_42d8b64ff73708b0 ) )
            {
                players = teams::getteamdata( eventplayer.team, "players" );
                params[ var_42d8b64ff73708b0 ] = 1;
                
                foreach ( player in players )
                {
                    if ( eventplayer != player )
                    {
                        /#
                            function_ee4471f0d17f1d51( aeeventid, params );
                        #/
                        
                        player function_2e45314624fdfdb8( aeeventid, params, reportdelay );
                    }
                }
            }
        }
    }
}

// Namespace challenges
// Params 0
// Checksum 0xba68aaea, Offset: 0x2492
// Size: 0x26
function getchallengegamemode()
{
    if ( !isdefined( level.challengegamemode ) )
    {
        level.challengegamemode = getchallengegamemode_internal();
    }
    
    return level.challengegamemode;
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0xa18fb958, Offset: 0x24c1
// Size: 0x1f8
function private getchallengegamemode_internal()
{
    gamemode = 0;
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        gamemode = function_a23641f33e985edb( gamemode, 5 );
    }
    
    if ( level.casualModeEnabled )
    {
        gamemode = function_a23641f33e985edb( gamemode, 13 );
    }
    
    if ( level.gametypebundle.var_34dec82b77719a25 )
    {
        var_a1dee5674a2f1662 = getscriptbundlefieldvalue( level.gametypebundle.var_34dec82b77719a25, #"id" );
        
        if ( level.gamemodebundle.var_834c4c43ec9a8b8c )
        {
            return function_a23641f33e985edb( gamemode, var_a1dee5674a2f1662 );
        }
        else
        {
            return ( gamemode | var_a1dee5674a2f1662 );
        }
    }
    
    if ( level.leagueplaymatch )
    {
        gamemode = function_a23641f33e985edb( gamemode, 6 );
        return gamemode;
    }
    
    if ( level.var_7f85d8c232d790ed )
    {
        gamemode = function_a23641f33e985edb( gamemode, 10 );
        return gamemode;
    }
    
    if ( level.var_309e3d9dac389de6 )
    {
        gamemode = function_a23641f33e985edb( gamemode, 7 );
        return gamemode;
    }
    
    if ( isbrgamemode() )
    {
        gamemode = function_a23641f33e985edb( gamemode, 3 );
        return gamemode;
    }
    
    gametype = game_utility::getgametype();
    
    if ( isdefined( gametype ) )
    {
        if ( gametype == "brtdm" || gametype == "brtdm_mgl" )
        {
            gamemode = function_a23641f33e985edb( gamemode, 3 );
            return gamemode;
        }
        else if ( level.gamemodebundle.aegamemode == "OB" )
        {
            gamemode = function_a23641f33e985edb( gamemode, 9 );
            return gamemode;
        }
        else if ( isdefined( level.gamemodebundle.var_b59a71bc63d52e8b ) )
        {
            gamemodebit = getscriptbundlefieldvalue( hashcat( %"hash_1f262b85a18b69c7", level.gamemodebundle.var_b59a71bc63d52e8b ), #"id" );
            return ( gamemodebit | gamemode );
        }
        else if ( utility::issp() )
        {
            gamemode = function_a23641f33e985edb( gamemode, 0 );
            return gamemode;
        }
        else
        {
            gamemode = function_a23641f33e985edb( gamemode, 1 );
            return gamemode;
        }
    }
    
    return 0;
}

// Namespace challenges
// Params 0
// Checksum 0xf56ed559, Offset: 0x26c2
// Size: 0x1c
function function_9edd00e9e48c0821()
{
    return level.challengeandeventglobals.game_type_col[ game_utility::function_67138bc0fb9151ff() ];
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x2f28527c, Offset: 0x26e7
// Size: 0x30
function private getloadoutperks()
{
    if ( !self.lootperks.size )
    {
        return self.loadoutperks;
    }
    
    return arraycombine( self.lootperks, self.loadoutperks );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x32d8e95f, Offset: 0x2720
// Size: 0x1a3
function private function_526f9ed44fd5b893( var_2f493ccccbf55051 )
{
    assert( isdefined( var_2f493ccccbf55051 ), "<dev string:x1ab>" );
    var_86c674a64c35ed94 = { #var_7111292ef37e4f97:0, #var_ec7be02dd7cc6d7d:0 };
    var_78b8e4a13e63bc01 = [];
    
    foreach ( perk in var_2f493ccccbf55051 )
    {
        perkbit = perks::function_a9816793933d64bb( perk );
        perkbitfield = perks::function_fb163b91d0e32565( perk );
        
        if ( isdefined( perkbit ) && isdefined( perkbitfield ) )
        {
            switch ( perkbitfield )
            {
                case 1:
                    var_86c674a64c35ed94.var_ec7be02dd7cc6d7d = function_a23641f33e985edb( var_86c674a64c35ed94.var_ec7be02dd7cc6d7d, perkbit );
                    break;
                case 2:
                    var_86c674a64c35ed94.var_7111292ef37e4f97 = function_a23641f33e985edb( var_86c674a64c35ed94.var_7111292ef37e4f97, perkbit );
                    break;
                default:
                    break;
            }
            
            continue;
        }
        
        var_78b8e4a13e63bc01[ var_78b8e4a13e63bc01.size ] = perk;
    }
    
    params = { #var_86c674a64c35ed94:var_86c674a64c35ed94, #var_78b8e4a13e63bc01:var_78b8e4a13e63bc01 };
    callback::callback( #"hash_f873effec093bd7d", params );
    var_86c674a64c35ed94 = params.var_86c674a64c35ed94;
    return var_86c674a64c35ed94;
}

// Namespace challenges
// Params 1
// Checksum 0xe6471396, Offset: 0x28cc
// Size: 0xab
function function_c1eca4afdd49da1a( player )
{
    unoids = [];
    
    if ( isagent( player ) || !level.onlinegame )
    {
        for ( index = 0; index < 5 ; index++ )
        {
            unoids[ index ] = 0;
        }
        
        return unoids;
    }
    
    squadmates = player getfireteammembers();
    
    for ( index = 0; index < 5 ; index++ )
    {
        if ( isdefined( unoids ) && isdefined( squadmates[ index ] ) && squadmates[ index ] getplayerunoid() != "" )
        {
            unoids[ index ] = squadmates[ index ] getplayerunoid();
            continue;
        }
        
        unoids[ index ] = 0;
    }
    
    return unoids;
}

// Namespace challenges
// Params 2
// Checksum 0x45cd6224, Offset: 0x2980
// Size: 0x7d
function checkandreportchallengetimer( challengename, elapsedtime )
{
    if ( !challengetimersenabledforplayer() )
    {
        return;
    }
    
    if ( !validchallengetimer( challengename ) )
    {
        return;
    }
    
    if ( self.challengestarttime[ challengename ] > 0 )
    {
        accumulated_time = gettime() - self.challengestarttime[ challengename ];
        
        if ( accumulated_time >= elapsedtime )
        {
            reportstat( challengename, accumulated_time );
            self.challengestarttime[ challengename ] = gettime();
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0x34d8b0e2, Offset: 0x2a05
// Size: 0x1b
function function_d3fb2ff1e81d7bc0( player )
{
    starlevel = 0;
    return starlevel;
}

// Namespace challenges
// Params 1
// Checksum 0x1222aa94, Offset: 0x2a29
// Size: 0x1b
function getlocation( player )
{
    location = 0;
    return location;
}

// Namespace challenges
// Params 1
// Checksum 0xf374819f, Offset: 0x2a4d
// Size: 0xe4
function getlocation_2( player )
{
    location = 0;
    keyname = #"iw9_location_bitfield2";
    playerpoi = function_b38c74057441a440( player );
    
    if ( isdefined( playerpoi ) )
    {
        switch ( playerpoi )
        {
            case #"hash_f86b550bc635cac2":
                location = function_a23641f33e985edb( location, ae_utility::function_2d1565a236387b2( keyname, #"hash_56cd34cae7f6366c" ) );
                break;
            default:
                break;
        }
    }
    
    if ( isdefined( player.var_e7fae2aee1504843 ) )
    {
        switch ( player.var_e7fae2aee1504843 )
        {
            case #"hash_f86b550bc635cac2":
                location = function_a23641f33e985edb( location, ae_utility::function_2d1565a236387b2( keyname, #"hash_61e40db0057caa4f" ) );
                break;
            default:
                break;
        }
    }
    
    return location;
}

// Namespace challenges
// Params 2
// Checksum 0x6fa414f7, Offset: 0x2b3a
// Size: 0x1f5
function function_91749da806ed2063( player, locationtype )
{
    /#
        assert( isdefined( player ), "<dev string:x1ce>" );
        assert( isplayer( player ), "<dev string:x1fa>" );
        assert( isdefined( locationtype ), "<dev string:x230>" );
    #/
    
    locationbitfield = 0;
    
    switch ( locationtype )
    {
        case #"hash_c518111e891b32a4":
            locationname = player.var_b455d67c77a883b0;
            bitfieldname = #"hash_5377c467a47f38de";
            
            if ( player swim_common::isplayerunderwater() )
            {
                locationbitfield = function_a23641f33e985edb( locationbitfield, ae_utility::function_2d1565a236387b2( bitfieldname, #"underwater" ) );
            }
            
            if ( player.var_cca8507a7e7d424c || player.var_e5f7cde79d389fd0 )
            {
                locationbitfield = function_a23641f33e985edb( locationbitfield, ae_utility::function_2d1565a236387b2( bitfieldname, #"in_radiation" ) );
            }
            
            break;
        case #"hash_890e226c519dc6ab":
            locationname = player.var_6d451102c6aefbf6;
            bitfieldname = #"hash_8241ff1c332246d1";
            break;
        case #"hash_e422764f669256eb":
            locationname = player.var_e7fae2aee1504843;
            bitfieldname = #"hash_9eed6e7d716acfd1";
            break;
        default:
            return locationbitfield;
    }
    
    if ( isdefined( locationname ) )
    {
        foreach ( locpart in strtok( locationname, "|" ) )
        {
            bit = ae_utility::function_2d1565a236387b2( bitfieldname, getxhash( locpart ) );
            
            if ( isdefined( bit ) )
            {
                locationbitfield = function_a23641f33e985edb( locationbitfield, bit );
            }
        }
    }
    
    return locationbitfield;
}

// Namespace challenges
// Params 0
// Checksum 0x53314190, Offset: 0x2d38
// Size: 0x76
function function_9eb50f0c865a6b1b()
{
    location = 0;
    
    if ( isdefined( level.mapname ) )
    {
        mapname = removesubstr( level.mapname, "_mgl" );
        maphash = getxhash( mapname );
        var_dfeff6d3f5644ccf = ae_utility::function_2d1565a236387b2( #"br_map_name", maphash );
        
        if ( isdefined( var_dfeff6d3f5644ccf ) )
        {
            location = function_a23641f33e985edb( location, var_dfeff6d3f5644ccf );
        }
    }
    
    return location;
}

// Namespace challenges
// Params 0
// Checksum 0x8c4d89ec, Offset: 0x2db7
// Size: 0x76
function function_6a3bd1af73a5a390()
{
    if ( isdefined( level.sharedfuncs[ #"player" ][ #"getoperatorref" ] ) )
    {
        operatorref = self [[ level.sharedfuncs[ #"player" ][ #"getoperatorref" ] ]]();
        lootid = loot::getlootidfromref( operatorref );
        
        if ( !isdefined( lootid ) || lootid < 0 )
        {
            return 0;
        }
        
        return lootid;
    }
    
    return 0;
}

// Namespace challenges
// Params 0
// Checksum 0x150c260, Offset: 0x2e36
// Size: 0xd1
function function_a7e780cc2464a43b()
{
    if ( isdefined( level.sharedfuncs[ #"player" ][ #"getsuperfactionindex" ] ) )
    {
        superfactionindex = self [[ level.sharedfuncs[ #"player" ][ #"getsuperfactionindex" ] ]]();
        var_ef92732eba788a70 = int( abs( superfactionindex - 1 ) );
        
        if ( isdefined( level.sharedfuncs[ #"player" ][ #"hash_6dd14ba6248f5d2b" ] ) )
        {
            operatorref = self [[ level.sharedfuncs[ #"player" ][ #"hash_6dd14ba6248f5d2b" ] ]]( var_ef92732eba788a70 );
            lootid = loot::getlootidfromref( operatorref );
            
            if ( lootid < 0 )
            {
                return 0;
            }
            
            return lootid;
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0x23ef62b, Offset: 0x2f0f
// Size: 0x8b
function function_ff0a3bbd357d5501( objweapon )
{
    weaponname = undefined;
    
    if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) ) )
    {
        weaponname = "";
    }
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = equipment_mp::getequipmentreffromweapon( objweapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon::getdefaultweaponbasename( objweapon.basename );
        }
        
        if ( weaponname == "equip_throwing_knife_fire" || weaponname == "equip_throwing_knife_electric" || weaponname == "equip_shuriken" )
        {
            weaponname = "equip_throwing_knife";
        }
    }
    
    return weaponname;
}

// Namespace challenges
// Params 1
// Checksum 0x56d97610, Offset: 0x2fa3
// Size: 0x2e8
function getplayerstate( player )
{
    statebitfield = 0;
    
    if ( !isplayer( player ) )
    {
        return statebitfield;
    }
    
    state = player getstance();
    
    switch ( state )
    {
        case #"hash_3fed0cbd303639eb":
            statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"Crouching" ) );
            break;
        case #"hash_d91940431ed7c605":
            statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"hash_16b5f25bff4a00fe" ) );
            break;
        case #"hash_c6775c88e38f7803":
            statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"standing" ) );
            break;
        default:
            break;
    }
    
    if ( player ishanging() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"hanging" ) );
    }
    
    if ( player isswimming() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"swimming" ) );
    }
    
    if ( player issprinting() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"sprinting" ) );
    }
    
    if ( player issprintsliding() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"sprint_sliding" ) );
    }
    
    if ( player issupersprinting() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"super_sprinting" ) );
    }
    
    if ( player isjumping() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"jumping" ) );
    }
    
    if ( player function_3a8921c4f763879e() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"leaning" ) );
    }
    
    if ( player ismantling() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"mantling" ) );
    }
    
    if ( player isonladder() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"on_ladder" ) );
    }
    
    if ( player isonzipline() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"on_zipline" ) );
    }
    
    if ( player isparachuting() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"parachuting" ) );
    }
    
    if ( player isreloading() )
    {
        statebitfield = function_a23641f33e985edb( statebitfield, ae_utility::function_2d1565a236387b2( #"playerstate_bitfield", #"reloading" ) );
    }
    
    return statebitfield;
}

// Namespace challenges
// Params 1
// Checksum 0xc5a895d5, Offset: 0x3294
// Size: 0x27
function function_85b4707bca7512db( cashvalue )
{
    return cashvalue * ( level.gametypebundle.var_c81ba0137661d60e ?? 1 );
}

// Namespace challenges
// Params 2
// Checksum 0x31435401, Offset: 0x32c4
// Size: 0xfa
function function_ed6f10a45e5c6af7( lootid, quantity )
{
    if ( level.gametypebundle.var_d797fc37b0f44933 )
    {
        return quantity;
    }
    
    if ( isdefined( lootid ) && lootid != 0 )
    {
        scriptablename = loot::getScriptableFromLootID( lootid );
        
        if ( isdefined( scriptablename ) )
        {
            if ( lootid == 8395 )
            {
                return function_85b4707bca7512db( quantity );
            }
            
            if ( isdefined( level.sharedfuncs[ #"pickups" ][ #"hash_4201931139e54d1f" ] ) && [[ level.sharedfuncs[ #"pickups" ][ #"hash_4201931139e54d1f" ] ]]( scriptablename ) || isdefined( level.sharedfuncs[ #"pickups" ][ #"hash_d3dd34e8cb0853a" ] ) && [[ level.sharedfuncs[ #"pickups" ][ #"hash_d3dd34e8cb0853a" ] ]]( scriptablename ) )
            {
                return 1;
            }
        }
    }
    
    return quantity;
}

// Namespace challenges
// Params 2
// Checksum 0x1ab2ad63, Offset: 0x33c7
// Size: 0x53
function function_a23641f33e985edb( bitfield, bit )
{
    if ( !isdefined( bit ) || bit < 0 )
    {
        return bitfield;
    }
    
    if ( isstring( bitfield ) || bit == 63 )
    {
        return function_e74edf669e1ddceb( bitfield + "", bit );
    }
    
    return bitfield | 1 << bit;
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x34095daa, Offset: 0x3422
// Size: 0x75
function private function_e1f753174eeb4718()
{
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    teamsize = getmatchrulesdata( "commonOption", "teamSize" );
    basevalues = { #teamsize:teamsize, #gametype:gametype, #gamemode:gamemode };
    level.var_2a768cf86c439b4c = basevalues;
    return basevalues;
}

// Namespace challenges
// Params 4
// Checksum 0x4776f079, Offset: 0x34a0
// Size: 0xed
function function_df424ab6c42d089c( eventparamsstruct, aeeventname, aekeyname, value )
{
    if ( ae_utility::function_4b9f0ca95497e0c8( aeeventname, aekeyname ) )
    {
        keyid = ae_utility::function_70b8bc68f3d8031e( aeeventname, aekeyname );
        skipassert = level.var_e24e520c74711dd1 && level.var_c6549bd46c8ab0d6;
        
        if ( !skipassert )
        {
            level.var_c6549bd46c8ab0d6 = 1;
            assert( isdefined( keyid ), "<dev string:x262>" + getxhashsourcename( aekeyname ) + "<dev string:x288>" );
            assert( isdefined( value ), "<dev string:x2aa>" + getxhashsourcename( aekeyname ) + "<dev string:x288>" );
        }
        
        eventparamsstruct.eventparams[ keyid ] = value;
        return;
    }
    
    println( "<dev string:x2d0>" + getxhashsourcename( aekeyname ) + "<dev string:x2ee>" + getxhashsourcename( aeeventname ) + "<dev string:x303>" );
}

// Namespace challenges
// Params 2
// Checksum 0x5cd27985, Offset: 0x3595
// Size: 0x122
function function_29523bee3acd9533( attacker, victim )
{
    if ( isagent( victim ) || isplayer( victim ) )
    {
        onzipline = victim isonzipline();
    }
    
    victimstruct = spawnstruct();
    [ victimstruct.enemytype, victimstruct.var_e0303092a359edc4 ] = findenemytype( victim );
    victimstruct.biscritical = isdefined( victim.last_dmg_struct ) && victim.last_dmg_struct.biscritical;
    victimstruct.v_distance = int( distance( attacker.origin, victim.origin ) );
    victimstruct.origin = victim.origin;
    victimstruct.team = victim.team;
    victimstruct.on_zipline = istrue( onzipline );
    victimstruct.var_e38497c77f510aba = 1;
    return victimstruct;
}

// Namespace challenges
// Params 1
// Checksum 0x7c9ed16e, Offset: 0x36c0
// Size: 0xc4e
function findenemytype( victim )
{
    enemytype = 0;
    var_34c4673a21bda4c = 0;
    
    if ( isplayer( victim ) )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"player" ) );
    }
    
    isground = 0;
    isaerial = 0;
    issupport = 0;
    var_90418975ea4f9403 = 0;
    var_67632a521d76fc15 = 0;
    
    if ( isdefined( victim.streakinfo ) )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"killstreak" ) );
        killstreakname = victim.streakinfo.streakname;
        var_67632a521d76fc15 = killstreak_shared::iskillstreakvehicle( killstreakname );
        
        switch ( killstreakname )
        {
            case #"hash_10e585c25e7e9f60":
            case #"hash_b571a6187bf67f9e":
            case #"hash_4220be38a5f150b8":
            case #"hash_4d35eb58f9d545f0":
            case #"hash_56979e0566996b2e":
            case #"hash_b161e185f1b8e117":
            case #"hash_ed469a6bfff6b265":
                var_90418975ea4f9403 = 1;
                break;
            case #"hash_cd0a0403551fc411":
            case #"hash_4ad475e6e15635bd":
            case #"hash_4d5aa76e8707f47b":
            case #"hash_52d9b7ed584bec3e":
            case #"hash_cf0ef5bef19a311b":
            case #"hash_e477c24ee18bb2f6":
                isground = 1;
                break;
            case #"hash_691f39dddd9116b8":
            case #"hash_195360490caa3220":
            case #"hash_c45eaeb429cf1944":
            case #"hash_a1031216158c7882":
            case #"hash_28d0236400e33fd0":
            case #"hash_349713b5ad494dda":
            case #"hash_413c38e72fe8b5bf":
            case #"hash_55af30c2f519570a":
            case #"hash_e086cef548807bb2":
            case #"hash_e6bea339d3cbd3e8":
                isaerial = 1;
                break;
            case #"hash_e51f2e3d5cdd8ed8":
            case #"hash_f64c697bfb4c6b54":
            case #"hash_27002778019fb447":
                isaerial = 1;
                issupport = 1;
                break;
            case #"hash_19dd9a3a4147e09e":
                isground = 1;
                var_90418975ea4f9403 = 1;
                break;
            case #"hash_2289ec11d77bce8f":
                issupport = 1;
                var_90418975ea4f9403 = 1;
                break;
            case #"hash_b4ac3581c343a029":
            case #"hash_bf2f9adbd2b41d5":
            case #"hash_7a687f6a4d685110":
            case #"hash_8c766d6477287bb6":
            case #"hash_6362d6aae3e5a62e":
            case #"hash_b3b9048fbdb1c48f":
            case #"hash_9956fc544449f64":
                isaerial = 1;
                var_90418975ea4f9403 = 1;
                break;
            case #"hash_887ad77192b9c4fb":
            case #"hash_e171e5b86ef0a4cc":
            case #"hash_634b246c3da5c56f":
                isaerial = 1;
                issupport = 1;
                var_90418975ea4f9403 = 1;
                break;
        }
        
        var_187fb9d2b7753d75 = level.streakglobals.streakbundles[ killstreakname ];
        
        if ( var_187fb9d2b7753d75 )
        {
            if ( var_187fb9d2b7753d75.isauto )
            {
                isauto = isauto || var_187fb9d2b7753d75.isauto;
            }
            
            if ( var_187fb9d2b7753d75.isground )
            {
                isground = isground || var_187fb9d2b7753d75.isground;
            }
            
            if ( var_187fb9d2b7753d75.isaerial )
            {
                isaerial = isaerial || var_187fb9d2b7753d75.isaerial;
            }
            
            if ( var_187fb9d2b7753d75.issupport )
            {
                issupport = issupport || var_187fb9d2b7753d75.issupport;
            }
            
            if ( var_187fb9d2b7753d75.isvehicle )
            {
                isvehicle = isvehicle || var_187fb9d2b7753d75.isvehicle;
            }
        }
        
        if ( isground )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"ground" ) );
        }
        
        if ( isaerial )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"aerial" ) );
        }
        
        if ( issupport )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"support" ) );
        }
        
        if ( var_90418975ea4f9403 )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"auto_killstreak" ) );
        }
        else
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"piloted_killstreak" ) );
        }
    }
    
    if ( isdefined( victim vehicle::get_ref() ) )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"vehicle" ) );
        canfly = istrue( victim vehicle::can_fly() );
        isboat = istrue( victim vehicle::is_boat() );
        
        if ( isground && !canfly && !isboat )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"ground" ) );
        }
        else if ( isaerial || canfly )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"aerial" ) );
        }
        
        if ( victim vehicle::get_ref() == "dmz_boss_chopper" )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"chopper_boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"aerial" ) );
        }
        else if ( victim vehicle::get_ref() == "pac_sentry" )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"wheelson_boss" ) );
        }
        else if ( victim vehicle::get_ref() == "veh9_armored_acv_6x6" )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"getaway_boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
        }
        else if ( victim vehicle::get_ref() == "veh_rex_air_drone_helidualgun" || victim.isdrone )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"drone" ) );
        }
        
        if ( isdefined( victim.riders ) && victim.riders.size > 0 && isent( victim.riders[ 0 ] ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"veh_occupied" ) );
        }
        
        vehicletype = undefined;
        vehicleref = victim vehicle::get_ref();
        
        switch ( vehicleref )
        {
            case %"hash_21df6558fa3c728b":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"atv" );
                break;
            case %"vehiclebundle:light_tank_mp":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"light_tank" );
                break;
            case %"hash_49602cb7beee6fba":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"little_bird" );
                break;
            case %"hash_13a0340a4961ca24":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_acv_6x6" );
                break;
            case %"hash_79d97f9d1822b8fc":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_apc_8x8" );
                break;
            case %"hash_5b1746f66e66db96":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_blima" );
                break;
            case %"hash_1141b95edbf1d227":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_chopped_pickup" );
                break;
            case %"hash_7f492eb947d5169a":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_cougar" );
                break;
            case %"hash_38f9469ea4893813":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_hummer" );
                break;
            case %"hash_406987d5bb9cf080":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_jltv_mg" );
                break;
            case %"hash_3ca3e443e3da4c5":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_jltv" );
                break;
            case %"hash_77eba5cf011bc16c":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_mil_cargo_truck" );
                break;
            case %"hash_38fe1c7502792874":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_overland_2016" );
                break;
            case %"hash_1dd941f8f4026e3":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_palfa" );
                break;
            case %"hash_4c7e54cca5ad7fd8":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_patrol_boat" );
                break;
            case %"hash_79bb1c850aa99b89":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_pickup_2014" );
                break;
            case %"hash_425ab66196dfb969":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_pwc" );
                break;
            case %"vehiclebundle:veh9_rhib_mp":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_rhib" );
                break;
            case %"hash_3dff816eedc0901c":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_sedan_hatchback_1985" );
                break;
            case %"hash_7ad965933c54dd53":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_suv_1996" );
                break;
            case %"hash_e53867776d12349":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_techo_rebel_armor" );
                break;
            case %"hash_1b1311417250f5f4":
                vehicletype = ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"veh9_utv" );
                break;
        }
        
        if ( isdefined( vehicletype ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, vehicletype );
        }
        
        if ( isdefined( victim.riders ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"ai_vehicle" ) );
            
            if ( victim vehicle::get_ref() == %"hash_49602cb7beee6fba" || victim vehicle::get_ref() == %"hash_5b1746f66e66db96" )
            {
                enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"reinforcement_chopper" ) );
            }
        }
        
        if ( vehicle::is_enemy_to_player( victim, self, level.var_2e39067b524b6828 ?? 0 ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"enemy_vehicle" ) );
        }
    }
    else if ( var_67632a521d76fc15 )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"vehicle" ) );
    }
    
    if ( isdefined( victim.equipmentref ) )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"equipment" ) );
    }
    
    if ( isagent( victim ) )
    {
        if ( isdefined( victim.aitype ) )
        {
            enemytype = return_enemy_type_mask( enemytype, victim );
        }
        else if ( isdefined( victim.agent_type ) )
        {
            [ enemytype, var_34c4673a21bda4c ] = function_870e7aae54c61948( enemytype, var_34c4673a21bda4c, victim );
        }
    }
    
    return [ enemytype, var_34c4673a21bda4c ];
}

// Namespace challenges
// Params 2
// Checksum 0x144aaa1c, Offset: 0x4317
// Size: 0x3d, Type: bool
function function_9703fc332f123c66( agenttype, subcategory )
{
    return issubstr( agenttype, "cartel" ) || game_utility::function_87c1e942653b7c63() && isdefined( subcategory ) && subcategory == "elimTarget";
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0xc1ab49e8, Offset: 0x435d
// Size: 0x755
function private function_870e7aae54c61948( enemytype, var_34c4673a21bda4c, victim )
{
    if ( !isdefined( victim.agent_type ) )
    {
        return;
    }
    
    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"agent" ) );
    aitypescriptbundle = undefined;
    
    if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_97bddec4d38d3481 )
    {
        aitypescriptbundle = getaitypescriptbundle( victim.agent_type );
    }
    
    if ( aitypescriptbundle.var_8ad2ffa7e69c9641 || aitypescriptbundle.var_fad83652ff229574 )
    {
        if ( aitypescriptbundle.var_8ad2ffa7e69c9641 )
        {
            foreach ( struct in aitypescriptbundle.var_8ad2ffa7e69c9641 )
            {
                if ( struct.bit )
                {
                    enemytype = function_a23641f33e985edb( enemytype, struct.bit );
                }
            }
        }
        
        if ( aitypescriptbundle.var_fad83652ff229574 )
        {
            foreach ( struct in aitypescriptbundle.var_fad83652ff229574 )
            {
                if ( struct.bit )
                {
                    var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, struct.bit );
                }
            }
        }
        
        if ( victim.var_ce2f8b4ca895561 )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"has_hazmat_suit" ) );
        }
        
        if ( victim.var_1b1e8e95a7a7d01b )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"has_gas_mask" ) );
        }
    }
    else if ( issubstr( victim.agent_type, "civilian" ) )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"civilian" ) );
    }
    else
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"combatant" ) );
        
        if ( issubstr( victim.agent_type, "jugg" ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"juggernaut" ) );
        }
        else if ( issubstr( victim.agent_type, "riotshield" ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"riotshield" ) );
        }
        else if ( issubstr( victim.agent_type, "velikan" ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"velikan_boss" ) );
        }
        else if ( issubstr( victim.agent_type, "firebug" ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"firebug" ) );
        }
        else
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"soldier" ) );
        }
        
        if ( victim.elite )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"elite" ) );
        }
        
        [ enemytype, var_34c4673a21bda4c ] = function_8a8d69ea53872dae( victim, enemytype, var_34c4673a21bda4c );
        category = victim.category;
        subcategory = victim.subcategory;
        
        if ( issubstr( victim.agent_type, "aq" ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"AQ" ) );
        }
        else if ( issubstr( victim.agent_type, "biolab" ) || issubstr( victim.agent_type, "merc" ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"shadow_company" ) );
        }
        else if ( function_9703fc332f123c66( victim.agent_type, subcategory ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"cartel" ) );
        }
        
        if ( isdefined( category ) && isdefined( subcategory ) )
        {
            if ( category == "mission" && subcategory == "elimTarget" )
            {
                enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"elim_target" ) );
            }
            
            if ( category == "bosses" )
            {
                enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
                
                if ( subcategory == "jugg" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"juggernaut_boss" ) );
                }
                else if ( subcategory == "chemistBoss" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"chemist_boss" ) );
                }
                else if ( subcategory == "trapperBoss" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"trapper_boss" ) );
                }
                else if ( subcategory == " pyroBoss" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"pyro_boss" ) );
                }
                else if ( subcategory == "ratBoss" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"scav_boss" ) );
                }
                else if ( subcategory == "sniperBoss" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"sniper_boss" ) );
                }
                else if ( subcategory == "rusherBoss" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"rusher_boss" ) );
                }
                else if ( subcategory == "lt_mace" )
                {
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"mace_boss" ) );
                }
            }
        }
        
        if ( utility::issharedfuncdefined( #"challenges", #"hash_3a656de5d74b8c5" ) )
        {
            var_34c4673a21bda4c = utility::callsharedfunc( #"challenges", #"hash_3a656de5d74b8c5", var_34c4673a21bda4c, victim );
        }
    }
    
    return [ enemytype, var_34c4673a21bda4c ];
}

// Namespace challenges
// Params 2
// Checksum 0x4ac42f93, Offset: 0x4abb
// Size: 0x132
function return_enemy_type_mask( enemytype, victim )
{
    if ( !isdefined( victim.aitype ) )
    {
        return enemytype;
    }
    
    switch ( victim.aitype )
    {
        case #"hash_44aaeb0edd152195":
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"soldier" ) );
            break;
        case #"hash_4ad475e6e15635bd":
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"juggernaut" ) );
            break;
        case #"hash_1403dfb5d1265ddc":
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"suicidebomber" ) );
            break;
        case #"hash_321a9678047d0a4e":
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"riotshield" ) );
            break;
        default:
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"agent" ) );
            break;
    }
    
    return enemytype;
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0xc944016, Offset: 0x4bf6
// Size: 0x184
function private function_8a8d69ea53872dae( enemy, var_e4310e06399d4f01 = 0, var_8244a706acef310b = 0 )
{
    enemytier = enemy.tier ?? enemy ai_utility::get_power_tier();
    
    if ( !isdefined( enemytier ) )
    {
        return [ var_e4310e06399d4f01, var_8244a706acef310b ];
    }
    
    switch ( enemytier )
    {
        case 1:
            var_e4310e06399d4f01 = function_a23641f33e985edb( var_e4310e06399d4f01, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"tier1" ) );
            break;
        case 2:
            var_e4310e06399d4f01 = function_a23641f33e985edb( var_e4310e06399d4f01, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"armored" ) );
            var_e4310e06399d4f01 = function_a23641f33e985edb( var_e4310e06399d4f01, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"tier2" ) );
            break;
        case 3:
            var_e4310e06399d4f01 = function_a23641f33e985edb( var_e4310e06399d4f01, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"armored" ) );
            var_e4310e06399d4f01 = function_a23641f33e985edb( var_e4310e06399d4f01, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"tier3" ) );
            break;
        case 4:
            var_8244a706acef310b = function_a23641f33e985edb( var_8244a706acef310b, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"tier4" ) );
            break;
    }
    
    return [ var_e4310e06399d4f01, var_8244a706acef310b ];
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x74d349eb, Offset: 0x4d83
// Size: 0x960
function private function_70dee0eafbb25426( victim )
{
    if ( !isdefined( victim ) )
    {
        return [ 0, 0 ];
    }
    
    if ( victim.var_8958572f8db5a345 )
    {
        return [ victim.var_8958572f8db5a345, 0 ];
    }
    
    enemytype = 0;
    var_34c4673a21bda4c = 0;
    
    if ( isplayer( victim ) )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"player" ) );
    }
    
    isground = 0;
    isaerial = 0;
    issupport = 0;
    var_90418975ea4f9403 = 0;
    var_67632a521d76fc15 = 0;
    
    if ( isdefined( victim.streakinfo ) && !victim.streakinfo.superref && !victim.superinfo && !victim.superref )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"killstreak" ) );
        killstreakname = victim.streakinfo.streakname;
        var_67632a521d76fc15 = killstreak_shared::iskillstreakvehicle( killstreakname );
        isground = killstreak_shared::iskillstreakgrounded( killstreakname );
        isaerial = killstreak_shared::function_2e80bd8941888e8e( killstreakname );
        issupport = killstreak_shared::iskillstreaksupport( killstreakname );
        var_90418975ea4f9403 = killstreak_shared::iskillstreakauto( killstreakname );
        
        if ( isground )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"ground" ) );
        }
        
        if ( isaerial )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"aerial" ) );
        }
        
        if ( issupport )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"support" ) );
        }
        
        if ( var_90418975ea4f9403 )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"auto_killstreak" ) );
        }
        else
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"piloted_killstreak" ) );
        }
    }
    
    ref = victim.vehicleref ?? victim vehicle::get_ref();
    
    if ( ref )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"vehicle" ) );
        canfly = istrue( victim.var_41866f02e46fb475 ?? victim vehicle::can_fly() );
        isboat = istrue( victim.var_749669a6a8dda7d0 ?? victim vehicle::is_boat() );
        
        if ( isground && !canfly && !isboat )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"ground" ) );
        }
        else if ( isaerial || canfly )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"aerial" ) );
        }
        
        if ( ref == "dmz_boss_chopper" )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"chopper_boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"aerial" ) );
        }
        else if ( ref == "pac_sentry" )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"wheelson_boss" ) );
        }
        else if ( ref == "veh9_armored_acv_6x6" )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"getaway_boss" ) );
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"boss" ) );
        }
        
        vehicledata = undefined;
        
        if ( vehicle::has_data( ref ) )
        {
            vehicledata = vehicle::get_data( ref );
        }
        
        if ( victim.has_cargo )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"has_cargo" ) );
        }
        
        if ( victim vehicle::get_ref() == "veh_rex_air_drone_helidualgun" || victim.isdrone )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"drone" ) );
        }
        
        hasriders = isdefined( victim.riders ) && victim.riders.size > 0 && isent( victim.riders[ 0 ] );
        var_9dac96c7d2d3e4f4 = victim.var_6df564a41f1630bd && gettime() - victim.var_6df564a41f1630bd < 500;
        
        if ( hasriders || var_9dac96c7d2d3e4f4 )
        {
            var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"veh_occupied" ) );
        }
        
        if ( isdefined( vehicledata.var_7e4337460eef3e9 ) )
        {
            var_7e4337460eef3e9 = int( vehicledata.var_7e4337460eef3e9 );
            var_d83451c1bf446403 = int( vehicledata.var_d83451c1bf446403 ?? 1 );
            
            switch ( var_d83451c1bf446403 )
            {
                case 2:
                    var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, var_7e4337460eef3e9 );
                    break;
                case 1:
                default:
                    enemytype = function_a23641f33e985edb( enemytype, var_7e4337460eef3e9 );
                    break;
            }
        }
        
        if ( isdefined( victim.riders ) )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"ai_vehicle" ) );
            var_7b24e5615baa0378 = victim.var_b7aa763057412de8 ?? victim vehicle::function_1fe58ae318378aa8();
            
            if ( ref == %"hash_49602cb7beee6fba" || ref == %"hash_5b1746f66e66db96" || var_7b24e5615baa0378 )
            {
                enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"reinforcement_chopper" ) );
            }
        }
        
        var_5162191ffc87166 = victim.var_fd4d41ef858858b2 ?? vehicle::is_enemy_to_player( victim, self, level.var_2e39067b524b6828 ?? 0 );
        
        if ( var_5162191ffc87166 )
        {
            enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"enemy_vehicle" ) );
        }
    }
    else if ( var_67632a521d76fc15 )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"vehicle" ) );
    }
    
    if ( victim && victim.equipmentref && !victim.superinfo )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"equipment" ) );
        slot = victim.owner equipment_mp::findequipmentslot( victim.equipmentref );
        victim.var_35ebf845dada454b = slot;
        
        if ( victim.var_35ebf845dada454b )
        {
            switch ( victim.var_35ebf845dada454b )
            {
                case #"hash_325cb2e66f67d5b9":
                    victim.var_1dea197935188f1f = #"primary";
                    victim.equipment_type_name = #"lethal";
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"lethal" ) );
                    break;
                case #"hash_511d3c24fcedcdb1":
                    victim.var_1dea197935188f1f = #"secondary";
                    victim.equipment_type_name = #"tactical";
                    enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"tactical" ) );
                    break;
            }
        }
    }
    
    if ( victim.superinfo || victim.streakinfo.superref || victim.superref )
    {
        enemytype = function_a23641f33e985edb( enemytype, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"field_upgrade" ) );
    }
    
    isagent = victim.isagent ?? isagent( victim );
    
    if ( isagent && isdefined( victim.agent_type ) )
    {
        [ enemytype, var_34c4673a21bda4c ] = function_870e7aae54c61948( enemytype, var_34c4673a21bda4c, victim );
    }
    
    if ( victim utility::callsharedfunc( #"gametype", #"hash_484850a23fcf55a8" ) )
    {
        var_34c4673a21bda4c = function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"prop" ) );
    }
    
    enemytype = victim function_3899b7b9609e5689( enemytype );
    return [ enemytype, var_34c4673a21bda4c ];
}

// Namespace challenges
// Params 1
// Checksum 0xbfb73cba, Offset: 0x56ec
// Size: 0x106
function function_bdb753c25b4cd437( objweapon )
{
    gunsmithattachments = [];
    weapongroup = weapon::function_820c0dca2415bd8( objweapon );
    
    if ( weapon::iscacprimaryorsecondary( objweapon, weapongroup ) )
    {
        if ( isdefined( objweapon.attachments ) )
        {
            weaponrootname = weapon::function_170e300815e9c1a2( objweapon );
            
            foreach ( attachment in objweapon.attachments )
            {
                if ( weapon::attachmentisselectablerootname( weaponrootname, attachment ) )
                {
                    gunsmithattachments[ gunsmithattachments.size ] = weapon::getattachmentlootid( weaponrootname, attachment );
                }
            }
        }
    }
    
    for ( attachindex = gunsmithattachments.size; attachindex < 10 ; attachindex++ )
    {
        gunsmithattachments[ attachindex ] = 0;
    }
    
    return gunsmithattachments;
}

// Namespace challenges
// Params 0
// Checksum 0x9e24fcd3, Offset: 0x57fb
// Size: 0x3de
function getweaponclassarray()
{
    if ( !isdefined( level.weaponclassarray ) )
    {
        level.weaponclassarray = {};
        level.weaponclassarray.classes = [];
        level.weaponclassarray.classes[ "none" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"none" );
        level.weaponclassarray.classes[ "grenade" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"grenade" );
        level.weaponclassarray.classes[ "turret" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"turret" );
        level.weaponclassarray.classes[ "throwingknife" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"throwing_knife" );
        level.weaponclassarray.classes[ "non_player" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"non_player" );
        level.weaponclassarray.classes[ "item" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"item" );
        level.weaponclassarray.classes[ "beam" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"beam" );
        level.weaponclassarray.classes[ "ball" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"ball" );
        level.weaponclassarray.classes[ "killstreak" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"killstreak" );
        level.weaponclassarray.classes[ "stowable" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"stowable" );
        level.weaponclassarray.classes[ #"overclocked" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"overclocked" );
        level.weaponclassarray.classes[ "melee" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"melee" );
        level.weaponclassarray.classes[ "weapon_wonder" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"wonderweapon" );
        level.weaponclassarray.classes[ #"exotic" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"exotic" );
        level.weaponclassarray.classes[ #"major_ability" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"major_ability" );
        level.weaponclassarray.classes[ #"minor_ability" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"minor_ability" );
        level.weaponclassarray.classes[ #"classified" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"classified" );
        level.weaponclassarray.classes[ #"ability_upgrade" ] = ae_utility::function_2d1565a236387b2( #"weapon_class_bitfield", #"ability_upgrade" );
    }
    
    return level.weaponclassarray.classes;
}

// Namespace challenges
// Params 2
// Checksum 0x7c13ef31, Offset: 0x5be2
// Size: 0x119
function getweaponlootid( objweapon, weaponname )
{
    if ( !isdefined( objweapon ) )
    {
        return 0;
    }
    
    if ( level.var_431d3dd6b0605770 )
    {
        weaponroot = weapon::function_170e300815e9c1a2( objweapon );
        var_3e7499a2a2de17ea = level.weaponmapdata[ weaponroot ].var_3e7499a2a2de17ea;
        
        if ( var_3e7499a2a2de17ea )
        {
            return var_3e7499a2a2de17ea;
        }
    }
    
    weaponref = undefined;
    
    if ( weapon::issuperweapon( objweapon ) )
    {
        weaponref = supers_mp::getsuperrefforsuperweapon( objweapon );
        weaponref = supers_mp::getsuperrefoverride( weaponref );
    }
    else
    {
        weaponlootid = weapon::function_57559cfce1d2812d( objweapon );
        
        if ( weaponlootid > 0 )
        {
            return weaponlootid;
        }
        
        equipmentstruct = level.equipment.table[ weaponname ];
        
        if ( !isdefined( equipmentstruct ) )
        {
            equipmentstruct = level.equipment.translation[ weaponname ];
        }
        
        if ( !isdefined( equipmentstruct ) )
        {
            return 0;
        }
        
        weaponref = equipmentstruct.ref;
    }
    
    if ( !isdefined( weaponref ) )
    {
        return 0;
    }
    
    weaponlootid = loot::getlootidfromref( weaponref );
    return weaponlootid;
}

// Namespace challenges
// Params 2
// Checksum 0x858c93d4, Offset: 0x5d04
// Size: 0x176
function function_cd4a1dc6ad5b23cb( objweapon, var_49a734ae41b667b3 = 0 )
{
    if ( !objweapon )
    {
        return var_49a734ae41b667b3;
    }
    
    weaponclassarray = getweaponclassarray();
    weaponroot = weapon::function_170e300815e9c1a2( objweapon );
    weaponclassdata = weapon::function_c37ac3c4f987e506( weaponroot, #"classdata" );
    
    if ( isdefined( weaponclassdata ) )
    {
        var_91766176efafdc73 = getscriptbundlefieldvalue( hashcat( %"hash_231e89190f5116c0", weaponclassdata ), #"hash_2244f89c2085a66c" );
        
        if ( isdefined( var_91766176efafdc73 ) )
        {
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, var_91766176efafdc73 );
            
            if ( isplayer( self ) )
            {
                var_821577b47b4f5e7c = !getdvarint( @"hash_f7c13201f7e94b73", 0 );
                
                if ( var_821577b47b4f5e7c )
                {
                    if ( !function_1d263162f04803ec( objweapon.var_e4de3f79b4ac164f ) )
                    {
                        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "non_player" ] );
                    }
                }
                else
                {
                    var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "non_player" ] );
                }
            }
            
            if ( weaponclassdata == "melee" || weaponclassdata == "melee2" || weaponclassdata == "cer_melee2" )
            {
                var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "melee" ] );
            }
        }
    }
    
    if ( weapon::function_52f1736c4c1b06d4( objweapon ) )
    {
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"exotic" ] );
    }
    
    if ( weapon::function_6a1dd038cf91761d( objweapon ) )
    {
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"classified" ] );
    }
    
    return var_49a734ae41b667b3;
}

// Namespace challenges
// Params 1
// Checksum 0x1ec4986f, Offset: 0x5e83
// Size: 0x1e
function getweaponclass( objweapon )
{
    objweapon = utility::function_64003742d8f5c781( objweapon );
    return function_cd4a1dc6ad5b23cb( objweapon );
}

// Namespace challenges
// Params 2
// Checksum 0xd899a5fa, Offset: 0x5eaa
// Size: 0x4d
function weaponfixup( objweapon, attacker )
{
    if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) ) )
    {
        return "";
    }
    
    return equipment_mp::getequipmentreffromweapon( objweapon ) ?? weapon::getdefaultweaponbasename( objweapon.basename );
}

// Namespace challenges
// Params 1
// Checksum 0xc0c00e5a, Offset: 0x5f00
// Size: 0x8f
function function_6337cf762d10163f( lootid )
{
    itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( isdefined( itembundlename ) )
    {
        itembundle = getscriptbundle( itembundlename );
        
        if ( isdefined( itembundle.lootitemtype ) )
        {
            typeenum = getscriptbundlefieldvalue( itembundle.lootitemtype, #"hash_4c8d1da1f04b9fef" );
            
            if ( isdefined( typeenum ) )
            {
                aeenum = getscriptbundlefieldvalue( typeenum, #"id" );
                
                if ( isdefined( aeenum ) )
                {
                    return aeenum;
                }
            }
        }
    }
}

// Namespace challenges
// Params 8
// Checksum 0x1af0e821, Offset: 0x5f97
// Size: 0x78
function onplayerkilled( victim, inflictor, attacker, damage, damageflags, meansofdeath, objweapon, modifiers )
{
    if ( !isplayer( attacker ) )
    {
        if ( isplayer( inflictor ) )
        {
            attacker = inflictor;
        }
        else
        {
            return;
        }
    }
    
    onkill( attacker, victim, undefined, damage, meansofdeath, objweapon, inflictor, modifiers );
}

// Namespace challenges
// Params 8
// Checksum 0x14ac7263, Offset: 0x6017
// Size: 0x7b
function onagentkilled( victim, inflictor, attacker, damage, meansofdeath, objweapon, modifiers, additionaleventparams )
{
    if ( !isplayer( attacker ) )
    {
        if ( isplayer( inflictor ) )
        {
            attacker = inflictor;
        }
        else
        {
            return;
        }
    }
    
    onkill( attacker, victim, undefined, damage, meansofdeath, objweapon, inflictor, modifiers, 0, additionaleventparams );
}

// Namespace challenges
// Params 5
// Checksum 0x9613779e, Offset: 0x609a
// Size: 0x60
function vehiclekilled( victim, attacker, damage, objweapon, additionaleventparams )
{
    meansofdeath = "MOD_UNKNOWN";
    onkill( attacker, victim, victim.owner, damage, meansofdeath, objweapon, undefined, undefined, 1, additionaleventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x92deb2e, Offset: 0x6102
// Size: 0x76
function function_f56cc326196bc3b8( params )
{
    equipmentdestroyed( params.victim, params.inflictor, params.attacker, params.damage, params.damageflags, params.meansofdeath, params.objweapon, params.hitloc, params.modifiers );
}

// Namespace challenges
// Params 9
// Checksum 0x23a423ea, Offset: 0x6180
// Size: 0x1b5
function equipmentdestroyed( victim, inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers )
{
    if ( !isplayer( attacker ) )
    {
        if ( isplayer( inflictor ) )
        {
            attacker = inflictor;
        }
        else
        {
            return;
        }
    }
    
    if ( !isdefined( victim.owner ) )
    {
        return;
    }
    
    if ( inflictor.weapon_name == "sat_smart_seeker_projectile" )
    {
        function_3d7a169dbae062fb( "equip_smart_seeker", attacker, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
    }
    
    if ( !isdefined( meansofdeath ) )
    {
        meansofdeath = "MOD_UNKNOWN";
    }
    
    if ( !victim.triggeredbyplayer && !victim.var_241c199668b5331e )
    {
        victim.var_5084e09f6313d5cb = 1;
        
        if ( victim.var_5084e09f6313d5cb )
        {
            if ( !isdefined( attacker.modifiers ) )
            {
                attacker.modifiers = [];
            }
            
            if ( !isdefined( attacker.modifiers[ "mask5" ] ) )
            {
                attacker.modifiers[ "mask5" ] = 0;
            }
            
            attacker.modifiers[ "mine_destroyed_before_triggered" ] = 1;
            attacker.modifiers[ "mask5" ] = function_a23641f33e985edb( attacker.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"mine_destroyed_before_triggered" ) );
        }
    }
    
    onkill( attacker, victim, victim.owner, damage, meansofdeath, objweapon, inflictor, modifiers );
}

// Namespace challenges
// Params 9
// Checksum 0x343563a3, Offset: 0x633d
// Size: 0xab
function killstreakkilled( victim, killstreakname, owner, attacker, damage, damagetype, objweapon, additionaleventparams, inflictor )
{
    if ( !( isdefined( attacker ) && isdefined( victim ) && isdefined( victim.owner ) ) )
    {
        return;
    }
    
    meansofdeath = "MOD_UNKNOWN";
    onkill( attacker, victim, victim.owner, damage, meansofdeath, objweapon, inflictor, attacker.modifiers, 0, additionaleventparams );
}

// Namespace challenges
// Params 10
// Checksum 0xfa65d7c0, Offset: 0x63f0
// Size: 0x448
function onkill( attacker, victim, owner, damage, meansofdeath, objweapon, inflictor, modifiers, allowfriendly, additionaleventparams )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( victim ) )
    {
        assertmsg( "<dev string:x30f>" );
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        assertmsg( "<dev string:x354>" );
        return;
    }
    
    if ( !isdefined( meansofdeath ) || meansofdeath.size == 0 )
    {
        assertmsg( "<dev string:x39b>" );
        return;
    }
    
    if ( !isdefined( objweapon ) )
    {
        return;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( owner ) )
    {
        owner = victim;
    }
    
    if ( allowfriendly || !player_utility::isfriendly( attacker.team, owner ) )
    {
        objweapon = attacker weapon_utility::function_8097c50c526bd683( objweapon );
        weaponname = weaponfixup( objweapon, attacker );
        attachmentflags = modifiers[ "attachment_flags" ] ?? 0;
        
        if ( victim.streakinfo.streakname && !victim.superinfo && !victim.superref && !victim.streakinfo.superref )
        {
            victim.lootid = loot::getlootidfromref( victim.streakinfo.streakname );
        }
        else if ( victim.superinfo || victim.superref )
        {
            if ( !isdefined( victim.superref ) )
            {
                victim.superref = victim.superinfo.staticdata.ref;
            }
            
            victim.lootid = loot::getlootidfromref( victim.superref );
        }
        else if ( victim.equipmentref && !victim.superinfo )
        {
            victim.lootid = loot::getlootidfromref( victim.equipmentref );
        }
        
        if ( inflictor )
        {
            if ( inflictor.streakinfo && !inflictor.superinfo && !inflictor.superref && !victim.streakinfo.superref )
            {
                inflictor.lootid = loot::getlootidfromref( inflictor.streakinfo.streakname );
            }
            else if ( inflictor.superinfo || inflictor.superref )
            {
                if ( !isdefined( inflictor.superref ) )
                {
                    inflictor.superref = inflictor.superinfo.staticdata.ref;
                }
                
                inflictor.lootid = loot::getlootidfromref( inflictor.superref );
            }
            else if ( inflictor.equipmentref && !inflictor.superinfo )
            {
                inflictor.lootid = loot::getlootidfromref( inflictor.equipmentref );
                slot = attacker equipment_mp::findequipmentslot( inflictor.equipmentref );
                inflictor.var_35ebf845dada454b = slot;
                
                if ( inflictor.var_35ebf845dada454b )
                {
                    switch ( inflictor.var_35ebf845dada454b )
                    {
                        case #"hash_325cb2e66f67d5b9":
                            inflictor.var_1dea197935188f1f = #"primary";
                            inflictor.equipment_type_name = #"lethal";
                            break;
                        case #"hash_511d3c24fcedcdb1":
                            inflictor.var_1dea197935188f1f = #"secondary";
                            inflictor.equipment_type_name = #"tactical";
                            break;
                    }
                }
            }
        }
        
        thread reportkillchallengeevent( attacker, weaponname, victim, modifiers, objweapon, inflictor, damage, meansofdeath, attachmentflags, additionaleventparams );
    }
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0xf349f616, Offset: 0x6840
// Size: 0x79
function private function_53b722103719deb4()
{
    if ( !isdefined( level.gametypebundle.var_90d047d626a9a123 ) )
    {
        level.gametypebundle.var_90d047d626a9a123 = #"nowait";
    }
    
    switch ( level.gametypebundle.var_90d047d626a9a123 )
    {
        case #"nowait":
            return 0;
        case #"slowprocessing":
        default:
            return 1;
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x9814d797, Offset: 0x68c1
// Size: 0x91
function private function_53df6f352d77bfa7( forcewaitframe )
{
    if ( !isdefined( level.gametypebundle.var_90d047d626a9a123 ) )
    {
        level.gametypebundle.var_90d047d626a9a123 = #"nowait";
    }
    
    if ( forcewaitframe )
    {
        waitframe();
    }
    
    switch ( level.gametypebundle.var_90d047d626a9a123 )
    {
        case #"nowait":
            return;
        case #"slowprocessing":
        default:
            script::waittillslowprocessallowed( 1, 1 );
            return;
    }
}

// Namespace challenges
// Params 1
// Checksum 0xce7903ee, Offset: 0x695a
// Size: 0x43
function function_b38c74057441a440( player )
{
    if ( player.closestpoi )
    {
        return player.closestpoi;
    }
    
    if ( player.var_764fa622c95214e4 )
    {
        return player.var_764fa622c95214e4;
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xa783fee4, Offset: 0x69a5
// Size: 0x9c
function private function_bc0e025637b91902( params )
{
    player = params.player;
    locationtype = params.type;
    
    if ( !player challengesenabledforplayer() || !isdefined( params.locationname ) || !isdefined( locationtype ) )
    {
        return;
    }
    
    aeeventname = #"hash_fc291ae4173e7679";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_fb1aef9bad80366d( player, eventparams, aeeventname );
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x4c9d0d22, Offset: 0x6a49
// Size: 0x62
function function_640290a2f1c5bd79( var_a6c0e28b6eaaa0c5 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"player_killstreak_timeout";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = var_a6c0e28b6eaaa0c5;
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0x21d8594d, Offset: 0x6ab3
// Size: 0x11f
function private function_1df91dde90c55ec7( objweapon, attacker, var_49a734ae41b667b3 )
{
    if ( isplayer( attacker ) )
    {
        var_42970857b7dd48ec = objweapon == attacker getcurrentweapon();
        
        if ( attacker function_eac092bc49b2be4d() )
        {
            foreach ( meleeweapon in attacker.meleeweapons )
            {
                if ( meleeweapon == objweapon )
                {
                    var_42970857b7dd48ec = 1;
                    break;
                }
            }
        }
        
        if ( var_42970857b7dd48ec )
        {
            var_911b3b781730341f = attacker item_weapon::function_92b8514cdacab7f9( objweapon );
            weapon_rarity_exotic = 5;
            
            if ( var_911b3b781730341f.rarity >= weapon_rarity_exotic )
            {
                weaponclassarray = getweaponclassarray();
                var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"exotic" ] );
            }
        }
    }
    
    return var_49a734ae41b667b3;
}

// Namespace challenges
// Params 10
// Checksum 0x43cf1149, Offset: 0x6bdb
// Size: 0xf04
function reportkillchallengeevent( attacker, weaponname, victim, modifiers, objweapon, inflictor, damage, meansofdeath, attachmentflags, additionaleventparams )
{
    if ( !isdefined( attacker ) )
    {
        assertmsg( "<dev string:x3df>" );
        return;
    }
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "<dev string:x431>" );
        weaponname = "";
        return;
    }
    
    suspiciouskill = 0;
    suspiciousdown = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
    {
        [ suspiciouskill, suspiciousdown ] = attacker utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", victim, victim.laststandattacker );
    }
    
    if ( suspiciouskill > 0 || suspiciousdown > 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_7cd466d93dceccfb ) )
    {
        level.var_7cd466d93dceccfb = 0;
    }
    
    level.var_7cd466d93dceccfb++;
    modifiers1 = modifiers[ "mask" ] ?? 0;
    modifiers2 = modifiers[ "mask2" ] ?? 0;
    modifiers3 = modifiers[ "mask3" ] ?? 0;
    var_a7714c536c1e300 = modifiers[ "mask4" ] ?? 0;
    var_a7715c536c1e533 = modifiers[ "mask5" ] ?? 0;
    hitloc = modifiers[ "hit_loc" ] ?? 0;
    placement = 0;
    
    if ( attacker.teamplacement > 0 )
    {
        placement = attacker.teamplacement;
    }
    
    vdistance = undefined;
    
    if ( isdefined( victim.origin ) && isdefined( attacker.origin ) )
    {
        vdistance = int( distance( attacker.origin, victim.origin ) );
    }
    
    [ enemytype, var_34c4673a21bda4c ] = function_70dee0eafbb25426( victim );
    attackerloadoutperks = attacker getloadoutperks();
    superlootid = attacker function_325e4020b7ae07dc();
    var_83f71dfe2d25f871 = 0;
    var_83f71dfe2d25f871 = victim function_dda82f6314e2674d( attacker, var_83f71dfe2d25f871 );
    var_83f71dfe2d25f871 = attacker function_dda82f6314e2674d( attacker, var_83f71dfe2d25f871 );
    var_3b82dd60957c0a0f = function_9cfa1e7b6e5d8ce7();
    
    if ( isdefined( level.var_bbd722ce00189d4f ) )
    {
        var_3b82dd60957c0a0f = [[ level.var_bbd722ce00189d4f ]]( var_3b82dd60957c0a0f, victim );
    }
    
    teamsize = attacker squad_utility::getsquadmembers( attacker.team ).size ?? 0;
    
    if ( !isdefined( attacker.var_15de96d9ab0305b6 ) )
    {
        attacker.var_15de96d9ab0305b6 = 0;
    }
    
    if ( objweapon == attacker getcurrentweapon() )
    {
        attacker.var_15de96d9ab0305b6 += 1;
    }
    
    var_15de96d9ab0305b6 = attacker.var_15de96d9ab0305b6;
    headshotkillchain = attacker.headshotkillchain ?? 0;
    timekilled = gettime();
    
    if ( attacker.var_e522579e4d7d3ab6[ victim.guid ] )
    {
        modifiers3 = function_a23641f33e985edb( modifiers3, ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"three_plus_explosion_kill" ) );
    }
    
    var_e2386b489c8fa9b0 = attacker.var_e2386b489c8fa9b0 ?? 0;
    inflictorparent = inflictor.glgrenadeparent;
    isoverclocked = modifiers[ #"overclocked_killstreak_kill" ] ?? 0;
    function_53df6f352d77bfa7();
    profilestart();
    level.var_7cd466d93dceccfb--;
    
    if ( level.var_7cd466d93dceccfb <= 0 )
    {
        level.var_7cd466d93dceccfb = undefined;
    }
    
    if ( !isdefined( attacker ) )
    {
        profilestop();
        return;
    }
    
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( attackerloadoutperks );
    gunsmithattachments = function_bdb753c25b4cd437( objweapon );
    operatorlootid = attacker function_6a3bd1af73a5a390() ?? 0;
    var_d491b50ec0d8dc0b = attacker function_a7e780cc2464a43b() ?? 0;
    var_49a734ae41b667b3 = modifiers[ #"weapon_class_bitfield" ] ?? 0;
    var_49a734ae41b667b3 = inflictor.var_f804f723ca248cee ? var_49a734ae41b667b3 : function_cd4a1dc6ad5b23cb( objweapon, var_49a734ae41b667b3 );
    
    if ( victim.var_49b8b885e3f811e )
    {
        var_49a734ae41b667b3 = function_1df91dde90c55ec7( objweapon, attacker, var_49a734ae41b667b3 );
    }
    
    weaponclassarray = getweaponclassarray();
    
    if ( inflictorparent )
    {
        weaponlootid = getweaponlootid( inflictorparent, inflictorparent.basename );
        weaponclassbit = weaponclassarray[ weaponclass( inflictorparent ) ];
    }
    else
    {
        weaponlootid = getweaponlootid( objweapon, weaponname );
        weaponclassbit = weaponclassarray[ weaponclass( objweapon ) ];
    }
    
    var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassbit );
    br_map_name = function_9eb50f0c865a6b1b();
    iskillstreak = weapon::iskillstreakweaponname( objweapon.basename );
    
    if ( iskillstreak )
    {
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "killstreak" ] );
        
        if ( isdefined( level.killstreakweaponmap ) )
        {
            killstreakweaponname = level.killstreakweaponmap[ objweapon.basename ];
            
            if ( isdefined( killstreakweaponname ) )
            {
                weaponlootid = loot::getlootidfromref( killstreakweaponname );
            }
        }
    }
    
    if ( isoverclocked )
    {
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"overclocked" ] );
    }
    
    if ( weapon::function_597e1c0b6df2fada( objweapon.basename ) )
    {
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "stowable" ] );
    }
    
    superref = supers_mp::getsuperrefforsuperweapon( objweapon.basename );
    
    if ( !superref && inflictor.superref )
    {
        superref = inflictor.superref;
    }
    
    if ( superref )
    {
        if ( supers_mp::function_b2ad0e92714d61d7( superref ) )
        {
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"major_ability" ] );
        }
        else if ( supers_mp::function_5cf25d35be09368b( superref ) )
        {
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"minor_ability" ] );
        }
    }
    
    attachmentflags = function_c003bf895c0a94d3( objweapon, attachmentflags );
    weaponcamo = 0;
    weaponcamoname = objweapon.camo;
    
    if ( isdefined( weaponcamoname ) )
    {
        var_aaffa585d4377521 = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", weaponcamoname ), #"hash_5d43166f11ad4c88" );
        
        if ( isdefined( var_aaffa585d4377521 ) )
        {
            entryvalue = getscriptbundlefieldvalue( hashcat( %"hash_1f262b85a18b69c7", var_aaffa585d4377521 ), #"id" );
            
            if ( isdefined( entryvalue ) )
            {
                weaponcamo = entryvalue;
            }
        }
    }
    
    attachmentcount = 0;
    var_6b295309a15e23ed = inflictorparent.var_f6f9f66e9b50d71c ?? objweapon.var_f6f9f66e9b50d71c;
    var_36419ea99713c851 = inflictorparent ?? objweapon;
    
    if ( var_36419ea99713c851 && var_6b295309a15e23ed )
    {
        var_d2e2d72e15e4205f = [ #"category", #"baseref" ];
        
        if ( var_36419ea99713c851.isalternate )
        {
            weaponname = var_36419ea99713c851.basename;
        }
        else
        {
            weaponname = weaponfixup( var_36419ea99713c851, attacker );
        }
        
        equipmentref = utility::callsharedfunc( #"equipment", #"getequipmentreffromweapon", var_36419ea99713c851 );
        
        if ( !equipmentref && weapon_utility::isbulletweapon( weaponname ) )
        {
            var_287b4b3237470d77 = getweapondefaultattachments( weapon::getdefaultweaponbasename( weaponname ) );
            
            foreach ( attachment in var_6b295309a15e23ed )
            {
                bundle = getscriptbundlefieldvalues( attachment, var_d2e2d72e15e4205f );
                
                if ( !isdefined( bundle ) )
                {
                    continue;
                }
                
                var_460feca106cb4463 = bundle.baseref ?? "";
                var_c1a114f6925e9d64 = isdefined( bundle.category ) ? toupper( getscriptbundlefieldvalue( bundle.category, #"ref" ) ) : undefined;
                
                if ( !isdefined( var_c1a114f6925e9d64 ) )
                {
                    continue;
                }
                
                if ( var_c1a114f6925e9d64 != "RECEIVER" && var_c1a114f6925e9d64 != "NONE" && !arraycontains( var_287b4b3237470d77, var_460feca106cb4463 ) )
                {
                    attachmentcount++;
                }
            }
        }
    }
    
    var_1646641afef13fbe = 0;
    playlistid = getplaylistid();
    aeeventname = #"kill";
    
    if ( isdefined( level.gametypebundle.var_8583f80ae20a873c ) )
    {
        aeeventname = level.gametypebundle.var_8583f80ae20a873c;
    }
    
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparamsstruct = { #eventparams:eventparams };
    
    if ( level.gamemodebundle.var_52480e3d3510a931 )
    {
        location = getlocation( attacker );
        location2 = getlocation_2( attacker );
        starlevel = function_d3fb2ff1e81d7bc0( attacker );
        function_f555a98b1b53d20d( attacker, eventparamsstruct, aeeventname );
        function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"location_bitfield", location );
        function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"location_bitfield2", location2 );
        function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_9156b8425a7b6060", starlevel );
    }
    
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kill_operator_id", operatorlootid );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kill_alternate_operator_id", var_d491b50ec0d8dc0b );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_loot_id", weaponlootid );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"placement", placement );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment1", gunsmithattachments[ 0 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment2", gunsmithattachments[ 1 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment3", gunsmithattachments[ 2 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment4", gunsmithattachments[ 3 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment5", gunsmithattachments[ 4 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment6", gunsmithattachments[ 5 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment7", gunsmithattachments[ 6 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment8", gunsmithattachments[ 7 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment9", gunsmithattachments[ 8 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment10", gunsmithattachments[ 9 ] );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_f3c18caaeb34448c", var_1646641afef13fbe );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_class_bitfield", var_49a734ae41b667b3 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kill_bitfield1", modifiers1 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kill_bitfield2", modifiers2 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kill_bitfield3", modifiers3 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kill_bitfield4", var_a7714c536c1e300 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_7f94e41c1787f8ae", var_a7715c536c1e533 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"enemy_type_bitfield", enemytype );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_22d8c6e760626656", var_34c4673a21bda4c );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"br_map_name", br_map_name );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_bd518e95df4103fe", var_86c674a64c35ed94.var_ec7be02dd7cc6d7d );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_bd518d95df41024b", var_86c674a64c35ed94.var_7111292ef37e4f97 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"loot_id", superlootid );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"distance", vdistance );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_attachment_flags", attachmentflags );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"attachment_count", attachmentcount );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"weapon_camo", weaponcamo );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hit_loc", hitloc );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"team_size", teamsize );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"enemy_squads_remaining", var_3b82dd60957c0a0f );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"supers_bitfield", var_83f71dfe2d25f871 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"kills_since_trigger_held", var_15de96d9ab0305b6 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"headshot_kill_chain", headshotkillchain );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"life_sequence", var_e2386b489c8fa9b0 % 7 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"playlist_id", playlistid );
    
    if ( isdefined( victim.lootid ) )
    {
        function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"victim_loot_id", victim.lootid );
    }
    
    if ( isdefined( inflictor.lootid ) )
    {
        function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"inflictor_loot_id", inflictor.lootid );
    }
    
    if ( utility::issharedfuncdefined( #"br_circle", #"hash_3d3cfb00b346b128" ) )
    {
        circleindex = utility::callsharedfunc( #"br_circle", #"hash_3d3cfb00b346b128" );
        var_58c6f769655e8f23 = circleindex + 1;
        function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"circle_number", var_58c6f769655e8f23 );
    }
    
    if ( isdefined( level.sharedfuncs[ #"hash_3ac9ab20c49792f2" ][ #"getskilldivisiontier" ] ) )
    {
        skilldivision = victim [[ level.sharedfuncs[ #"hash_3ac9ab20c49792f2" ][ #"getskilldivisiontier" ] ]]();
        
        if ( isdefined( skilldivision ) )
        {
            function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"leagueplay_victim_skill_division", skilldivision );
        }
    }
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            function_df424ab6c42d089c( eventparamsstruct, aeeventname, paramkey, paramval );
        }
    }
    
    reportchallengeuserserializeddicteventinternal( attacker, aeeventname, eventparamsstruct.eventparams, undefined, gettime() - timekilled );
    profilestop();
}

// Namespace challenges
// Params 2
// Checksum 0xf19d88e8, Offset: 0x7ae7
// Size: 0x77
function function_f4c306eea6673ab0( aeeventname, eventparams )
{
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = getplaylistid();
}

// Namespace challenges
// Params 4
// Checksum 0x536a92d5, Offset: 0x7b66
// Size: 0x1d2
function function_28e766b836fbfc46( attacker, iskillstreak, overridekillcount, additionaleventparams )
{
    if ( !isdefined( attacker ) )
    {
        assertmsg( "<dev string:x3df>" );
        return;
    }
    
    killamount = attacker.currentmultikill;
    
    if ( isdefined( overridekillcount ) )
    {
        killamount = overridekillcount;
    }
    
    if ( !( isdefined( killamount ) && isdefined( iskillstreak ) ) )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"multikill";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    objweapon = attacker getcurrentweapon();
    weaponlootid = 0;
    weaponlootid = function_201616a995d283bc( objweapon );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_amount" ) ] = killamount;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = weaponlootid;
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval;
        }
    }
    
    attacker function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x29a305b0, Offset: 0x7d40
// Size: 0x162
function function_57bca958eb1b226a( attacker )
{
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    bitfield1 = 0;
    bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"hash_23c7a08bc1434b94" ) );
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparamsstruct = { #eventparams:[] };
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"gamemode", gamemode );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"playlist_id", getplaylistid() );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"gametype", gametype );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"map_name", level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53() );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"version", 1 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_184f67783fae7b70", bitfield1 );
    attacker.var_b1a7bcec9cf49488 = undefined;
    attacker.var_4e88f6e44ad3dc79 = 1;
    attacker function_2e45314624fdfdb8( aeeventid, eventparamsstruct.eventparams, gettime() );
}

// Namespace challenges
// Params 0
// Checksum 0x21486706, Offset: 0x7eaa
// Size: 0x139
function function_4330c4e0266b0055()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    bitfield1 = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"hash_10f6656cdaa8acc4" ) );
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparamsstruct = { #eventparams:[] };
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"gamemode", gamemode );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"playlist_id", getplaylistid() );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"gametype", gametype );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"map_name", level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53() );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"version", 1 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_184f67783fae7b70", bitfield1 );
    self function_2e45314624fdfdb8( aeeventid, eventparamsstruct.eventparams, gettime() );
}

// Namespace challenges
// Params 1
// Checksum 0x38cbaaff, Offset: 0x7feb
// Size: 0x149
function function_b33c8c97a78773a9( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    bitfield1 = 0;
    bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"hash_4eb60bd1e0cd6e48" ) );
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparamsstruct = { #eventparams:[] };
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"gamemode", gamemode );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"playlist_id", getplaylistid() );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"gametype", gametype );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"map_name", level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53() );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"version", 1 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_184f67783fae7b70", bitfield1 );
    player function_2e45314624fdfdb8( aeeventid, eventparamsstruct.eventparams, gettime() );
}

// Namespace challenges
// Params 1
// Checksum 0x67604586, Offset: 0x813c
// Size: 0xcb
function function_20d2d944fbb9e725( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    bitfield1 = 0;
    bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"objective_completed" ) );
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_184f67783fae7b70" ) ] = bitfield1;
    player function_2e45314624fdfdb8( aeeventid, eventparams, gettime() );
}

// Namespace challenges
// Params 1
// Checksum 0x5358678e, Offset: 0x820f
// Size: 0xcb
function function_bfa6ec40ac588a76( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    bitfield1 = 0;
    bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"consecutive_objectives_completed" ) );
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_184f67783fae7b70" ) ] = bitfield1;
    player function_2e45314624fdfdb8( aeeventid, eventparams, gettime() );
}

// Namespace challenges
// Params 1
// Checksum 0xab549e65, Offset: 0x82e2
// Size: 0xcb
function function_bfa252952e732c7d( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    bitfield1 = 0;
    bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"sushi_cannon_score" ) );
    aeeventname = #"one_shot_score_events";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_184f67783fae7b70" ) ] = bitfield1;
    player function_2e45314624fdfdb8( aeeventid, eventparams, gettime() );
}

// Namespace challenges
// Params 5
// Checksum 0xda9a0d8d, Offset: 0x83b5
// Size: 0x6b
function function_25f6d6406184a7a5( itemtyperef, itemref, lootid, quantity, cashvalue )
{
    buy_action = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"sell" ) );
    function_efec954cceb5599d( self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action );
}

// Namespace challenges
// Params 5
// Checksum 0xcff2fb32, Offset: 0x8428
// Size: 0xa2
function function_c3ebaa8cc6842f83( itemtyperef, itemref, lootid, quantity, cashvalue )
{
    buy_action = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"trade" ) );
    function_efec954cceb5599d( self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action );
    loot_method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"loot" ) );
    reportlootitemevent( self, lootid, itemtyperef, loot_method, quantity );
}

// Namespace challenges
// Params 5
// Checksum 0x45280d75, Offset: 0x84d2
// Size: 0x6b
function function_c102157423d9e481( itemtyperef, itemref, lootid, quantity, cashvalue )
{
    buy_action = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy_action_upgrade" ) );
    function_efec954cceb5599d( self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action );
}

// Namespace challenges
// Params 5
// Checksum 0xc3d663a6, Offset: 0x8545
// Size: 0x6b
function function_771f5a9bd9cb2f06( itemtyperef, itemref, lootid, quantity, cashvalue )
{
    buy_action = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy_action_remove_attachment" ) );
    function_efec954cceb5599d( self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action );
}

// Namespace challenges
// Params 8
// Checksum 0x5a29f298, Offset: 0x85b8
// Size: 0x29d
function function_efec954cceb5599d( player, lootid, lootref, loottype, quantity, cashvalue, buyaction, additionaleventparams )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    var_a6b1d7d52b20aa00 = 0;
    typeid = 0;
    
    if ( !level.gametypebundle.var_a9664504384d69b6 )
    {
        if ( isdefined( lootref ) )
        {
            var_a6b1d7d52b20aa00 = ae_utility::function_357622cc2d8da787( lootref );
        }
        
        if ( isdefined( lootid ) )
        {
            typeid = function_6337cf762d10163f( lootid );
        }
        else if ( isdefined( loottype ) )
        {
            typeid = ae_utility::function_357622cc2d8da787( loottype );
        }
    }
    
    quantity = function_ed6f10a45e5c6af7( lootid, quantity );
    cashvalue = function_85b4707bca7512db( cashvalue );
    weaponref = loot::function_f54ecb89dfab8e8c( lootid );
    assetname = weapon::getweaponassetname( weaponref );
    var_49a734ae41b667b3 = 0;
    
    if ( isdefined( assetname ) )
    {
        weapon = makeweapon( assetname );
        var_49a734ae41b667b3 = 0;
        
        if ( weapon.var_1616e6fbba9a722d != %"none" )
        {
            var_49a734ae41b667b3 = getweaponclass( weapon ) ?? 0;
        }
    }
    
    aeeventname = #"buy_item";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"string_ref" ) ] = var_a6b1d7d52b20aa00;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = quantity;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_item_type" ) ] = typeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"cash_value" ) ] = cashvalue;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"buy_action" ) ] = buyaction;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval;
        }
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventname, eventparams );
    #/
    
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 6
// Checksum 0x4c21bac3, Offset: 0x885d
// Size: 0x7e
function function_16573ce5cfa86293( player, var_252f371875679587, quantity, var_b263f31ce0e76beb = 0, lootid, additionaleventparams )
{
    entryvalue = getscriptbundlefieldvalue( hashcat( %"hash_1f262b85a18b69c7", var_252f371875679587 ), #"id" );
    
    if ( isdefined( entryvalue ) )
    {
        function_37e945722d6497f3( player, entryvalue, quantity, var_b263f31ce0e76beb, lootid, additionaleventparams );
    }
}

// Namespace challenges
// Params 6
// Checksum 0xc4200ee9, Offset: 0x88e3
// Size: 0x202
function function_37e945722d6497f3( player, type, quantity, var_b263f31ce0e76beb, lootid, additionaleventparams )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( var_b263f31ce0e76beb ) && level.gamemodebundle.var_ae8717ca72f422be )
    {
        var_b263f31ce0e76beb = level.gamemodebundle.var_ae8717ca72f422be;
    }
    
    if ( var_b263f31ce0e76beb && !function_c658162aaf8367f1() )
    {
        function_585c5c0a42ecf37f( player.team, type, quantity );
        return;
    }
    
    typeid = 0;
    
    if ( !level.gametypebundle.var_a9664504384d69b6 )
    {
        if ( isdefined( type ) )
        {
            typeid = ae_utility::function_357622cc2d8da787( type );
        }
    }
    
    eventparams = [];
    function_f4c306eea6673ab0( #"collect_item", eventparams );
    function_93ae9f94893d99e0( player, eventparams, #"collect_item" );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( #"collect_item", #"string_ref" ) ] = typeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( #"collect_item", #"value" ) ] = quantity;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( #"collect_item", #"loot_id" ) ] = lootid;
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( #"collect_item", paramkey ) ] = paramval;
        }
    }
    
    reportchallengeuserserializeddicteventinternal( player, #"collect_item", eventparams, var_b263f31ce0e76beb );
    println( "<dev string:x47a>" + type );
}

// Namespace challenges
// Params 3
// Checksum 0x933906fe, Offset: 0x8aed
// Size: 0xbf
function function_585c5c0a42ecf37f( team, type, quantity )
{
    if ( !isdefined( type ) || !isdefined( team ) )
    {
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( player )
        {
            function_37e945722d6497f3( player, type, quantity, 0 );
        }
    }
}

// Namespace challenges
// Params 2
// Checksum 0x41162210, Offset: 0x8bb4
// Size: 0x142
function reportvehicleevent( vehicle, type )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !( isdefined( vehicle ) && isdefined( type ) ) )
    {
        return;
    }
    
    vehiclename = findenemytype( vehicle )[ 0 ];
    vehiclename2 = function_70dee0eafbb25426( vehicle )[ 1 ];
    typeid = ae_utility::function_357622cc2d8da787( type );
    aeeventname = #"vehicle";
    typeid = function_4dc87d9356c76d42( typeid, aeeventname );
    location = function_4dc87d9356c76d42( location, aeeventname );
    location2 = function_4dc87d9356c76d42( location2, aeeventname );
    vehiclename = function_4dc87d9356c76d42( vehiclename, aeeventname );
    vehiclename2 = function_4dc87d9356c76d42( vehiclename2, aeeventname );
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( self, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"string_ref" ) ] = typeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"enemy_type_bitfield" ) ] = vehiclename;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_22d8c6e760626656" ) ] = vehiclename2;
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
    println( "<dev string:x4b7>" + type );
}

// Namespace challenges
// Params 3
// Checksum 0x127dd453, Offset: 0x8cfe
// Size: 0xc4
function function_38bbdf788e1b01d4( player, type, quantity )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    typeid = ae_utility::function_357622cc2d8da787( type );
    aeeventname = #"unlock";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"string_ref" ) ] = typeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = quantity;
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
    println( "<dev string:x4eb>" + type );
}

// Namespace challenges
// Params 9
// Checksum 0xbeb5d531, Offset: 0x8dca
// Size: 0x238
function function_3d7a169dbae062fb( equipment, player, dist, eventtypebit, value = 1, var_62173a0431eae70d = 0, equipmentbitfield = undefined, victim = undefined, additionalparams = undefined )
{
    if ( !player challengesenabledforplayer() || !isplayer( player ) )
    {
        return;
    }
    
    if ( value < 0 )
    {
        value = 1;
    }
    
    attackerloadoutperks = player getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( attackerloadoutperks );
    equipmentid = loot::getlootidfromref( equipment );
    bitfield = function_a23641f33e985edb( 0, eventtypebit );
    [ enemytype, var_34c4673a21bda4c ] = function_70dee0eafbb25426( victim );
    aeeventname = #"equipment";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = equipmentid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = bitfield;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"distance" ) ] = dist;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"LONG_RANGE" ) ] = var_62173a0431eae70d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"equipment_bitfield1" ) ] = equipmentbitfield;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"enemy_type_bitfield" ) ] = enemytype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_22d8c6e760626656" ) ] = var_34c4673a21bda4c;
    
    if ( isarray( additionalparams ) )
    {
        eventparams = function_c6c06162c8e6ae75( eventparams, additionalparams );
    }
    
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x23d51fb9, Offset: 0x900a
// Size: 0x2a6
function function_4e55542d7cb05e55( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( level.gametypebundle.var_826353f1359757f8 )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    placement = 0;
    
    if ( player.teamplacement > 0 )
    {
        placement = player.teamplacement;
    }
    
    match_placement_bitfield = 0;
    
    if ( player.gulaguses > 0 )
    {
        match_placement_bitfield = function_a23641f33e985edb( match_placement_bitfield, ae_utility::function_2d1565a236387b2( #"hash_b4508a899f18c65", #"entered_gulag" ) );
    }
    
    totaleliminations = 0;
    
    if ( isdefined( player.pers[ "kills" ] ) && isdefined( player.pers[ "assists" ] ) )
    {
        totaleliminations = player.pers[ "kills" ] + player.pers[ "assists" ];
    }
    
    if ( placement == 1 && isdefined( player.pers[ "deaths" ] ) && player.pers[ "deaths" ] == 0 )
    {
        match_placement_bitfield = function_a23641f33e985edb( match_placement_bitfield, ae_utility::function_2d1565a236387b2( #"hash_b4508a899f18c65", #"hash_7618e548442c0d65" ) );
    }
    
    if ( player.pers[ "meleeKills" ] > 2 )
    {
        match_placement_bitfield = function_a23641f33e985edb( match_placement_bitfield, ae_utility::function_2d1565a236387b2( #"hash_b4508a899f18c65", #"hash_4b1f4d8538d6d27a" ) );
    }
    
    var_f3c8f1e592e86c42 = player.endmatchstats[ "loadoutsOpened" ] ?? 0;
    
    if ( var_f3c8f1e592e86c42 == 0 )
    {
        match_placement_bitfield = function_a23641f33e985edb( match_placement_bitfield, ae_utility::function_2d1565a236387b2( #"hash_b4508a899f18c65", #"hash_df4fe6e83eb5ccf3" ) );
    }
    
    aeeventname = #"match_placement";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"placement" ) ] = placement;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"total_eliminations_earned" ) ] = totaleliminations;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_b4508a899f18c65" ) ] = match_placement_bitfield;
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 4
// Checksum 0x680ed2bd, Offset: 0x92b8
// Size: 0xefb
function function_24412890e8abf7dd( player, result, winner, additionaleventparams )
{
    var_59e2bffdb02240df = 0;
    
    if ( isdefined( level.sharedfuncs[ #"potg" ][ #"hash_8d0103993c2d120d" ] ) && !player [[ level.sharedfuncs[ #"potg" ][ #"hash_8d0103993c2d120d" ] ]]() && level flags::gameflagexists( "potg_finalized" ) )
    {
        var_59e2bffdb02240df = 1;
        level flags::function_2f3408423ccc9b2e( "potg_finalized" );
    }
    
    var_5d4ca62dc89f4f51 = 0;
    
    if ( !level.var_3d48adb3865dfbe9 && isdefined( level.sharedfuncs[ #"winners_circle" ][ #"hash_dc7b792b18c4e3e3" ] ) && !player [[ level.sharedfuncs[ #"winners_circle" ][ #"hash_dc7b792b18c4e3e3" ] ]]() && level flags::gameflagexists( "winners_circle_finalized" ) )
    {
        var_5d4ca62dc89f4f51 = 1;
        waitforwinnerscircle();
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x51d>" );
        return;
    }
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    for ( trycount = 100; level.var_7cd466d93dceccfb && trycount > 0 ; trycount-- )
    {
        waitframe();
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x56a>" );
        return;
    }
    
    operatorlootid = player function_6a3bd1af73a5a390();
    
    if ( !isdefined( operatorlootid ) )
    {
        operatorlootid = 0;
    }
    
    gamemode = getchallengegamemode();
    teamsize = getmatchrulesdata( "commonOption", "teamSize" );
    placement = 0;
    
    if ( player.teamplacement > 0 )
    {
        placement = player.teamplacement;
    }
    
    playlistid = getplaylistid();
    lobbyid = getlobbyid();
    distance_traveled = player.endmatchstats[ "distancePlayerTravel" ] ?? 0;
    distance_traveled += distance2d( player.origin, player.endmatchstats[ "lastLandingSpot" ] ?? player.origin );
    br_map_name = function_9eb50f0c865a6b1b();
    playerscore = 0;
    
    if ( isdefined( level.sharedfuncs[ #"score" ][ #"hash_a9494f7ac7475784" ] ) )
    {
        playerscore = [[ level.sharedfuncs[ #"score" ][ #"hash_a9494f7ac7475784" ] ]]( player );
    }
    
    if ( isdefined( level.gametypebundle.var_c0863ded3f854ce0 ) && !getdvarint( @"hash_a04518df9d9f211e" ) )
    {
        playerscore *= level.gametypebundle.var_c0863ded3f854ce0;
    }
    
    endgame_bitfield = 0;
    teamscore = playerscore;
    
    if ( level.teambased )
    {
        teamscore = gamescore::getteamscore( player.team );
        otherteamscore = gamescore::getteamscore( game_utility_mp::getotherteam( player.team )[ 0 ] );
        
        if ( teamscore >= otherteamscore * 2 )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"hash_a525674ecb128d9" ) );
        }
    }
    
    if ( !level.var_620407c02e27532a && isdefined( level.sharedfuncs[ #"score" ][ #"hash_be7000c0c6f5884b" ] ) )
    {
        [[ level.sharedfuncs[ #"score" ][ #"hash_be7000c0c6f5884b" ] ]]();
    }
    
    var_31f3d0cf97c0a815 = level.var_620407c02e27532a == player;
    
    if ( var_31f3d0cf97c0a815 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"most_objective_score" ) );
    }
    
    if ( var_31f3d0cf97c0a815 || level.var_f3b7fd0d1b9f700a == player || level.var_96f53e2b6f96db91 == player )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"hash_334ec5564286c783" ) );
    }
    
    if ( isdefined( player.pers[ "kills" ] ) )
    {
        if ( player.pers[ "kills" ] >= 15 )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"15kills" ) );
        }
    }
    
    var_f78140643fdcdab0 = player.pers[ "EDR" ] ?? 0;
    var_f438c8c2b8564b31 = player.pers[ "elims" ] == level.mostelims;
    var_9b68068a468aff04 = var_f78140643fdcdab0 == level.var_397f51ba9948c3c6;
    
    if ( var_f438c8c2b8564b31 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"mostelims" ) );
    }
    
    if ( var_9b68068a468aff04 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"highest_elim_ratio_game" ) );
    }
    
    nemesisdata = player.pers[ #"nemesisdata" ];
    var_fed1fa81f13460b6 = nemesisdata[ #"currentnemesis" ];
    
    if ( isdefined( var_fed1fa81f13460b6 ) && nemesisdata[ var_fed1fa81f13460b6 ].var_4ce2be89357100be > nemesisdata[ var_fed1fa81f13460b6 ].killed_by_count )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"hash_b253b028116545a9" ) );
    }
    
    if ( !level.gametypebundle.var_3142d593ab9a7f77 )
    {
        winningplayer = utility::callsharedfunc( #"score", #"hash_648cdd5826fc187f" );
        
        if ( winningplayer === player )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"highest_scorer" ) );
        }
        
        var_495db9d10bdbdfbb = player utility::callsharedfunc( #"score", #"hash_f25d0d135ca8808c", 3 );
        
        if ( level.placement[ "all" ].size >= 8 && var_495db9d10bdbdfbb )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"hash_c0027b2c1f4ef46d" ) );
        }
    }
    
    if ( player.gulaguses > 0 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"entered_gulag" ) );
    }
    
    if ( isdefined( level.secondaryvictory ) && player.extracted )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"is_secondary_victory" ) );
    }
    
    if ( isdefined( level.var_5dc1d3cb32947991 ) && level.var_5dc1d3cb32947991[ player.guid ] )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"hash_600ba733abaa2896" ) );
    }
    
    if ( player.var_4b1f798ecbed7345 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"is_map_to_map" ) );
    }
    
    if ( var_59e2bffdb02240df && isdefined( level.sharedfuncs[ #"potg" ][ #"hash_4a396cb5b36ca065" ] ) && !self [[ level.sharedfuncs[ #"potg" ][ #"hash_4a396cb5b36ca065" ] ]]() && isdefined( level.sharedfuncs[ #"potg" ][ #"hash_6a8709bef8e57ab5" ] ) )
    {
        potgscene = [[ level.sharedfuncs[ #"potg" ][ #"hash_6a8709bef8e57ab5" ] ]]();
        
        if ( potgscene.primaryentity === player )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"potg" ) );
        }
    }
    
    if ( var_5d4ca62dc89f4f51 && level.mvparray )
    {
        if ( player.var_ac59c6f71b1d8c9b )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"in_winners_circle" ) );
        }
    }
    
    var_666719f7ceac9425 = getdvarint( @"hash_d5a1ed391dd67630", 0 );
    
    if ( var_666719f7ceac9425 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"cq_active" ) );
    }
    
    if ( isdefined( level.elite_ironclad ) )
    {
        if ( level.elite_ironclad.endingdisarmed && arraycontains( level.elite_ironclad.var_1f3bb3cf02895b4e, player.team ) )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"cq_bomb_defused" ) );
        }
        
        if ( level.elite_ironclad.endingdetonated )
        {
            endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"cq_bomb_detonated" ) );
        }
    }
    
    if ( level.gametypebundle.isltm )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"is_ltm" ) );
    }
    
    var_b4e4cccc4c72c32f = 0;
    
    if ( isdefined( player.plunderbanked ) && ( isint( player.plunderbanked ) || isstring( player.plunderbanked ) ) )
    {
        var_b4e4cccc4c72c32f = player.plunderbanked;
    }
    
    partysize = utility::function_e153375527829ec3( player getprivatepartysize(), 1 );
    gametype = function_9edd00e9e48c0821();
    squadmatesunoids = function_c1eca4afdd49da1a( player );
    var_93d21e3fbcd50ca8 = player.pers[ #"objective_use_time" ].totaltime ?? 0;
    aeeventname = #"end_match";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"match_result" ) ] = result;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_8dd9828579063e7" ) ] = endgame_bitfield;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"placement" ) ] = placement;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = playlistid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"team_size" ) ] = teamsize;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"lobby_id" ) ] = lobbyid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate0" ) ] = squadmatesunoids[ 0 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate1" ) ] = squadmatesunoids[ 1 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate2" ) ] = squadmatesunoids[ 2 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate3" ) ] = squadmatesunoids[ 3 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate4" ) ] = squadmatesunoids[ 4 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"plunder_total_deposited" ) ] = var_b4e4cccc4c72c32f;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"br_map_name" ) ] = br_map_name;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"score" ) ] = playerscore;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"team_score" ) ] = teamscore;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"elim_death_ratio" ) ] = var_f78140643fdcdab0;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"party_size" ) ] = partysize;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"objective_time" ) ] = var_93d21e3fbcd50ca8;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"pause_time_cumulative" ) ] = function_e3cd85eead6e1fc7();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"distance" ) ] = int( distance_traveled );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"plates_inserted" ) ] = player.endmatchstats[ "platesInserted" ] ?? 0;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_amount" ) ] = player.pers[ "kills" ] ?? 0;
    
    if ( utility::issharedfuncdefined( #"hash_7305513195fadf7e", #"hash_134d493924be6c4" ) )
    {
        additionaleventparams = utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_134d493924be6c4", player, additionaleventparams );
    }
    
    if ( utility::issharedfuncdefined( #"frun_challenges", #"hash_25c85cd46694dd52" ) )
    {
        additionaleventparams = utility::callsharedfunc( #"frun_challenges", #"hash_25c85cd46694dd52", player, additionaleventparams );
    }
    
    if ( getxhash( game_utility::getgametype() ) == #"dmz" )
    {
        if ( player.challengedata.var_d7fd9e2b8412bb3f )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"dmz_killed_by" ) ] = player.challengedata.var_d7fd9e2b8412bb3f ?? 0;
        }
        
        if ( player.challengedata.bountyScore )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"dmz_bounty_collected" ) ] = player.challengedata.bountyScore ?? 0;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"dmz_bounty_amount" ) ] = player bounty_wanted::function_90c77fff71f390d7( player.challengedata.bountyScore ) ?? 0;
        }
    }
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval;
        }
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    print( "<dev string:x5b4>" );
    player function_2e45314624fdfdb8( aeeventid, eventparams );
    print( "<dev string:x5cc>" );
    player.var_4f7fa6a47a741c26 = 1;
}

// Namespace challenges
// Params 0
// Checksum 0xafb2b1d2, Offset: 0xa1bb
// Size: 0x3d
function waitforwinnerscircle()
{
    level endon( #"winners_circle_skipped" );
    
    if ( !isdefined( level.winners_circle ) )
    {
        return;
    }
    
    thread function_47cba188b3872f46();
    level flags::function_2f3408423ccc9b2e( "winners_circle_finalized" );
    level notify( #"hash_567f9071886b1753" );
}

// Namespace challenges
// Params 0
// Checksum 0x1ff23c7d, Offset: 0xa200
// Size: 0x3f
function function_47cba188b3872f46()
{
    level endon( #"winners_circle_skipped" );
    level endon( #"hash_567f9071886b1753" );
    level waittill( #"exitlevel_called" );
    script::demoforcesre( "Stuck waiting for winners circle at end of match" );
    level notify( #"winners_circle_skipped" );
}

// Namespace challenges
// Params 2
// Checksum 0xa97a415e, Offset: 0xa247
// Size: 0x9b
function function_39b530dd29c848fb( player, activitytype )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"start_activity";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"activity_type" ) ] = activitytype;
    
    /#
        function_ee4471f0d17f1d51( aeeventname, eventparams );
    #/
    
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 3
// Checksum 0x2bfb932c, Offset: 0xa2ea
// Size: 0x8c
function function_93ae9f94893d99e0( player, eventparams, aeeventname )
{
    if ( level.gamemodebundle.var_52480e3d3510a931 && isdefined( player ) && isdefined( eventparams ) && isdefined( aeeventname ) )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"location_bitfield" ) ] = getlocation( player );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"location_bitfield2" ) ] = getlocation_2( player );
        function_fb1aef9bad80366d( player, eventparams, aeeventname );
    }
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x1a4a980a, Offset: 0xa37e
// Size: 0x3a
function private function_636485e45bb95523()
{
    if ( !function_5a7a05e383310670() )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_636485e45bb95523 ) )
    {
        level.var_636485e45bb95523 = !function_4042d2fbe6237835( #"hash_2ac901ac9c6855ec" );
    }
    
    return level.var_636485e45bb95523;
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0xdb0b054, Offset: 0xa3c1
// Size: 0x1b, Type: bool
function private function_5a7a05e383310670()
{
    return level.gametypebundle.var_53486d8d1bcaeac7 == "dmz";
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0x3281712b, Offset: 0xa3e5
// Size: 0x8c
function private function_fb1aef9bad80366d( player, eventparams, aeeventname )
{
    if ( !function_636485e45bb95523() )
    {
        return;
    }
    
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_5377c467a47f38de" ) ] = function_91749da806ed2063( player, "area" );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_8241ff1c332246d1" ) ] = function_91749da806ed2063( player, "poi" );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9eed6e7d716acfd1" ) ] = function_91749da806ed2063( player, "fortress" );
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0xd8bc7705, Offset: 0xa479
// Size: 0xaf
function private function_f555a98b1b53d20d( player, eventparamsstruct, aeeventname )
{
    if ( !function_636485e45bb95523() )
    {
        return;
    }
    
    var_db03056f8af85477 = function_91749da806ed2063( player, "area" );
    var_e37d8372174b01e6 = function_91749da806ed2063( player, "poi" );
    var_556491c5bd00abf4 = function_91749da806ed2063( player, "fortress" );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_5377c467a47f38de", var_db03056f8af85477 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_8241ff1c332246d1", var_e37d8372174b01e6 );
    function_df424ab6c42d089c( eventparamsstruct, aeeventname, #"hash_9eed6e7d716acfd1", var_556491c5bd00abf4 );
}

// Namespace challenges
// Params 3
// Checksum 0xc763a966, Offset: 0xa530
// Size: 0xbc
function function_918534454a508804( player, activitytype, var_725b4aa1a1c7d5f9 )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"end_activity";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"activity_type" ) ] = activitytype;
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    
    if ( var_725b4aa1a1c7d5f9 )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_ba5b14fd0c67b0fa" ) ] = var_725b4aa1a1c7d5f9;
    }
    
    function_ee4471f0d17f1d51( aeeventname, eventparams );
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x6f6eba5d, Offset: 0xa5f4
// Size: 0x30b
function function_e14422a86e7720d6( player, weapon )
{
    reloadtime = gettime();
    var_b77c998a2d74f8f5 = istrue( player.var_b77c998a2d74f8f5 );
    primaryweaponobj = player.primaryweaponobj;
    function_53df6f352d77bfa7();
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    var_49a734ae41b667b3 = getweaponclass( weapon );
    weaponlootid = weapon::getweaponlootid( weapon );
    
    if ( !( isdefined( var_49a734ae41b667b3 ) && isdefined( weaponlootid ) ) )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"reload";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    reloadbitfield = 0;
    
    if ( var_b77c998a2d74f8f5 )
    {
        reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"hash_6d190b2e7aefb9a0" ) );
    }
    
    var_e1835d03268913bb = weapons::recommendedstatusbyseason( primaryweaponobj, player );
    
    if ( isdefined( var_e1835d03268913bb ) )
    {
        if ( var_e1835d03268913bb[ 0 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_0" ) );
        }
        
        if ( var_e1835d03268913bb[ 1 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_1" ) );
        }
        
        if ( var_e1835d03268913bb[ 2 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_2" ) );
        }
        
        if ( var_e1835d03268913bb[ 3 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_3" ) );
        }
        
        if ( var_e1835d03268913bb[ 4 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_4" ) );
        }
        
        if ( var_e1835d03268913bb[ 5 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_5" ) );
        }
        
        if ( var_e1835d03268913bb[ 6 ] )
        {
            reloadbitfield = function_a23641f33e985edb( reloadbitfield, ae_utility::function_2d1565a236387b2( #"reload_bitfield", #"recommended_season_6" ) );
        }
    }
    
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = weaponlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"reload_bitfield" ) ] = reloadbitfield;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams, gettime() - reloadtime );
}

// Namespace challenges
// Params 4
// Checksum 0x3dc5fe9f, Offset: 0xa907
// Size: 0x144
function function_aa7e85671af44dea( player, weapon, healthdamage, armordamage )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( isagent( player ) )
    {
        return;
    }
    
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    var_49a734ae41b667b3 = getweaponclass( weapon );
    
    if ( !isdefined( var_49a734ae41b667b3 ) )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    damagetotal = healthdamage + armordamage;
    aeeventname = #"weapon_damage";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = damagetotal;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 5
// Checksum 0xc20af3af, Offset: 0xaa53
// Size: 0x122
function function_16334bed0602c028( victim, healthdamage, armordamage, attacker, objweapon )
{
    profilestart();
    
    if ( isagent( victim ) )
    {
        profilestop();
        return;
    }
    
    if ( !victim challengesenabledforplayer() )
    {
        profilestop();
        return;
    }
    
    if ( level.gametypebundle.var_90d047d626a9a123 == #"slowprocessing" )
    {
        if ( !isdefined( self.var_e72301649f2122c9 ) )
        {
            self.var_e72301649f2122c9 = [];
        }
        
        self.var_e72301649f2122c9[ self.var_e72301649f2122c9.size ] = { #damagedtime:gettime(), #objweapon:objweapon, #attacker:attacker, #armordamage:armordamage, #healthdamage:healthdamage, #victim:victim };
        
        if ( self.var_e72301649f2122c9.size >= 30 )
        {
            thread function_d719a3fadb1a6a38( arraycopy( self.var_e72301649f2122c9 ) );
            self.var_e72301649f2122c9 = undefined;
            profilestop();
            return;
        }
        
        thread function_a549bff7e35508a9();
        profilestop();
        return;
    }
    
    function_838917f6702a1090( victim, healthdamage, armordamage, attacker, objweapon );
    profilestop();
}

// Namespace challenges
// Params 0, eflags: 0xc
// Checksum 0x63dc720c, Offset: 0xab7d
// Size: 0x7b
function private function_a549bff7e35508a9()
{
    self notify( #"hash_7fe1753d1c2894a5" );
    self endon( #"hash_7fe1753d1c2894a5" );
    self endon( #"disconnect" );
    
    do
    {
        waitframe();
        waittillframeend();
        var_5dea8c6374f5a67c = 0;
        
        if ( script::function_7cae34dfec48a6d1() )
        {
            var_881054c6b24926ed = function_8fc063681724727f();
            
            if ( level.var_28b0b95d6825011 == var_881054c6b24926ed || level.var_a97ce32d4d2a2f7a == var_881054c6b24926ed )
            {
                var_5dea8c6374f5a67c = 1;
            }
        }
    }
    while ( var_5dea8c6374f5a67c );
    
    function_19a53680db045b8f();
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0xabacf39, Offset: 0xac00
// Size: 0x104
function private function_19a53680db045b8f()
{
    profilestart();
    function_1d44f32bbd313a67( #"hash_41b6f2f6e4207296", self.var_e72301649f2122c9.size ?? 0 );
    function_1d44f32bbd313a67( #"hash_e7fe899e243e81c3", self.entnum ?? utility::get_entity_number( self ) );
    
    foreach ( event in self.var_e72301649f2122c9 )
    {
        function_838917f6702a1090( event.victim, event.healthdamage, event.armordamage, event.attacker, event.objweapon, event.damagedtime );
    }
    
    self.var_e72301649f2122c9 = undefined;
    profilestop();
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x279a5a2b, Offset: 0xad0c
// Size: 0x6f
function private function_d719a3fadb1a6a38( var_e72301649f2122c9 )
{
    self endon( #"disconnect" );
    
    do
    {
        waitframe();
        waittillframeend();
        var_5dea8c6374f5a67c = 0;
        
        if ( script::function_7cae34dfec48a6d1() )
        {
            var_881054c6b24926ed = function_8fc063681724727f();
            
            if ( level.var_28b0b95d6825011 == var_881054c6b24926ed || level.var_a97ce32d4d2a2f7a == var_881054c6b24926ed )
            {
                var_5dea8c6374f5a67c = 1;
            }
        }
    }
    while ( var_5dea8c6374f5a67c );
    
    function_afdbacdeb839f7e0( var_e72301649f2122c9 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x2eb16056, Offset: 0xad83
// Size: 0xf6
function private function_afdbacdeb839f7e0( var_e72301649f2122c9 )
{
    profilestart();
    function_1d44f32bbd313a67( #"hash_488b779d1b1a8952", var_e72301649f2122c9.size ?? 0 );
    function_1d44f32bbd313a67( #"hash_e7fe899e243e81c3", self.entnum ?? utility::get_entity_number( self ) );
    
    foreach ( event in var_e72301649f2122c9 )
    {
        function_838917f6702a1090( event.victim, event.healthdamage, event.armordamage, event.attacker, event.objweapon, event.damagedtime );
    }
    
    profilestop();
}

// Namespace challenges
// Params 6, eflags: 0x4
// Checksum 0x3f11c694, Offset: 0xae81
// Size: 0x2a4
function private function_838917f6702a1090( victim, healthdamage, armordamage, attacker, objweapon, damagedtime )
{
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    if ( !isdefined( healthdamage ) )
    {
        healthdamage = 0;
    }
    
    if ( !isdefined( armordamage ) )
    {
        armordamage = 0;
    }
    
    if ( !isdefined( damagedtime ) )
    {
        damagedtime = gettime();
    }
    
    weaponlootid = function_201616a995d283bc( objweapon );
    var_99e5b5440bda21aa = level.var_2a768cf86c439b4c ?? function_e1f753174eeb4718();
    aeeventname = #"damaged";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    
    if ( !isdefined( level.var_787c900030f855e0 ) )
    {
        level.var_787c900030f855e0 = { #var_9df8a1b8037e4d3b:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ), #damage_type_armor:ae_utility::function_2d1565a236387b2( #"damage_type", #"armor" ), #damage_type_health:ae_utility::function_2d1565a236387b2( #"damage_type", #"health" ), #value:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ), #damage_type:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"damage_type" ), #gametype:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ), #gamemode:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ), #version:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) };
    }
    
    param_keys = level.var_787c900030f855e0;
    damagetypebitfield = 0;
    
    if ( healthdamage > 0 )
    {
        damagetypebitfield = function_a23641f33e985edb( damagetypebitfield, param_keys.damage_type_health );
    }
    
    if ( armordamage > 0 )
    {
        damagetypebitfield = function_a23641f33e985edb( damagetypebitfield, param_keys.damage_type_armor );
    }
    
    eventparams = [];
    eventparams[ param_keys.version ] = 1;
    eventparams[ param_keys.gamemode ] = var_99e5b5440bda21aa.gamemode;
    eventparams[ param_keys.gametype ] = var_99e5b5440bda21aa.gametype;
    eventparams[ param_keys.damage_type ] = damagetypebitfield;
    eventparams[ param_keys.value ] = int( max( healthdamage + armordamage, 0 ) );
    eventparams[ param_keys.var_9df8a1b8037e4d3b ] = weaponlootid ?? 0;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    victim function_2e45314624fdfdb8( aeeventid, eventparams, gettime() - damagedtime );
}

// Namespace challenges
// Params 1
// Checksum 0x96563368, Offset: 0xb12d
// Size: 0xf1
function function_ec451bdd470901cb( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( isagent( player ) )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"on_hit";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    playlistid = getplaylistid();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = playlistid;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xa36c85a2, Offset: 0xb226
// Size: 0x195
function function_5d58465654e002f2( player )
{
    gametype = function_9edd00e9e48c0821();
    gamemode = getchallengegamemode();
    
    if ( isdefined( player.laststandattacker ) && player.laststandattacker challengesenabledforplayer() )
    {
        var_49a734ae41b667b3 = getweaponclass( player.laststandattacker getcurrentweapon() ) ?? 0;
        aeeventname = #"down_enemy";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        eventparams = [];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
        player.laststandattacker function_2e45314624fdfdb8( aeeventid, eventparams );
    }
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    aeeventname = #"downed";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0xb38aa17e, Offset: 0xb3c3
// Size: 0xe8
function function_d2b9666e88748bb0( player, streak )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"squad_wiped";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    
    if ( isdefined( streak ) )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squad_wipe_streak" ) ] = streak;
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 8
// Checksum 0x738cdbe6, Offset: 0xb4b3
// Size: 0x17b
function function_267b9750fac691c1( inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers )
{
    deathtime = gettime();
    function_53df6f352d77bfa7();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    teamsize = getmatchrulesdata( "commonOption", "teamSize" );
    in_prematch = istrue( level.inprematch );
    aeeventname = #"death";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"team_size" ) ] = teamsize;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"in_prematch" ) ] = in_prematch;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams, gettime() - deathtime );
}

// Namespace challenges
// Params 1
// Checksum 0x4851c398, Offset: 0xb636
// Size: 0xc3
function function_b15a587625f2f823( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"extract_failed";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0x67f5150d, Offset: 0xb701
// Size: 0x140
function function_9cfa1e7b6e5d8ce7()
{
    var_3430aa08b890b0ff = getdvarint( @"hash_bd0f7ad1bb2671a5", -1 );
    
    if ( var_3430aa08b890b0ff >= 0 )
    {
        return var_3430aa08b890b0ff;
    }
    
    if ( isbrgamemode() )
    {
        if ( !isdefined( level.var_5aaf221daf42f53c ) )
        {
            level.var_5aaf221daf42f53c = 0;
            
            foreach ( team in level.teamnamelist )
            {
                teamcount = level.teamdata[ team ][ "teamCount" ];
                
                if ( isdefined( level.uibotmanager ) )
                {
                    teamcount += level.teamdata[ team ][ "UIBotCount" ];
                }
                
                if ( teamcount )
                {
                    level.var_5aaf221daf42f53c++;
                }
            }
        }
        
        return int( max( level.var_5aaf221daf42f53c - 1, 0 ) );
    }
    
    teamswithplayers = game_utility_mp::function_2d6eda4bd30f6b52();
    
    if ( isdefined( teamswithplayers ) )
    {
        return int( max( teamswithplayers.size - 1, 0 ) );
    }
    
    return 0;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x4c4f9d37, Offset: 0xb84a
// Size: 0x215
function private function_57ea1e5a2a77666( params )
{
    if ( !params.victimguid )
    {
        assertmsg( "<dev string:x5e2>" );
        return;
    }
    
    if ( params.var_2899bd461c78b880 )
    {
        return;
    }
    
    if ( !params.deathtime )
    {
        assertmsg( "<dev string:x668>" );
        return;
    }
    
    var_aa1eb628e616d90b = arraycopy( level.var_38f84e6d5f274bb.statustracker[ params.victimguid ][ params.var_a7b1f82b5a561d1f ] );
    script::waittillslowprocessallowed();
    aeeventname = #"nondamaging_assist";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    var_686475e17df29dd = 0;
    
    foreach ( var_3518639881f21fce in var_aa1eb628e616d90b )
    {
        foreach ( individualeffect in var_3518639881f21fce )
        {
            if ( individualeffect.timeofdeath != params.deathtime )
            {
                continue;
            }
            
            var_1e087b8b08f9f7e3 = ae_utility::function_2d1565a236387b2( #"hash_85b4e3d02eb3966f", individualeffect.statustype );
            
            if ( isdefined( var_1e087b8b08f9f7e3 ) )
            {
                var_686475e17df29dd = function_a23641f33e985edb( var_686475e17df29dd, var_1e087b8b08f9f7e3 );
            }
        }
    }
    
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_85b4e3d02eb3966f" ) ] = var_686475e17df29dd;
    reportchallengeuserserializeddicteventinternal( params.assister, aeeventname, eventparams );
}

// Namespace challenges
// Params 5
// Checksum 0x6b2460d3, Offset: 0xba67
// Size: 0xa33
function function_3ef859e4837f4249( victim, attacker, objweapon, additionaleventparams, var_94c8c18325092537 )
{
    /#
        assert( isdefined( victim ), "<dev string:x6ed>" );
        assert( isdefined( attacker ), "<dev string:x737>" );
        assert( isdefined( objweapon ), "<dev string:x783>" );
    #/
    
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    if ( player_utility::isfriendly( attacker.team, victim ) )
    {
        return;
    }
    
    suspiciouskill = 0;
    suspiciousdown = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
    {
        [ suspiciouskill, suspiciousdown ] = attacker utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", victim, victim.laststandattacker );
    }
    
    if ( suspiciouskill > 0 || suspiciousdown > 0 )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    var_3156961e7b72a1d0 = 0;
    var_3b82dd60957c0a0f = function_9cfa1e7b6e5d8ce7();
    
    if ( isdefined( level.var_bbd722ce00189d4f ) )
    {
        var_3b82dd60957c0a0f = [[ level.var_bbd722ce00189d4f ]]( var_3b82dd60957c0a0f, victim );
    }
    
    weaponname = weaponfixup( objweapon, attacker );
    weaponlootid = getweaponlootid( objweapon, weaponname );
    var_31c9ded9444b556b = objweapon.basename && objweapon.basename != "none";
    var_49a734ae41b667b3 = function_cd4a1dc6ad5b23cb( objweapon );
    
    if ( victim.var_49b8b885e3f811e )
    {
        var_49a734ae41b667b3 = function_1df91dde90c55ec7( objweapon, attacker, var_49a734ae41b667b3 );
    }
    
    if ( weapon::function_597e1c0b6df2fada( objweapon.basename ) )
    {
        weaponclassarray = getweaponclassarray();
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "stowable" ] );
    }
    
    attachmentflags = function_c003bf895c0a94d3( objweapon );
    var_e1835d03268913bb = weapons::recommendedstatusbyseason( objweapon, attacker );
    assist_recommended_weapon_list = 0;
    
    if ( isdefined( var_e1835d03268913bb ) )
    {
        if ( var_e1835d03268913bb[ 0 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_0" ) );
        }
        
        if ( var_e1835d03268913bb[ 1 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_1" ) );
        }
        
        if ( var_e1835d03268913bb[ 2 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_2" ) );
        }
        
        if ( var_e1835d03268913bb[ 3 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_3" ) );
        }
        
        if ( var_e1835d03268913bb[ 4 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_4" ) );
        }
        
        if ( var_e1835d03268913bb[ 5 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_5" ) );
        }
        
        if ( var_e1835d03268913bb[ 6 ] )
        {
            assist_recommended_weapon_list = function_a23641f33e985edb( assist_recommended_weapon_list, ae_utility::function_2d1565a236387b2( #"assist_recommended_weapon_list", #"recommended_season_6" ) );
        }
    }
    
    attachmentcount = 0;
    
    if ( isdefined( objweapon ) && weapon_utility::isbulletweaponobject( objweapon ) )
    {
        weaponname = weaponfixup( objweapon, attacker );
        var_287b4b3237470d77 = getweapondefaultattachments( weapon::getdefaultweaponbasename( weaponname ) );
        
        foreach ( attachment in objweapon.attachments )
        {
            if ( !isdefined( attachment ) || arraycontains( var_287b4b3237470d77, attachment ) )
            {
                continue;
            }
            
            attachmentcount++;
        }
        
        burstfirecount = objweapon.burstcount;
        modesemi = objweapon.issemiauto || burstfirecount == 1 || objweapon.adsissemiauto && var_94c8c18325092537.var_797fc84e38cc569a;
        modeauto = !modesemi && objweapon.isauto;
        
        if ( modeauto )
        {
            var_3156961e7b72a1d0 = function_a23641f33e985edb( var_3156961e7b72a1d0, ae_utility::function_2d1565a236387b2( #"hash_97f6cfc97585b0b1", #"hash_f753c348e9695b37" ) );
        }
        
        if ( objweapon.issemiauto || burstfirecount == 1 )
        {
            var_3156961e7b72a1d0 = function_a23641f33e985edb( var_3156961e7b72a1d0, ae_utility::function_2d1565a236387b2( #"hash_97f6cfc97585b0b1", #"hash_af18dde6238bfa93" ) );
        }
        else if ( burstfirecount > 1 )
        {
            var_3156961e7b72a1d0 = function_a23641f33e985edb( var_3156961e7b72a1d0, ae_utility::function_2d1565a236387b2( #"hash_97f6cfc97585b0b1", #"burst_fire_assist" ) );
        }
    }
    
    if ( var_31c9ded9444b556b && weapon::iscacprimaryweapon( objweapon ) && objweapon.var_1616e6fbba9a722d == getxhashasset( attacker.loadoutsecondary ) )
    {
        var_3156961e7b72a1d0 = function_a23641f33e985edb( var_3156961e7b72a1d0, ae_utility::function_2d1565a236387b2( #"hash_97f6cfc97585b0b1", #"hash_a77be888d1d610a2" ) );
    }
    
    in_prematch = istrue( level.inprematch );
    attackerloadoutperks = attacker getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( attackerloadoutperks );
    var_d0c3011b1076156d = 0;
    var_87c82a1adacd3247 = 0;
    var_46d65429ef40d67d = 0;
    var_9d8af5187ea30db = 0;
    var_f0133e517636cdbf = 0;
    killingplayer = victim.lastattacker;
    
    if ( isdefined( killingplayer ) )
    {
        var_d0c3011b1076156d = killingplayer.modifiers[ "mask" ] ?? 0;
        var_87c82a1adacd3247 = killingplayer.modifiers[ "mask2" ] ?? 0;
        var_46d65429ef40d67d = killingplayer.modifiers[ "mask3" ] ?? 0;
        var_9d8af5187ea30db = killingplayer.modifiers[ "mask4" ] ?? 0;
        var_f0133e517636cdbf = killingplayer.modifiers[ "mask5" ] ?? 0;
    }
    
    [ enemytype, var_34c4673a21bda4c ] = function_70dee0eafbb25426( victim );
    operatorlootid = attacker function_6a3bd1af73a5a390() ?? 0;
    var_d491b50ec0d8dc0b = attacker function_a7e780cc2464a43b() ?? 0;
    var_a54b19ae1be00a35 = istrue( var_94c8c18325092537.var_475c778a68b2acec );
    aeeventname = #"assist";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( attacker, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = weaponlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"enemy_squads_remaining" ) ] = var_3b82dd60957c0a0f;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"assist_recommended_weapon_list" ) ] = assist_recommended_weapon_list;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"in_prematch" ) ] = in_prematch;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518d95df41024b" ) ] = var_86c674a64c35ed94.var_7111292ef37e4f97;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment_flags" ) ] = attachmentflags;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"attachment_count" ) ] = attachmentcount;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"enemy_type_bitfield" ) ] = enemytype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_22d8c6e760626656" ) ] = var_34c4673a21bda4c;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_97f6cfc97585b0b1" ) ] = var_3156961e7b72a1d0;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_bitfield1" ) ] = var_d0c3011b1076156d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_bitfield2" ) ] = var_87c82a1adacd3247;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_bitfield3" ) ] = var_46d65429ef40d67d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_bitfield4" ) ] = var_9d8af5187ea30db;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_7f94e41c1787f8ae" ) ] = var_f0133e517636cdbf;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_alternate_operator_id" ) ] = var_d491b50ec0d8dc0b;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"assisted_with_combat_link" ) ] = var_a54b19ae1be00a35;
    
    if ( isdefined( level.sharedfuncs[ #"hash_3ac9ab20c49792f2" ][ #"getskilldivisiontier" ] ) )
    {
        skilldivision = victim [[ level.sharedfuncs[ #"hash_3ac9ab20c49792f2" ][ #"getskilldivisiontier" ] ]]();
        
        if ( isdefined( skilldivision ) )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_victim_skill_division" ) ] = skilldivision;
        }
    }
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            if ( ae_utility::function_4b9f0ca95497e0c8( aeeventname, paramkey ) )
            {
                eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval ?? 0;
            }
        }
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    attacker function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2, eflags: 0x4
// Checksum 0x8d37f1ae, Offset: 0xc4a2
// Size: 0x109
function private function_c003bf895c0a94d3( objweapon, attachmentflags = 0 )
{
    if ( !objweapon.attachments || objweapon.attachments.size <= 0 )
    {
        return attachmentflags;
    }
    
    foreach ( attachment in objweapon.attachments )
    {
        if ( !isdefined( attachment ) )
        {
            continue;
        }
        
        attachmentflags = function_a23641f33e985edb( attachmentflags, function_7f29f44a1c8bebd0( objweapon, attachment ) );
        isprestigeattachment = weapon::function_64ad6bd042bc51d3( attachment );
        
        if ( isprestigeattachment )
        {
            attachmentflags = function_a23641f33e985edb( attachmentflags, ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"prestige" ) );
        }
    }
    
    return attachmentflags;
}

// Namespace challenges
// Params 3
// Checksum 0x664eb509, Offset: 0xc5b4
// Size: 0x256
function function_42d341f05ad740f7( victim, var_48103acb536ff349, attacker )
{
    if ( !var_48103acb536ff349 challengesenabledforplayer() )
    {
        return;
    }
    
    if ( player_utility::isfriendly( attacker.team, victim ) && player_utility::isfriendly( var_48103acb536ff349.team, attacker ) )
    {
        return;
    }
    
    suspiciouskill = 0;
    suspiciousdown = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
    {
        [ suspiciouskill, suspiciousdown ] = attacker utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", victim, victim.laststandattacker );
    }
    
    if ( suspiciouskill > 0 || suspiciousdown > 0 )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    var_3b82dd60957c0a0f = function_9cfa1e7b6e5d8ce7();
    
    if ( isdefined( level.var_bbd722ce00189d4f ) )
    {
        var_3b82dd60957c0a0f = [[ level.var_bbd722ce00189d4f ]]( var_3b82dd60957c0a0f, victim );
    }
    
    in_prematch = istrue( level.inprematch );
    aeeventname = #"unassisted_kill";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"enemy_squads_remaining" ) ] = var_3b82dd60957c0a0f;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"in_prematch" ) ] = in_prematch;
    
    if ( isdefined( level.sharedfuncs[ #"hash_3ac9ab20c49792f2" ][ #"getskilldivisiontier" ] ) )
    {
        skilldivision = victim [[ level.sharedfuncs[ #"hash_3ac9ab20c49792f2" ][ #"getskilldivisiontier" ] ]]();
        
        if ( isdefined( skilldivision ) )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_victim_skill_division" ) ] = skilldivision;
        }
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    var_48103acb536ff349 function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x95b5bbea, Offset: 0xc812
// Size: 0x23
function function_fec4a87acf6d2e8e( player, killstreakinuse )
{
    player.haskillstreakactive = killstreakinuse;
}

// Namespace challenges
// Params 2
// Checksum 0x552160a7, Offset: 0xc83d
// Size: 0x28
function function_f4dbd86e49dfe54e( player, ref )
{
    thread function_51b9f496cd2c6df1( player, ref, #"activate" );
}

// Namespace challenges
// Params 4
// Checksum 0x5b94e20a, Offset: 0xc86d
// Size: 0x47
function function_5a6550a72220daf8( player, ref, totalkills, loot_source )
{
    thread function_51b9f496cd2c6df1( player, ref, #"end", totalkills, loot_source );
    function_fec4a87acf6d2e8e( player, 0 );
}

// Namespace challenges
// Params 2
// Checksum 0x930f8b70, Offset: 0xc8bc
// Size: 0x33
function function_f1f85f39f3166e24( player, ref )
{
    thread function_51b9f496cd2c6df1( player, ref, #"use" );
    function_fec4a87acf6d2e8e( player, 1 );
}

// Namespace challenges
// Params 5
// Checksum 0x2713496b, Offset: 0xc8f7
// Size: 0x1d6
function function_51b9f496cd2c6df1( player, ref, var_f7befc23b616771, totalkills, loot_source )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    eventtime = gettime();
    attackerloadoutperks = arraycopy( player getloadoutperks() );
    function_53df6f352d77bfa7( 1 );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( attackerloadoutperks );
    
    if ( !isdefined( totalkills ) )
    {
        totalkills = 0;
    }
    
    killstreaklootid = loot::getlootidfromref( ref );
    
    /#
        if ( !isdefined( killstreaklootid ) || killstreaklootid == 0 )
        {
            println( "<dev string:x7d0>" + ref + "<dev string:x7e3>" );
        }
    #/
    
    method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loadout_item_method", var_f7befc23b616771 ) );
    loot_source_bit = 0;
    
    if ( isdefined( loot_source ) )
    {
        if ( !isxhash( loot_source ) )
        {
            loot_source = getxhash( loot_source );
        }
        
        loot_source_bit = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_source", loot_source ) );
    }
    
    aeeventname = #"killstreak";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"kill_amount" ) ] = totalkills;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = killstreaklootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = method;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_source" ) ] = loot_source_bit;
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams, undefined, gettime() - eventtime );
}

// Namespace challenges
// Params 2
// Checksum 0x85922914, Offset: 0xcad5
// Size: 0x77
function function_4dc87d9356c76d42( value, aeeventname )
{
    if ( isdefined( value ) && !isint( value ) && !isstring( value ) )
    {
        println( "<dev string:x7f1>" + value + "<dev string:x804>" + getxhashsourcename( aeeventname ) );
        return int( 0 );
    }
    
    if ( !isdefined( value ) )
    {
        println( "<dev string:x83e>" + getxhashsourcename( aeeventname ) );
        return int( 0 );
    }
    
    return value;
}

// Namespace challenges
// Params 1
// Checksum 0xc0d244e6, Offset: 0xcb55
// Size: 0x2c0
function function_31c9b007b2bdc1aa( params )
{
    field_upgrade_owner = params.field_upgrade_owner;
    fieldupgraderef = params.fieldupgraderef;
    fieldupgradeent = params.fieldupgradeent;
    value = params.value ?? 0;
    total_damage = params.damage ?? 0;
    var_9755e6d557d8a5d3 = params.var_9755e6d557d8a5d3 ?? 0;
    var_f2e9694e4b4b52ee = params.var_f2e9694e4b4b52ee ?? 0;
    eventbit = params.eventtype ?? ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" );
    
    if ( !field_upgrade_owner challengesenabledforplayer() || !isplayer( field_upgrade_owner ) )
    {
        return;
    }
    
    fieldupgradeid = 0;
    fieldupgradeid = loot::getlootidfromref( fieldupgraderef );
    var_8246f93dbf14a527 = field_upgrade_owner getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( var_8246f93dbf14a527 );
    aeeventname = #"field_upgrade";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( field_upgrade_owner, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"damage" ) ] = total_damage;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = fieldupgradeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = eventbit;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"steal" ) ] = var_9755e6d557d8a5d3;
    
    if ( fieldupgradeent.challengedata.bitmodifiers )
    {
        foreach ( modifier in fieldupgradeent.challengedata.bitmodifiers )
        {
            var_f2e9694e4b4b52ee = function_a23641f33e985edb( var_f2e9694e4b4b52ee, ae_utility::function_2d1565a236387b2( #"hash_c50cf868c6994df3", modifier ) );
        }
    }
    
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_c50cf868c6994df3" ) ] = var_f2e9694e4b4b52ee;
    reportchallengeuserserializeddicteventinternal( field_upgrade_owner, aeeventname, eventparams );
}

// Namespace challenges
// Params 5
// Checksum 0xb975c696, Offset: 0xce1d
// Size: 0x195
function function_a0936b0e5b4550f3( ref, eventtypebit, value, var_9755e6d557d8a5d3 = 0, additionalparams )
{
    if ( !challengesenabledforplayer() || !isplayer( self ) )
    {
        return;
    }
    
    if ( value < 0 )
    {
        value = 1;
    }
    
    ref = supers_mp::getsuperrefoverride( ref );
    fieldupgradeid = loot::getlootidfromref( ref ) ?? 0;
    
    /#
        if ( !fieldupgradeid )
        {
            println( "<dev string:x893>" + ref + "<dev string:x7e3>" );
        }
    #/
    
    attackerloadoutperks = getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( attackerloadoutperks );
    bitfield = 0;
    bitfield = function_a23641f33e985edb( bitfield, eventtypebit );
    aeeventname = #"field_upgrade";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( self, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = fieldupgradeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = bitfield;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"steal" ) ] = var_9755e6d557d8a5d3;
    
    if ( isarray( additionalparams ) )
    {
        eventparams = function_c6c06162c8e6ae75( eventparams, additionalparams );
    }
    
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0xb096e259, Offset: 0xcfba
// Size: 0x42
function function_24c3c132db024c21()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"forward_position";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0x63d4cb7e, Offset: 0xd004
// Size: 0x42
function function_5ad31191afd12405()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"coast_cleared";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 3
// Checksum 0x84244a5f, Offset: 0xd04e
// Size: 0x149
function function_a3678ff124a05f01( player, value, gameobject )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( value ) )
    {
        value = 1;
    }
    
    capture_bitfield = 0;
    
    if ( self.active_camo_enabled )
    {
        capture_bitfield = function_a23641f33e985edb( capture_bitfield, ae_utility::function_2d1565a236387b2( #"hash_6d7114bdc17e4142", #"active_camo_enabled" ) );
    }
    
    if ( self.stealth_perks_to_remove )
    {
        capture_bitfield = function_a23641f33e985edb( capture_bitfield, ae_utility::function_2d1565a236387b2( #"hash_6d7114bdc17e4142", #"stealth_enabled" ) );
    }
    
    aeeventname = #"capture";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = function_69e4c5a699ad515( player );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xfd5fcb7c, Offset: 0xd19f
// Size: 0xa4
function function_69e4c5a699ad515( player )
{
    lootid = 0;
    
    if ( !isplayer( player ) )
    {
        if ( player.subclass == "capture_bot" )
        {
            owner = player.owner;
            
            if ( isdefined( level.sharedfuncs[ #"player" ][ #"getcurrentsuperref" ] ) )
            {
                superref = owner [[ level.sharedfuncs[ #"player" ][ #"getcurrentsuperref" ] ]]();
                lootid = loot::getlootidfromref( superref );
            }
        }
    }
    
    return lootid;
}

// Namespace challenges
// Params 1
// Checksum 0x4886c9d, Offset: 0xd24c
// Size: 0x6b
function function_5f09e82f1ba9ce65( var_5fbf4cfe501a944d = 0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"defuse";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"is_disguised" ) ] = istrue( var_5fbf4cfe501a944d );
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x8b6f4f0, Offset: 0xd2bf
// Size: 0x6b
function function_981ae5464b9301da( var_5fbf4cfe501a944d = 0 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"plant";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"is_disguised" ) ] = istrue( var_5fbf4cfe501a944d );
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0xa3b0e64e, Offset: 0xd332
// Size: 0x5f
function function_8118ace38657d9b1()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"slayer_kill_chain";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = self.var_f05d2dfb2652889f;
    reportchallengeuserserializeddicteventinternal( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xff80a05, Offset: 0xd399
// Size: 0x9e
function function_2681b557d49940a4( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"drone_gun_emp";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xca826139, Offset: 0xd43f
// Size: 0xd3
function function_623dd8fe8a3b63e0( runtime )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"one_off_get_higher";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    completedruntime = runtime;
    params = [ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ), 1, ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ), getchallengegamemode(), ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ), function_9edd00e9e48c0821(), ae_utility::function_70b8bc68f3d8031e( aeeventname, #"objective_time" ), completedruntime ];
    reportchallengeuserserializedeventwrapper( aeeventid, params );
}

// Namespace challenges
// Params 1
// Checksum 0x56e1eac5, Offset: 0xd51a
// Size: 0x7e
function onstun( equipment )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"stun";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"equipment_bitfield1" ) ] = equipment;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xb004d679, Offset: 0xd5a0
// Size: 0xf4
function function_3c9a237d3a836cc9( params )
{
    player = params.player;
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    healbitfield = 0;
    aeeventname = #"stim";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = maxint( 0, params.amounthealed );
    
    if ( params.var_b52c60914e97b097 )
    {
        healbitfield = function_a23641f33e985edb( healbitfield, ae_utility::function_2d1565a236387b2( #"heal_bitfield", #"quick_heal" ) );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"heal_bitfield" ) ] = healbitfield;
    }
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x10973238, Offset: 0xd69c
// Size: 0x174
function function_8e891c96efe9f293( equipment )
{
    aeeventname = #"hack";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    owner = self;
    hacker_loot_id = 0;
    hacked_loot_id = 0;
    
    if ( self.equipmentref == "equip_capture_bot" )
    {
        owner = self.owner;
        
        if ( isdefined( level.sharedfuncs[ #"player" ][ #"getcurrentsuperref" ] ) )
        {
            superref = owner [[ level.sharedfuncs[ #"player" ][ #"getcurrentsuperref" ] ]]();
            hacker_loot_id = loot::getlootidfromref( superref );
        }
    }
    
    if ( !owner challengesenabledforplayer() )
    {
        return;
    }
    
    if ( isdefined( loot::getlootidfromref( equipment ) ) )
    {
        hacked_loot_id = loot::getlootidfromref( equipment );
    }
    
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id_1" ) ] = hacked_loot_id;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = hacker_loot_id;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    owner function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x5808d424, Offset: 0xd818
// Size: 0x100
function gettouchinglocaletriggers( attacker, victim )
{
    buffer = "";
    
    if ( !isdefined( level.localetriggers ) )
    {
        return buffer;
    }
    
    found = 0;
    
    foreach ( trigger in level.localetriggers )
    {
        if ( attacker istouching( trigger ) || isdefined( victim ) && victim istouching( trigger ) )
        {
            if ( isdefined( trigger.localeid ) )
            {
                if ( found )
                {
                    buffer += "|";
                }
                
                buffer += trigger.localeid;
                found = 1;
            }
        }
    }
    
    return buffer;
}

// Namespace challenges
// Params 3
// Checksum 0xe239b596, Offset: 0xd921
// Size: 0x11e
function function_7bc79aeb658f2606( player, contractid, initiatingplayer )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    operatorlootid = player function_6a3bd1af73a5a390();
    aeeventname = #"contract_start";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = contractid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 9
// Checksum 0x1c2abe8e, Offset: 0xda47
// Size: 0x35f
function function_84e8396c49d7b89d( player, contractid, completed, var_85384f7a9139a7db, startingpoi, contractname, var_814c7e0de0018e29, islegendarycontract, var_c79d572823fbd9a9 )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    operatorlootid = player function_6a3bd1af73a5a390();
    var_3e6552d6069866d1 = 0;
    
    if ( isalive( player ) )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"alive" ) );
    }
    
    if ( var_814c7e0de0018e29 )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"unique_contract_attempted" ) );
    }
    
    if ( completed )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"completed" ) );
    }
    else
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"failed" ) );
    }
    
    if ( var_85384f7a9139a7db == 1 )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"team1" ) );
    }
    else if ( var_85384f7a9139a7db == 2 )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"team2" ) );
    }
    
    if ( isdefined( contractname ) )
    {
        typeid = ae_utility::function_357622cc2d8da787( contractname );
    }
    
    if ( islegendarycontract )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"is_legendary_contract" ) );
    }
    
    if ( var_c79d572823fbd9a9 )
    {
        var_3e6552d6069866d1 = function_a23641f33e985edb( var_3e6552d6069866d1, ae_utility::function_2d1565a236387b2( #"hash_bf1744b6c07743aa", #"hash_1a865599cf22c982" ) );
    }
    
    squadmatesunoids = function_c1eca4afdd49da1a( player );
    aeeventname = #"contract_end";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bf1744b6c07743aa" ) ] = var_3e6552d6069866d1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate0" ) ] = squadmatesunoids[ 0 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate1" ) ] = squadmatesunoids[ 1 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate2" ) ] = squadmatesunoids[ 2 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate3" ) ] = squadmatesunoids[ 3 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"squadmate4" ) ] = squadmatesunoids[ 4 ];
    
    if ( isdefined( typeid ) )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"contract_type" ) ] = typeid;
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 5
// Checksum 0x887585d1, Offset: 0xddae
// Size: 0xd8
function function_4a4612105bf5d7b( eventparams, aeeventname, missionid, state, type )
{
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"mission_manager_id" ) ] = missionid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"mission_manager_state" ) ] = state;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"mission_manager_type" ) ] = type;
    return eventparams;
}

// Namespace challenges
// Params 1
// Checksum 0x1ca4e983, Offset: 0xde8f
// Size: 0xa2
function function_99019a61c5e82233( params )
{
    if ( !params.player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"mission_manager_step";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams = function_4a4612105bf5d7b( eventparams, aeeventname, params.id, params.state, params.type );
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    reportchallengeuserserializeddicteventinternal( params.player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x2e289f82, Offset: 0xdf39
// Size: 0xa2
function function_548724e2d845e340( params )
{
    if ( !params.player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"mission_manager_mission";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams = function_4a4612105bf5d7b( eventparams, aeeventname, params.id, params.state, params.type );
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    reportchallengeuserserializeddicteventinternal( params.player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xec7db36c, Offset: 0xdfe3
// Size: 0x3e
function private function_d9305fc31d40bc5d( instance )
{
    itembundlename = common_item::function_33a2c00e46263d99( instance );
    
    if ( isdefined( itembundlename ) )
    {
        return function_a23641f33e985edb( 0, getscriptbundlefieldvalue( itembundlename, #"hash_b338d6eb1d10a396" ) );
    }
    
    return 0;
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x4287ab03, Offset: 0xe02a
// Size: 0x79
function private function_3a9e91981a8e0c53()
{
    if ( level.var_8d8e247dadcaaae0 )
    {
        return level.mapnameae;
    }
    
    var_8d8e247dadcaaae0 = level.mapinfobundle.var_94c4792728a74c77;
    
    if ( !var_8d8e247dadcaaae0 )
    {
        /#
            if ( getdvarint( @"hash_aa2ceb3952c72b04", 0 ) )
            {
                assertmsg( "<dev string:x8a9>" );
            }
        #/
        
        return 0;
    }
    
    var_8d8e247dadcaaae0 = ae_utility::function_14b0b5e8696534b6( #"mapname", getxhash( var_8d8e247dadcaaae0 ) );
    return var_8d8e247dadcaaae0;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x68c9e7f4, Offset: 0xe0ac
// Size: 0x50
function private function_f2ae7defdfaca2bc( cratetype )
{
    switch ( cratetype )
    {
        case #"hash_408455ac9f42888c":
            return function_a23641f33e985edb( 0, 22 );
        case #"hash_d8d9a61afc7a655b":
            return function_a23641f33e985edb( 0, 23 );
        default:
            return 0;
    }
}

// Namespace challenges
// Params 1
// Checksum 0x5868a363, Offset: 0xe104
// Size: 0x177
function function_100497be0b589bc8( crate )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( crate.cratetype != "battle_royale_drop_zone_special_loot" && crate.cratetype != "battle_royale_juggernaut" )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    operatorlootid = function_6a3bd1af73a5a390();
    lootcachetype = function_f2ae7defdfaca2bc( crate.cratetype );
    lootcachebitfield = 0;
    lootcachebitfield = function_a23641f33e985edb( lootcachebitfield, 0 );
    aeeventname = #"loot_cache";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( self, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_cache_type" ) ] = lootcachetype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f42835693a3d7da5" ) ] = lootcachebitfield;
    function_fb1aef9bad80366d( self, eventparams, aeeventname );
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0xa601b65a, Offset: 0xe283
// Size: 0x1a7
function function_f1b24bfd749d06e7( player, instance )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( instance ) && !isdefined( instance.type ) )
    {
        return;
    }
    
    operatorlootid = player function_6a3bd1af73a5a390();
    lootcachetype = function_d9305fc31d40bc5d( instance );
    lootcachebitfield = 0;
    lootcachebitfield = function_a23641f33e985edb( lootcachebitfield, ae_utility::function_2d1565a236387b2( #"hash_f42835693a3d7da5", #"previously_unopened" ) );
    supplysweeps = level.teamdata[ player.team ][ "activeSupplySweeps" ];
    
    if ( isdefined( supplysweeps ) && supplysweeps.size > 0 )
    {
        lootcachebitfield = function_a23641f33e985edb( lootcachebitfield, ae_utility::function_2d1565a236387b2( #"hash_f42835693a3d7da5", #"hash_7126b8b1a66baa4a" ) );
    }
    
    if ( utility::issharedfuncdefined( #"challenges", #"hash_f7f21e7a2c2c67a4" ) )
    {
        lootcachebitfield = utility::callsharedfunc( #"challenges", #"hash_f7f21e7a2c2c67a4", player, lootcachebitfield );
    }
    
    aeeventname = #"loot_cache";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_cache_type" ) ] = lootcachetype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f42835693a3d7da5" ) ] = lootcachebitfield;
    function_fb1aef9bad80366d( player, eventparams, aeeventname );
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 6
// Checksum 0x549b439c, Offset: 0xe432
// Size: 0xcc
function onkioskpurchaseitem( itemtyperef, itemref, lootid, quantity, cashvalue, var_209fdcce39fd01cf )
{
    buy_action = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    
    if ( var_209fdcce39fd01cf )
    {
        bitid = ae_utility::function_2d1565a236387b2( #"hash_54e349112fcb5cd8", #"hash_fc5a7e86e1b3ad93" );
        var_df5d06005c881a6d = 0;
        var_df5d06005c881a6d = function_a23641f33e985edb( var_df5d06005c881a6d, bitid );
        additionalparams = [];
        additionalparams[ #"hash_54e349112fcb5cd8" ] = var_df5d06005c881a6d;
    }
    
    function_efec954cceb5599d( self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action, additionalparams );
}

// Namespace challenges
// Params 1
// Checksum 0xd9a44b5d, Offset: 0xe506
// Size: 0xd7
function function_1a5812d73b979e8( loadouttype )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"loadout";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = loadouttype;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x276ca3c5, Offset: 0xe5e5
// Size: 0x266
function onpickupweapon( objweapon, spawningteam )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( getdvarint( @"hash_fae6630be0fd1e57", 0 ) )
    {
        return;
    }
    
    if ( spawningteam == self.team )
    {
        return;
    }
    
    aeeventname = #"pickup_weapon";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    gunsmith_attachments = findgunsmithattachments( objweapon );
    var_43fc153efde8cfa9 = function_2d04c21246a0442a( objweapon );
    weaponlootid = weapon::function_57559cfce1d2812d( objweapon );
    var_d57c5d3783f44042 = weapon::function_d57c5d3783f44042( objweapon );
    
    if ( !isdefined( weaponlootid ) )
    {
        weaponlootid = 0;
    }
    
    if ( !isdefined( var_43fc153efde8cfa9 ) )
    {
        var_43fc153efde8cfa9 = 0;
    }
    
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = weaponlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment1" ) ] = gunsmith_attachments[ 0 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment2" ) ] = gunsmith_attachments[ 1 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment3" ) ] = gunsmith_attachments[ 2 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment4" ) ] = gunsmith_attachments[ 3 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment5" ) ] = gunsmith_attachments[ 4 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment6" ) ] = gunsmith_attachments[ 5 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment7" ) ] = gunsmith_attachments[ 6 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment8" ) ] = gunsmith_attachments[ 7 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment9" ) ] = gunsmith_attachments[ 8 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment10" ) ] = gunsmith_attachments[ 9 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_weapon" ) ] = var_d57c5d3783f44042;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment_non_default_count" ) ] = var_43fc153efde8cfa9;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x94f661cf, Offset: 0xe853
// Size: 0x125
function function_a9d044c119da4540( pingtype )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    aeeventname = #"ping";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    gametype = function_9edd00e9e48c0821();
    var_ba6bc33c995feac9 = 0;
    
    if ( pingtype == "enemy" )
    {
        var_ba6bc33c995feac9 = function_a23641f33e985edb( var_ba6bc33c995feac9, ae_utility::function_2d1565a236387b2( #"hash_fc7c59e1de2e79aa", #"hash_cf5caa96f917f27d" ) );
    }
    
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = pingtype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_fc7c59e1de2e79aa" ) ] = var_ba6bc33c995feac9;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x5e0ba374, Offset: 0xe980
// Size: 0xf2
function function_9182e1fb47a5d129( amount )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( amount <= 0 )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    var_bb8beccbd38270c = amount;
    aeeventname = #"resurgence_respawn_reduce";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ), 1, ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ), gamemode, ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ), gametype, ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ), var_bb8beccbd38270c ];
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x4d662bc2, Offset: 0xea7a
// Size: 0x118
function onping( pingtype )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    var_ba6bc33c995feac9 = 0;
    
    if ( pingtype == "enemy" )
    {
        var_ba6bc33c995feac9 = function_a23641f33e985edb( var_ba6bc33c995feac9, ae_utility::function_2d1565a236387b2( #"hash_fc7c59e1de2e79aa", #"hash_cf5caa96f917f27d" ) );
    }
    
    aeeventname = #"ping";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_fc7c59e1de2e79aa" ) ] = var_ba6bc33c995feac9;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xcbc7141b, Offset: 0xeb9a
// Size: 0xca
function function_2674338fc4026deb( amount )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"plunder_deposit";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"amount_deposited" ) ] = amount;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0xbc6f5d96, Offset: 0xec6c
// Size: 0xaa
function function_660f926417423d77()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"interrogate";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0xef072742, Offset: 0xed1e
// Size: 0x8c
function function_ecd6ed381762a4eb( reviver, revivee )
{
    revivebitfield = 0;
    revivebitfield = function_a23641f33e985edb( revivebitfield, ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"last_stand" ) );
    
    if ( utility::issharedfuncdefined( #"challenges", #"hash_fdebb4c8cc9f1d5e" ) )
    {
        [[ utility::getsharedfunc( #"challenges", #"hash_fdebb4c8cc9f1d5e" ) ]]( reviver, revivee, revivebitfield );
        return;
    }
    
    function_cf263d7c7bd3344b( reviver, revivee, revivebitfield );
}

// Namespace challenges
// Params 2
// Checksum 0xa3042784, Offset: 0xedb2
// Size: 0x67
function function_680ad335e620f62c( reviver, revivee )
{
    if ( !level.gametypebundle.var_87268747c7d23353 )
    {
        return;
    }
    
    revivebitfield = 0;
    revivebitfield = function_a23641f33e985edb( revivebitfield, ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"team_revive" ) );
    function_cf263d7c7bd3344b( reviver, revivee, revivebitfield );
}

// Namespace challenges
// Params 3
// Checksum 0x2e280c43, Offset: 0xee21
// Size: 0x1bc
function function_cf263d7c7bd3344b( reviver, revivee, revivebitfield )
{
    if ( reviver challengesenabledforplayer() )
    {
        aeeventname = #"revive";
        
        if ( !isdefined( revivebitfield ) )
        {
            revivebitfield = 0;
        }
        
        revivebitfield = function_a23641f33e985edb( revivebitfield, ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"reviver" ) );
        
        if ( reviver.team != revivee.team )
        {
            revivebitfield = function_a23641f33e985edb( revivebitfield, ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"enemy_revive" ) );
        }
        
        operatorlootid = reviver function_6a3bd1af73a5a390();
        
        if ( reviver == revivee )
        {
            revivebitfield = function_a23641f33e985edb( revivebitfield, ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"revivee" ) );
        }
        
        eventparams = [];
        function_f4c306eea6673ab0( aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"revive_bitfield" ) ] = revivebitfield;
        reportchallengeuserserializeddicteventinternal( reviver, aeeventname, eventparams );
    }
    
    if ( reviver != revivee && revivee challengesenabledforplayer() )
    {
        aeeventname = #"revive";
        revivebitfield = 0;
        revivebitfield = function_a23641f33e985edb( revivebitfield, ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"revivee" ) );
        operatorlootid = revivee function_6a3bd1af73a5a390();
        eventparams = [];
        function_f4c306eea6673ab0( aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"revive_bitfield" ) ] = revivebitfield;
        reportchallengeuserserializeddicteventinternal( revivee, aeeventname, eventparams );
    }
}

// Namespace challenges
// Params 2
// Checksum 0x4517773a, Offset: 0xefe5
// Size: 0x18f
function function_a85672e6a703a837( player, iswinner )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    operatorlootid = player function_6a3bd1af73a5a390();
    bitfield1 = 0;
    
    if ( iswinner )
    {
        bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_2614881933cc996e", #"win" ) );
    }
    else
    {
        bitfield1 = function_a23641f33e985edb( bitfield1, ae_utility::function_2d1565a236387b2( #"hash_2614881933cc996e", #"loss" ) );
    }
    
    teamsize = getmatchrulesdata( "commonOption", "teamSize" );
    aeeventname = #"gulag_end";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_2614881933cc996e" ) ] = bitfield1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"team_size" ) ] = teamsize;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x5abe980, Offset: 0xf17c
// Size: 0x7f
function function_656efb67fb2e8058( bitfield, bit )
{
    if ( !isdefined( level.aedisabled ) )
    {
        level.aedisabled = getdvarint( @"hash_f0c3671383d467f8", 0 ) > 0;
    }
    
    if ( level.aedisabled )
    {
        return 0;
    }
    
    if ( !isdefined( bit ) )
    {
        return bitfield;
    }
    
    if ( bit > 31 || isstring( bitfield ) )
    {
        return function_d31d7ed453d514c8( bitfield + "", bit );
    }
    
    return bitfield & ~( 1 << bit );
}

// Namespace challenges
// Params 1
// Checksum 0x4a111740, Offset: 0xf203
// Size: 0x304
function function_a9a45e1ae76e75db( objweapon )
{
    weaponclassarray = getweaponclassarray();
    
    if ( !isdefined( objweapon ) )
    {
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( objweapon ) )
    {
        weaponname = objweapon.basename;
    }
    else
    {
        assert( isstring( objweapon ) );
        weaponname = objweapon;
    }
    
    if ( !isdefined( weaponname ) )
    {
        return 0;
    }
    
    weaponroot = weapon::getweaponrootname( objweapon );
    
    if ( isdefined( level.weaponmapdata[ weaponroot ] ) && isdefined( level.weaponmapdata[ weaponroot ].group ) )
    {
        weapongroup = level.weaponmapdata[ weaponroot ].group;
    }
    
    if ( isdefined( level.sharedfuncs[ #"challenges" ][ #"hash_e5b6c6c6cc4ea0b1" ] ) )
    {
        var_c50677ab1aaaaa71 = utility::callsharedfunc( #"challenges", #"hash_e5b6c6c6cc4ea0b1", weaponroot );
        
        if ( isdefined( var_c50677ab1aaaaa71 ) )
        {
            weapongroup = var_c50677ab1aaaaa71;
        }
    }
    
    if ( !isdefined( weapongroup ) )
    {
        return 0;
    }
    
    var_49a734ae41b667b3 = 0;
    
    if ( weaponroot == "iw9_ar_golf3" || weaponname == "iw9_ar_schotel" || weaponname == "iw9_br_msecho" || weaponname == "iw9_br_soscar14" )
    {
        var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "battle" ] );
        return var_49a734ae41b667b3;
    }
    
    switch ( weapongroup )
    {
        case #"hash_8af0086b038622b5":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "rifle" ] );
            break;
        case #"hash_47368bc0d2ef1565":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "marksman" ] );
            break;
        case #"hash_c095d67337b1f5a1":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "sniper" ] );
            break;
        case #"hash_9d18adab1b65a661":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "rocketlauncher" ] );
            break;
        case #"hash_bef5ec0b3e197ae":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "mg" ] );
            break;
        case #"hash_34340d457a63e7f1":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "pistol" ] );
            break;
        case #"hash_16cf6289ab06bd30":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "spread" ] );
            break;
        case #"hash_ab10f9c080fe4faf":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "smg" ] );
            break;
        case #"hash_dd616da0b395a0b0":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "battle" ] );
            break;
        case #"hash_86b11ac21f992552":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "melee_primary" ] );
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "melee" ] );
            break;
        case #"hash_a1f27f97be15d620":
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "melee_secondary" ] );
            var_49a734ae41b667b3 = function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ "melee" ] );
            break;
        default:
            return 0;
    }
    
    return var_49a734ae41b667b3;
}

// Namespace challenges
// Params 1
// Checksum 0x41a5360d, Offset: 0xf510
// Size: 0x139
function function_2ddc3608d4c7369f( bitfield )
{
    bitfieldstring = bitfield + "";
    stringlength = bitfieldstring.size;
    characters = [];
    
    for ( k = 0; k < stringlength ; k++ )
    {
        characters[ stringlength - k - 1 ] = int( bitfieldstring[ stringlength - k - 1 ] );
    }
    
    lastcharacter = stringlength - 1;
    result = [];
    nextresult = 0;
    
    while ( true )
    {
        mod2 = characters[ lastcharacter ] % 2;
        result[ nextresult ] = mod2 == 1;
        nextresult += 1;
        
        if ( mod2 == 1 )
        {
            characters[ lastcharacter ] -= 1;
        }
        
        allzero = 1;
        
        for ( k = 0; k < stringlength ; k++ )
        {
            character = characters[ stringlength - k - 1 ];
            
            if ( character != 0 )
            {
                allzero = 0;
            }
            
            if ( character % 2 == 1 )
            {
                characters[ stringlength - k ] += 5;
            }
            
            characters[ stringlength - k - 1 ] = int( character / 2 );
        }
        
        if ( allzero )
        {
            return result;
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0xa93f756a, Offset: 0xf651
// Size: 0x13e
function gettouchingspraylocaletriggers( player )
{
    if ( !isdefined( level.localetriggers ) )
    {
        return -1;
    }
    
    foreach ( trigger in level.localetriggers )
    {
        if ( player istouching( trigger ) )
        {
            valid_spray = trigger.sprayid > -1;
            var_47d807b8c35f41a5 = isdefined( player.sprayed ) && player.sprayed & 1 << trigger.sprayid;
            
            if ( valid_spray && !var_47d807b8c35f41a5 )
            {
                if ( !isdefined( player.sprayed ) )
                {
                    player.sprayed = 0;
                }
                
                player.sprayed |= 1 << trigger.sprayid;
                return trigger.sprayid;
            }
        }
    }
    
    return -1;
}

// Namespace challenges
// Params 2
// Checksum 0xaa0c4053, Offset: 0xf798
// Size: 0x14d
function function_9e5c02c20963077f( player, sprayref )
{
    self notify( #"hash_84278d39dbe9cbd3" );
    self endon( #"hash_84278d39dbe9cbd3" );
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !function_59241a1fe13f4be3( player ) )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    aeeventname = #"spray";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    mapname = function_9eb50f0c865a6b1b();
    locale = gettouchingspraylocaletriggers( player );
    lootid = sprays::function_9034df6e577a38e8( sprayref );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = locale == -1 ? 0 : locale;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"br_map_name" ) ] = mapname;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x62629c8a, Offset: 0xf8ed
// Size: 0x76
function function_59241a1fe13f4be3( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"hash_a765734e52168f0d" );
    thread spraywatchtimeout( player );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", channel, val );
        
        if ( channel == "spray_landed" )
        {
            player notify( #"hash_ca7c287a05e3874f" );
            return val;
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0x5cd1b59b, Offset: 0xf96b
// Size: 0x36
function spraywatchtimeout( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"hash_ca7c287a05e3874f" );
    wait 5;
    player notify( #"hash_a765734e52168f0d" );
}

// Namespace challenges
// Params 4
// Checksum 0x8f892a31, Offset: 0xf9a9
// Size: 0x4b
function function_fd82c22ff7278c68( player, eventtypebit, perkref, value )
{
    function_f8bdac4d6cc2664f( player, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ), perkref, value );
}

// Namespace challenges
// Params 4
// Checksum 0xc504d2cd, Offset: 0xf9fc
// Size: 0xf2
function function_f8bdac4d6cc2664f( player, eventtypebit, perkref, value )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( value < 0 )
    {
        value = 1;
    }
    
    perkid = 0;
    
    if ( isdefined( perkref ) )
    {
        perkid = loot::getlootidfromref( perkref );
    }
    
    bitfield = 0;
    bitfield = function_a23641f33e985edb( bitfield, eventtypebit );
    aeeventname = #"perk";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = perkid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = bitfield;
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 6
// Checksum 0xc898f86, Offset: 0xfaf6
// Size: 0x1ef
function function_4cfe18f48cc7a55c( player, lootid, type, method, quantity, additionaleventparams )
{
    if ( !player challengesenabledforplayer() )
    {
        return 0;
    }
    
    if ( !isdefined( quantity ) )
    {
        quantity = 1;
    }
    
    aeeventname = #"use_item";
    typeid = 0;
    
    if ( !level.gametypebundle.var_a9664504384d69b6 )
    {
        if ( isdefined( type ) )
        {
            typeid = ae_utility::function_357622cc2d8da787( type );
        }
    }
    
    if ( !isdefined( method ) )
    {
        method = 0;
        method = function_a23641f33e985edb( method, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    }
    
    operatorlootid = player function_6a3bd1af73a5a390() ?? 0;
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = quantity;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"string_ref" ) ] = typeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = method;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval;
        }
    }
    
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
    println( "<dev string:x90d>" );
}

// Namespace challenges
// Params 3
// Checksum 0xc27d01d4, Offset: 0xfced
// Size: 0x6d
function function_ee942a83ee5ecf19( player, quantity, currencytype )
{
    method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"loot" ) );
    currency = function_a23641f33e985edb( 0, currencytype );
    reportlootitemevent( player, undefined, undefined, method, quantity, undefined, currency );
}

// Namespace challenges
// Params 3
// Checksum 0x2b356594, Offset: 0xfd62
// Size: 0x6d
function function_f28537541380c90a( player, quantity, currencytype )
{
    method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"extract" ) );
    currency = function_a23641f33e985edb( 0, currencytype );
    reportlootitemevent( player, undefined, undefined, method, quantity, undefined, currency );
}

// Namespace challenges
// Params 3
// Checksum 0x59e66139, Offset: 0xfdd7
// Size: 0x216
function function_6312496c9756f74e( player, method, items )
{
    params = [];
    aeeventname = #"batch_loot_item";
    function_f4c306eea6673ab0( aeeventname, params );
    params[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_method_bitfield" ) ] = method;
    startid = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_d407dfd49e629129" );
    
    if ( !items && utility::callsharedfunc( #"instanceInventory", #"isenabled" ) )
    {
        var_29220e1d48b1eba = [];
        [ params, var_29220e1d48b1eba ] = utility::callsharedfunc( #"instanceInventory", #"hash_22f8ae7cbaae85d7", player, params, var_29220e1d48b1eba, startid, 1 );
        
        if ( var_29220e1d48b1eba.count > 0 )
        {
            function_f4c306eea6673ab0( aeeventname, var_29220e1d48b1eba );
            var_29220e1d48b1eba[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_method_bitfield" ) ] = method;
            reportchallengeuserserializeddicteventinternal( player, aeeventname, var_29220e1d48b1eba );
        }
    }
    else if ( items && items.size > 0 )
    {
        paramoffset = startid;
        
        foreach ( item in items )
        {
            lootid = common_item::function_6d301ac91c3cd13d( item );
            
            if ( lootid )
            {
                params[ params.size ] = paramoffset;
                params[ params.size ] = lootid;
                quantity = item.count ?? 1;
                
                if ( quantity == 1 )
                {
                    paramoffset += 2;
                    continue;
                }
                
                params[ params.size ] = paramoffset;
                params[ params.size ] = item.count;
                paramoffset += 1;
            }
        }
    }
    
    reportchallengeuserserializeddicteventinternal( player, aeeventname, params );
}

// Namespace challenges
// Params 4
// Checksum 0x7fc87fb5, Offset: 0xfff5
// Size: 0x26e
function function_680e579720fe376( player, items, isextract, var_42b2bad9c94a83ee )
{
    if ( !player challengesenabledforplayer() )
    {
        return 0;
    }
    
    foreach ( inventorygroup in items )
    {
        foreach ( item in inventorygroup )
        {
            bundlename = common_item_database::function_ca9ca606e66b5911( item.scriptable );
            
            if ( !bundlename )
            {
                continue;
            }
            
            var_1d6041e14aeb1bd9 = getscriptbundlefieldvalues( bundlename, [ #"hash_5d243cac1f86e784", #"hash_fcf1b808f5031a7" ] );
            quantity = item.count ?? 1;
            method = undefined;
            
            if ( isextract && isdefined( var_1d6041e14aeb1bd9 ) && var_1d6041e14aeb1bd9.var_b222b8eceaf0ee8f )
            {
                method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"extract" ) );
            }
            else if ( var_42b2bad9c94a83ee && isdefined( var_1d6041e14aeb1bd9 ) && var_1d6041e14aeb1bd9.var_c7f8f54fcdb37b18 )
            {
                method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"starting_loadout" ) );
            }
            
            if ( isdefined( method ) )
            {
                itemtype = common_item::function_3cba34a99d02cd9( bundlename );
                lootid = undefined;
                
                if ( itemtype == "weapon" )
                {
                    lootid = item_weapon::function_b7f484c7dea7dc34( { #weaponobj:item.weaponobj, #type:item.scriptable } );
                }
                else
                {
                    lootid = common_item::function_b01955b20c77371d( bundlename );
                }
                
                reportlootitemevent( player, lootid, undefined, method, quantity );
            }
        }
    }
}

// Namespace challenges
// Params 8
// Checksum 0xe3f05bcf, Offset: 0x1026b
// Size: 0x34a
function reportlootitemevent( player, lootid, type, method, quantity, source, currencytype, additionaleventparams )
{
    if ( !player challengesenabledforplayer() )
    {
        return 0;
    }
    
    typeid = 0;
    loottype = 0;
    
    if ( !level.gametypebundle.var_a9664504384d69b6 )
    {
        if ( isdefined( type ) )
        {
            typeid = ae_utility::function_357622cc2d8da787( type );
        }
        
        if ( isdefined( lootid ) )
        {
            loottype = function_6337cf762d10163f( lootid );
        }
    }
    
    quantity = function_ed6f10a45e5c6af7( lootid, quantity );
    
    if ( typeid < 0 )
    {
        logstring( "IW9-592971: reportLootItemEvent::typeID is negative" );
    }
    
    if ( quantity < 0 )
    {
        logstring( "IW9-592971: reportLootItemEvent::quantity is negative" );
    }
    
    if ( lootid < 0 )
    {
        logstring( "IW9-592971: reportLootItemEvent::lootID is negative" );
    }
    
    if ( isint( method ) && method < 0 )
    {
        logstring( "IW9-592971: reportLootItemEvent::method is negative" );
    }
    
    if ( loottype < 0 )
    {
        logstring( "IW9-592971: reportLootItemEvent::lootType is negative" );
    }
    
    if ( isint( source ) && source < 0 )
    {
        logstring( "IW9-592971: reportLootItemEvent::source is negative" );
    }
    
    var_dcce2b49a9fe4453 = undefined;
    
    if ( isplayer( player ) && isdefined( lootid ) )
    {
        if ( !isdefined( player.var_3d25524e709c717 ) )
        {
            player.var_3d25524e709c717 = [];
        }
        
        if ( !isdefined( player.var_3d25524e709c717[ lootid ] ) )
        {
            player.var_3d25524e709c717[ lootid ] = 0;
        }
        
        player.var_3d25524e709c717[ lootid ]++;
        var_dcce2b49a9fe4453 = player.var_3d25524e709c717[ lootid ];
    }
    
    aeeventname = #"loot_item";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"string_ref" ) ] = typeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = quantity;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_method_bitfield" ) ] = method;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_item_type" ) ] = loottype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_source" ) ] = source;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_5c4314db1b6bb841" ) ] = var_dcce2b49a9fe4453;
    
    if ( ae_utility::function_4b9f0ca95497e0c8( aeeventname, #"currency_type" ) )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"currency_type" ) ] = currencytype;
    }
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval;
        }
    }
    
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
    println( "<dev string:x939>" );
    
    if ( isdefined( level.var_27a966207a504317 ) )
    {
        return [[ level.var_27a966207a504317 ]]( player, lootid, loottype );
    }
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0x812cce28, Offset: 0x105bd
// Size: 0x139
function private function_5d2706100aeaa97( command, bitfield1, bitfield2 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    operatorlootid = function_6a3bd1af73a5a390();
    aeeventname = #"game_flags";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( self, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"game_flags_cmd" ) ] = command;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_4a7f024e87253788" ) ] = bitfield1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_4a7f054e87253ca1" ) ] = bitfield2;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x2918b3b4, Offset: 0x106fe
// Size: 0x4b
function function_b4cc5a958ed78618( userflags, var_2ea68e6cdc92dd5d )
{
    self.var_c057d6667ee257c1 = [];
    self.var_c057d6667ee257c1[ #"game_flags_user" ] = userflags;
    self.var_c057d6667ee257c1[ #"hash_4a7f024e87253788" ] = var_2ea68e6cdc92dd5d;
}

// Namespace challenges
// Params 2
// Checksum 0xd62f1941, Offset: 0x10751
// Size: 0x20
function initgameflags( aeeventname, var_c057d6667ee257c1 )
{
    self.var_c057d6667ee257c1 = var_c057d6667ee257c1;
}

// Namespace challenges
// Params 1
// Checksum 0x3488942, Offset: 0x10779
// Size: 0x42
function function_313d1143e1ab651f( var_3f3f2cbe130b4821 )
{
    switch ( var_3f3f2cbe130b4821 )
    {
        case #"game_flags_user":
            return 1;
        case #"hash_4a7f024e87253788":
            return 1;
        default:
            return 0;
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xecded23d, Offset: 0x107c3
// Size: 0x5a
function private function_ae7ba0d64d0b4161( var_3f3f2cbe130b4821 )
{
    if ( !function_6a93fa9d4176044b() )
    {
        return;
    }
    
    if ( !isdefined( var_3f3f2cbe130b4821 ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_c057d6667ee257c1 ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_c057d6667ee257c1[ var_3f3f2cbe130b4821 ] ) )
    {
        return;
    }
    
    var_a8998f2530dc0a3e = self.var_c057d6667ee257c1[ var_3f3f2cbe130b4821 ];
    return var_a8998f2530dc0a3e;
}

// Namespace challenges
// Params 2, eflags: 0x4
// Checksum 0xd23228ef, Offset: 0x10826
// Size: 0x76
function private function_baf5319b01d89955( var_3f3f2cbe130b4821, flagbits )
{
    if ( !function_6a93fa9d4176044b() )
    {
        return;
    }
    
    if ( !isdefined( var_3f3f2cbe130b4821 ) )
    {
        return;
    }
    
    if ( !isdefined( flagbits ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_c057d6667ee257c1 ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_c057d6667ee257c1[ var_3f3f2cbe130b4821 ] ) )
    {
        return;
    }
    
    if ( var_3f3f2cbe130b4821 == #"game_flags_user" )
    {
        return;
    }
    
    self.var_c057d6667ee257c1[ var_3f3f2cbe130b4821 ] = flagbits;
    function_5d2706100aeaa97();
}

// Namespace challenges
// Params 0
// Checksum 0x8784e657, Offset: 0x108a4
// Size: 0xc, Type: bool
function function_6a93fa9d4176044b()
{
    return isdefined( self.var_c057d6667ee257c1 );
}

// Namespace challenges
// Params 2
// Checksum 0x744ea34e, Offset: 0x108b9
// Size: 0x58, Type: bool
function function_7e5184c2a3117516( var_3f3f2cbe130b4821, gameflag )
{
    var_21dcfe88b9d7e17b = function_ae7ba0d64d0b4161( var_3f3f2cbe130b4821 );
    
    if ( !isdefined( var_21dcfe88b9d7e17b ) )
    {
        return false;
    }
    
    var_a646fd2acefa7ab9 = ae_utility::function_2d1565a236387b2( var_3f3f2cbe130b4821, gameflag );
    
    if ( !isdefined( var_a646fd2acefa7ab9 ) )
    {
        return false;
    }
    
    return ( var_21dcfe88b9d7e17b & 1 << var_a646fd2acefa7ab9 ) != 0;
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0x64358ed8, Offset: 0x1091a
// Size: 0x7e
function private function_865a313f9b9dd9b3( var_3f3f2cbe130b4821, gameflag, enabled )
{
    var_21dcfe88b9d7e17b = function_ae7ba0d64d0b4161( var_3f3f2cbe130b4821 );
    
    if ( !isdefined( var_21dcfe88b9d7e17b ) )
    {
        return 0;
    }
    
    var_a646fd2acefa7ab9 = ae_utility::function_2d1565a236387b2( var_3f3f2cbe130b4821, gameflag );
    
    if ( !isdefined( var_a646fd2acefa7ab9 ) )
    {
        return;
    }
    
    if ( enabled )
    {
        var_21dcfe88b9d7e17b = function_a23641f33e985edb( var_21dcfe88b9d7e17b, var_a646fd2acefa7ab9 );
    }
    else
    {
        var_21dcfe88b9d7e17b = function_656efb67fb2e8058( var_21dcfe88b9d7e17b, var_a646fd2acefa7ab9 );
    }
    
    function_baf5319b01d89955( var_3f3f2cbe130b4821, var_21dcfe88b9d7e17b );
}

// Namespace challenges
// Params 2
// Checksum 0x5ef41e1d, Offset: 0x109a0
// Size: 0x21
function function_8186522f0474f406( var_3f3f2cbe130b4821, gameflag )
{
    function_865a313f9b9dd9b3( var_3f3f2cbe130b4821, gameflag, 1 );
}

// Namespace challenges
// Params 2
// Checksum 0x98d4a913, Offset: 0x109c9
// Size: 0x20
function function_79cc4302a65cff47( var_3f3f2cbe130b4821, gameflag )
{
    function_865a313f9b9dd9b3( var_3f3f2cbe130b4821, gameflag, 0 );
}

// Namespace challenges
// Params 0
// Checksum 0xd3ec5a90, Offset: 0x109f1
// Size: 0x11
function function_f23280f44e3b326b()
{
    function_37e945722d6497f3( self, "complete_blacksite", 1 );
}

// Namespace challenges
// Params 0
// Checksum 0x56352b52, Offset: 0x10a0a
// Size: 0x11
function function_76ad82ed8e7f497()
{
    function_37e945722d6497f3( self, "complete_stronghold", 1 );
}

// Namespace challenges
// Params 0
// Checksum 0x33305d40, Offset: 0x10a23
// Size: 0xa
function onsuccessfulhit()
{
    function_ec451bdd470901cb( self );
}

// Namespace challenges
// Params 2
// Checksum 0x59e4c6e, Offset: 0x10a35
// Size: 0x73
function function_5c810516c9ac1b45( player, var_c7d7ab37de6e1df4 )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"win_challenge_grant_points";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = var_c7d7ab37de6e1df4;
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xe1daeacb, Offset: 0x10ab0
// Size: 0xd8
function function_a9f1fd89647db937( success )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"br_secondary_victory";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"completed" ) ] = istrue( success );
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 0
// Checksum 0x3bb03234, Offset: 0x10b90
// Size: 0xb7
function function_6f7fad05dc16f715()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"br_stronghold_advance";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x54d6e6cb, Offset: 0x10c4f
// Size: 0x9d
function function_6abd79d1a0bdeec9( tradedweapon )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"armory_trader";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    var_a8bfd25f0c9501cf = br_pickups::getweaponpickuprarity( tradedweapon );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"traded_weapon_rarity" ) ] = var_a8bfd25f0c9501cf;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0xfb588ea6, Offset: 0x10cf4
// Size: 0xf0
function function_a692499a9fdb1cd9( player, increment )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    playlistid = getplaylistid();
    aeeventname = #"confirmed_kill";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = playlistid;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 4, eflags: 0x4
// Checksum 0x5be131cd, Offset: 0x10dec
// Size: 0x92
function private reportstat( statname, amount, forcewaitframe, event = undefined )
{
    if ( !isdefined( self.var_dd8852beb9d547dd ) )
    {
        self.var_dd8852beb9d547dd = [];
    }
    
    self.var_dd8852beb9d547dd[ self.var_dd8852beb9d547dd.size ] = { #var_a1b3412aafc713:gettime(), #event:event, #amount:amount, #statname:statname };
    thread function_58c7514d1ffa45e2( forcewaitframe );
}

// Namespace challenges
// Params 1, eflags: 0xc
// Checksum 0x1a767f51, Offset: 0x10e86
// Size: 0x96
function private function_58c7514d1ffa45e2( forcewaitframe )
{
    self notify( #"hash_d51af06f7fa9e80" );
    self endon( #"hash_d51af06f7fa9e80" );
    self endon( #"disconnect" );
    
    if ( level.gametypebundle.var_90d047d626a9a123 == #"slowprocessing" )
    {
        if ( self.var_dd8852beb9d547dd.size < 10 )
        {
            wait 0.5;
        }
    }
    
    function_53df6f352d77bfa7( forcewaitframe );
    profilestart();
    
    if ( !isdefined( self ) )
    {
        profilestop();
        return;
    }
    
    if ( !challengesenabledforplayer() )
    {
        self.var_dd8852beb9d547dd = [];
        profilestop();
        return;
    }
    
    function_a8cdc78c63e5c282();
    profilestop();
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0xf05be473, Offset: 0x10f24
// Size: 0xb1
function private function_a8cdc78c63e5c282()
{
    profilestart();
    
    foreach ( stat in self.var_dd8852beb9d547dd )
    {
        function_ba74d91fc6050fae( stat.statname, stat.amount, stat.event, stat.var_a1b3412aafc713 );
    }
    
    self.var_dd8852beb9d547dd = [];
    profilestop();
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xa8416da6, Offset: 0x10fdd
// Size: 0x48
function private function_3273d371a0078368( statname )
{
    if ( !isdefined( level.var_25800d48e8a8a3c4[ statname ] ) )
    {
        level.var_25800d48e8a8a3c4[ statname ] = getdvarint( hashcat( @"hash_af7cfd1e80e4fb55", statname ), 0 );
    }
    
    return level.var_25800d48e8a8a3c4[ statname ];
}

// Namespace challenges
// Params 4, eflags: 0x4
// Checksum 0xf461e296, Offset: 0x1102e
// Size: 0x3c7
function private function_ba74d91fc6050fae( statname, amount, event, var_a1b3412aafc713 )
{
    profilestart();
    
    if ( ( level.var_25800d48e8a8a3c4[ statname ] ?? function_3273d371a0078368( statname ) ) > 0 )
    {
        profilestop();
        return;
    }
    
    if ( !challengesenabledforplayer() )
    {
        profilestop();
        return;
    }
    
    reportstats = 0;
    damage_amount = 0;
    score_amount = 0;
    
    switch ( statname )
    {
        case #"hash_1cc8a923a608c2a0":
            damage_amount = amount;
            reportstats = 1;
            break;
        case #"hash_2c58990905f03e75":
            score_amount = amount;
            reportstats = 1;
            break;
        case #"hash_7ecdf387b72248b4":
            break;
        case #"hash_93e5b17ba44b4e7b":
            reportstats = 1;
            break;
        case #"hash_8920fadb74036e64":
            break;
        case #"hash_804c8279b22808c2":
            break;
        case #"hash_3440d3368c358eaf":
            break;
        case #"hash_f402bcef661bfd9b":
            break;
        case #"hash_5b0b9aa2fec5584d":
            break;
        case #"hash_e85acef6a699314d":
            break;
        case #"hash_f3cef86f1056f64a":
            break;
        case #"hash_80804c8d4d60b774":
            break;
    }
    
    if ( reportstats )
    {
        var_99e5b5440bda21aa = level.var_2a768cf86c439b4c ?? function_e1f753174eeb4718();
        aeeventname = #"stats";
        
        if ( !isdefined( level.var_7fbd769cf8d23f1a ) )
        {
            level.var_7fbd769cf8d23f1a = { #var_fcd6b3fba1551616:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_a07f188ce7d90cbb" ), #team_size:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"team_size" ), #score:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"score" ), #damage:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"damage" ), #gametype:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ), #gamemode:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ), #version:ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) };
        }
        
        if ( !isdefined( level.var_41fb22d43bf8930e ) )
        {
            level.var_41fb22d43bf8930e = [];
        }
        
        aeeventid = level.var_41fb22d43bf8930e[ aeeventname ];
        
        if ( !isdefined( aeeventid ) )
        {
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
            level.var_41fb22d43bf8930e[ aeeventname ] = aeeventid;
        }
        
        paramkeys = level.var_7fbd769cf8d23f1a;
        var_fcd6b3fba1551616 = 0;
        
        if ( event == #"hash_edc79a0f6782522b" || event == #"hash_ed391fdfbe33ce18" || event == #"hash_f5264961ad715e4f" )
        {
            var_fcd6b3fba1551616 = function_a23641f33e985edb( var_fcd6b3fba1551616, ae_utility::function_2d1565a236387b2( #"hash_a07f188ce7d90cbb", #"hash_634d364cc6360c7f" ) );
        }
        
        eventparams = [];
        eventparams[ paramkeys.version ] = 1;
        eventparams[ paramkeys.gamemode ] = var_99e5b5440bda21aa.gamemode;
        eventparams[ paramkeys.gametype ] = var_99e5b5440bda21aa.gametype;
        eventparams[ paramkeys.damage ] = damage_amount;
        eventparams[ paramkeys.score ] = score_amount;
        eventparams[ paramkeys.team_size ] = var_99e5b5440bda21aa.teamsize;
        eventparams[ paramkeys.var_fcd6b3fba1551616 ] = var_fcd6b3fba1551616;
        
        /#
            function_ee4471f0d17f1d51( aeeventid, eventparams );
        #/
        
        if ( isdefined( var_a1b3412aafc713 ) )
        {
            self function_2e45314624fdfdb8( aeeventid, eventparams, gettime() - var_a1b3412aafc713 );
        }
        else
        {
            self function_2e45314624fdfdb8( aeeventid, eventparams );
        }
    }
    
    profilestop();
}

// Namespace challenges
// Params 0
// Checksum 0xa1a4b2a6, Offset: 0x113fd
// Size: 0x184
function function_dfbecfc4b862a692()
{
    var_d7fdfcde8fad3fc4 = level.gametypebundle.var_d7fdfcde8fad3fc4;
    
    if ( !self.score || !var_d7fdfcde8fad3fc4 || level.var_e1fd4528aac1d956 || !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( self.score >= var_d7fdfcde8fad3fc4 )
    {
        level.var_e1fd4528aac1d956 = 1;
        one_shot_score_events_bitfield = 0;
        one_shot_score_events_bitfield = function_a23641f33e985edb( one_shot_score_events_bitfield, ae_utility::function_2d1565a236387b2( #"hash_184f67783fae7b70", #"hash_5ecd55bf150609c3" ) );
        gamemode = getchallengegamemode();
        gametype = function_9edd00e9e48c0821();
        aeeventname = #"one_shot_score_events";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        eventparams = [];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = getplaylistid();
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"map_name" ) ] = level.var_8d8e247dadcaaae0 ?? function_3a9e91981a8e0c53();
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_184f67783fae7b70" ) ] = one_shot_score_events_bitfield;
        self function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace challenges
// Params 0
// Checksum 0xa21fb816, Offset: 0x11589
// Size: 0xaa
function function_b322b07715ac8992()
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"game_objective_exit";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x3ddf2107, Offset: 0x1163b
// Size: 0x5a
function function_cc68cea76d430189( player, amount )
{
    if ( level.gametypebundle.var_90d047d626a9a123 == #"slowprocessing" )
    {
        player thread reportstat( "damage", amount, 1 );
        return;
    }
    
    player thread function_ba74d91fc6050fae( "damage", amount );
}

// Namespace challenges
// Params 3
// Checksum 0xad51c266, Offset: 0x1169d
// Size: 0x6d
function function_fd33e53ba9311bd4( player, points, event = undefined )
{
    if ( level.gametypebundle.var_90d047d626a9a123 == #"slowprocessing" )
    {
        player thread reportstat( "score", points, undefined, event );
        return;
    }
    
    player thread function_ba74d91fc6050fae( "score", points, event );
}

// Namespace challenges
// Params 1
// Checksum 0x7a9243ff, Offset: 0x11712
// Size: 0xb4
function function_a6d8e0e4dc1af072( params )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    aeeventname = #"bubble_shield_exit";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xeb11ca67, Offset: 0x117ce
// Size: 0x53
function private onplayerconnect( params )
{
    if ( !getdvarint( @"hash_2e40cf82b0bb8fed" ) )
    {
        return;
    }
    
    if ( challengesenabledforplayer() )
    {
        if ( !isdefined( level.var_89fedc7ebd00b7c8 ) )
        {
            level.var_89fedc7ebd00b7c8 = [];
        }
        
        level.var_89fedc7ebd00b7c8[ level.var_89fedc7ebd00b7c8.size ] = self;
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xd42b1d23, Offset: 0x11829
// Size: 0x56
function private onplayerdisconnect( params )
{
    function_53070adaabfdce44();
    
    if ( !getdvarint( @"hash_2e40cf82b0bb8fed" ) )
    {
        return;
    }
    
    thread function_d90cae87925ded51( function_27fcee7af9809e93() );
    
    if ( level.var_89fedc7ebd00b7c8.size )
    {
        level.var_89fedc7ebd00b7c8 = arrayremove( level.var_89fedc7ebd00b7c8, self );
    }
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x8ed07d8e, Offset: 0x11887
// Size: 0x119
function private function_53070adaabfdce44()
{
    player = self;
    
    if ( !level.var_257df25e2dcf0f03 || !level.matchmakingmatch || !level.rankedmatch )
    {
        return;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    endgame_bitfield = 0;
    
    if ( level.gametypebundle.isltm )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"is_ltm" ) );
    }
    
    var_666719f7ceac9425 = getdvarint( @"hash_d5a1ed391dd67630", 0 );
    
    if ( var_666719f7ceac9425 )
    {
        endgame_bitfield = function_a23641f33e985edb( endgame_bitfield, ae_utility::function_2d1565a236387b2( #"hash_8dd9828579063e7", #"cq_active" ) );
    }
    
    aeeventname = #"prematch_match_end";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_8dd9828579063e7" ) ] = endgame_bitfield;
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xa7ed86eb, Offset: 0x119a8
// Size: 0x8d
function private function_cf7e0fbbd1e7f02c( params )
{
    if ( !getdvarint( @"hash_2e40cf82b0bb8fed" ) )
    {
        return;
    }
    
    if ( !level.var_89fedc7ebd00b7c8.size )
    {
        return;
    }
    
    for ( playerindex = level.var_89fedc7ebd00b7c8.size - 1; playerindex >= 0 ; playerindex-- )
    {
        if ( !level.var_89fedc7ebd00b7c8[ playerindex ] )
        {
            continue;
        }
        
        player = level.var_89fedc7ebd00b7c8[ playerindex ];
        player thread function_d90cae87925ded51( player function_27fcee7af9809e93() );
    }
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x9190adda, Offset: 0x11a3d
// Size: 0x1f4
function private function_27fcee7af9809e93()
{
    outstruct = { #var_c50d1dcf3a6b28b0:0, #var_34b723fb5b9376a5:0, #var_c3384eab5293e2b3:0, #var_928e002165b9266:0, #var_74c4e5c924ede948:0, #cumulativescore:0 };
    
    if ( !isdefined( self ) )
    {
        return outstruct;
    }
    
    if ( isdefined( level.sharedfuncs[ #"score" ][ #"hash_a9494f7ac7475784" ] ) )
    {
        outstruct.cumulativescore = [[ level.sharedfuncs[ #"score" ][ #"hash_a9494f7ac7475784" ] ]]( self ) ?? 0;
    }
    
    if ( isdefined( level.sharedfuncs[ #"score" ][ #"hash_511496dd113f1fa1" ] ) )
    {
        outstruct.var_928e002165b9266 = [[ level.sharedfuncs[ #"score" ][ #"hash_511496dd113f1fa1" ] ]]( self ) ?? 0;
    }
    
    if ( isdefined( level.sharedfuncs[ #"score" ][ #"hash_a9ff7e9bcd6dbdfc" ] ) )
    {
        outstruct.var_34b723fb5b9376a5 = [[ level.sharedfuncs[ #"score" ][ #"hash_a9ff7e9bcd6dbdfc" ] ]]( self ) ?? 0;
    }
    
    outstruct.var_74c4e5c924ede948 = outstruct.cumulativescore - ( self.var_b9b80a0fe7b86a3 ?? 0 );
    self.var_b9b80a0fe7b86a3 = outstruct.cumulativescore;
    outstruct.var_c3384eab5293e2b3 = outstruct.var_928e002165b9266 - ( self.var_8d203cbc678e58b6 ?? 0 );
    self.var_8d203cbc678e58b6 = outstruct.var_928e002165b9266;
    outstruct.var_c50d1dcf3a6b28b0 = outstruct.var_34b723fb5b9376a5 - ( self.var_4e5332dea82085db ?? 0 );
    self.var_4e5332dea82085db = outstruct.var_34b723fb5b9376a5;
    return outstruct;
}

// Namespace challenges
// Params 1
// Checksum 0xc9d2be1b, Offset: 0x11c3a
// Size: 0x1e
function onspawn( params )
{
    params.player thread watchplayerunderwater();
}

// Namespace challenges
// Params 1
// Checksum 0xd5199dbe, Offset: 0x11c60
// Size: 0x51
function onplayerspawned( params )
{
    if ( !isdefined( params.player.var_e2386b489c8fa9b0 ) )
    {
        params.player.var_e2386b489c8fa9b0 = 0;
    }
    
    params.player.var_e2386b489c8fa9b0++;
}

// Namespace challenges
// Params 1
// Checksum 0x74340181, Offset: 0x11cb9
// Size: 0x22
function function_a34aef984160a893( deathdata )
{
    deathdata.victim.var_e2386b489c8fa9b0++;
}

// Namespace challenges
// Params 0
// Checksum 0xe51374fa, Offset: 0x11ce3
// Size: 0x6d
function watchplayerunderwater()
{
    player = self;
    player notify( #"watchplayerunderwater" );
    player endon( #"watchplayerunderwater" );
    player endon( #"death_or_disconnect" );
    player endon( #"game_ended" );
    
    while ( true )
    {
        if ( player swim_common::isplayerunderwater() )
        {
            player childthread function_1b9b3fcaeead107f();
        }
        
        player waittill( #"hash_3030751fd4115249" );
    }
}

// Namespace challenges
// Params 0
// Checksum 0xcf948638, Offset: 0x11d58
// Size: 0x2f
function function_1b9b3fcaeead107f()
{
    player = self;
    player endon( #"hash_3030751fd4115249" );
    wait 35;
    function_37e945722d6497f3( player, "underwater_challenge_completed", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x58905f5b, Offset: 0x11d8f
// Size: 0x19e
function findgunsmithattachments( objweapon )
{
    gunsmith_attachments = [];
    
    if ( !isdefined( level.sharedfuncs[ #"weapons" ][ #"hash_50800af75d801869" ] ) || [[ level.sharedfuncs[ #"weapons" ][ #"hash_50800af75d801869" ] ]]( objweapon ) )
    {
        if ( isdefined( objweapon.attachments ) )
        {
            weaponrootname = weapon::getweaponrootname( objweapon );
            var_9b4f7ae23ac4986c = 0;
            
            foreach ( attachment in objweapon.attachments )
            {
                if ( issubstr( attachment, "snprscope" ) )
                {
                    var_9b4f7ae23ac4986c = 1;
                }
                
                if ( isdefined( level.sharedfuncs[ #"weapons" ][ #"hash_35d31d8d23e44a0" ] ) )
                {
                    if ( [[ level.sharedfuncs[ #"weapons" ][ #"hash_35d31d8d23e44a0" ] ]]( objweapon, attachment ) )
                    {
                        gunsmith_attachments[ gunsmith_attachments.size ] = weapon::getattachmentlootid( weaponrootname, attachment );
                    }
                }
            }
            
            if ( var_9b4f7ae23ac4986c )
            {
                gunsmith_attachments[ gunsmith_attachments.size ] = weapon::getattachmentlootid( weaponrootname, "default_sniper_scope" );
            }
        }
    }
    
    for ( attachindex = gunsmith_attachments.size; attachindex < 10 ; attachindex++ )
    {
        gunsmith_attachments[ attachindex ] = 0;
    }
    
    return gunsmith_attachments;
}

// Namespace challenges
// Params 1
// Checksum 0x952c6b43, Offset: 0x11f36
// Size: 0x3b
function onvehicleoutoffuel( params )
{
    player = params.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    function_37e945722d6497f3( player, "gas_drain", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0xe21fee05, Offset: 0x11f79
// Size: 0x3d
function function_709c656f19357131( params )
{
    player = params.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    function_37e945722d6497f3( player, "dmz_deploy_dynamic_ops", 1, 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x484d8939, Offset: 0x11fbe
// Size: 0xa3
function onuavtowerused( params )
{
    player = params.player;
    instance = params.instance;
    
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    index = instance.identifier;
    
    if ( !isdefined( player.var_6a62f989d1c4683b ) )
    {
        player.var_6a62f989d1c4683b = [];
    }
    
    if ( !player.var_6a62f989d1c4683b[ index ] )
    {
        function_37e945722d6497f3( player, "uav_tower", 1 );
        player.var_6a62f989d1c4683b[ index ] = 1;
    }
}

// Namespace challenges
// Params 1
// Checksum 0x5203c046, Offset: 0x12069
// Size: 0xc9
function function_1e78b9d91bf1d271( params )
{
    player = params.player;
    
    if ( !player.team )
    {
        assert( 0, "<dev string:x967>" + "<dev string:x9a6>" );
        return;
    }
    
    poisvisited = teams::getteamdata( player.team, "poisVisited" );
    poi = params.poi;
    
    if ( !isdefined( poisvisited[ poi ] ) )
    {
        function_37e945722d6497f3( player, "poi_travel", 1 );
        poisvisited[ poi ] = 1;
        teams::setteamdata( player.team, "poisVisited", poisvisited );
        player.var_c0f99e46094dea7a = gettime() / 1000;
    }
}

// Namespace challenges
// Params 1
// Checksum 0xecd90232, Offset: 0x1213a
// Size: 0xc
function function_4fac60d6b8d8497e( params )
{
    
}

// Namespace challenges
// Params 1
// Checksum 0x22c22937, Offset: 0x1214e
// Size: 0x151
function onrequestteamassimilate( params )
{
    player = params.player;
    validplayers = params.validplayers;
    
    if ( !isdefined( level.var_7a1fcb44d17b629 ) )
    {
        level.var_7a1fcb44d17b629 = [];
    }
    
    if ( !isdefined( level.var_7a1fcb44d17b629[ player.guid ] ) )
    {
        level.var_7a1fcb44d17b629[ player.guid ] = [];
    }
    
    foreach ( heardplayer in validplayers )
    {
        if ( !isdefined( heardplayer.guid ) || isdefined( level.var_7a1fcb44d17b629[ player.guid ][ heardplayer.guid ] ) )
        {
            continue;
        }
        
        level.var_7a1fcb44d17b629[ player.guid ][ heardplayer.guid ] = 1;
        function_37e945722d6497f3( player, "request_assimilation", 1 );
    }
}

// Namespace challenges
// Params 1
// Checksum 0x3b409a88, Offset: 0x122a7
// Size: 0xb6
function onopensupplydrop( params )
{
    player = params.player;
    cache = params.cache;
    
    if ( !( isdefined( player ) && isdefined( cache ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    if ( isdefined( cache.used[ player.team ] ) )
    {
        return;
    }
    
    if ( !isdefined( cache.used ) )
    {
        cache.used = [];
    }
    
    cache.used[ player.team ] = 1;
    function_37e945722d6497f3( player, "loot_supply_drop", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x2f451d42, Offset: 0x12365
// Size: 0x1b
function ongascanrefuel( params )
{
    function_37e945722d6497f3( self, "gas_can_refuel", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0xd39381bb, Offset: 0x12388
// Size: 0x61
function function_56fe274ff87ed071( params )
{
    player = params.player;
    vehicle = params.vehicle;
    
    if ( !( isdefined( vehicle ) && isdefined( player ) ) || !isplayer( player ) )
    {
        return;
    }
    
    function_37e945722d6497f3( player, "pop_vehicle_tire", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x5449b143, Offset: 0x123f1
// Size: 0x74
function function_6c06e212d17a83bb( params )
{
    player = params.player;
    isenemy = params.isenemy;
    
    if ( !isenemy )
    {
        return;
    }
    
    minspeed = getdvarfloat( @"hash_e85d50ef5e31422", 10 );
    
    if ( self vehicle_getspeed() < minspeed )
    {
        return;
    }
    
    function_37e945722d6497f3( player, "pop_enemy_player_vehicle_tire", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x47198b15, Offset: 0x1246d
// Size: 0x74
function function_7f031af18c0d80d5( params )
{
    player = params.player;
    isenemy = params.isenemy;
    
    if ( !isenemy )
    {
        return;
    }
    
    minspeed = getdvarfloat( @"hash_e85d50ef5e31422", 10 );
    
    if ( self vehicle_getspeed() < minspeed )
    {
        return;
    }
    
    function_37e945722d6497f3( player, "shatter_enemy_vehicle_window", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x6f818d51, Offset: 0x124e9
// Size: 0x96
function onvehiclesiphoned( params )
{
    player = params.player;
    vehicle = params.vehicle;
    
    if ( !isdefined( vehicle.siphonedby ) )
    {
        vehicle.siphonedby = [];
    }
    
    id = player::getuniqueid();
    
    if ( vehicle.siphonedby[ id ] )
    {
        return;
    }
    
    vehicle.siphonedby[ id ] = 1;
    function_37e945722d6497f3( player, "siphon_gas", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x2648516, Offset: 0x12587
// Size: 0xe3
function function_fdae19e8656d7037( params )
{
    player = params.player;
    door = params.door;
    
    if ( !( isdefined( player ) && isdefined( player.team ) && isdefined( door ) ) )
    {
        return;
    }
    
    if ( !isdefined( door.keyname ) )
    {
        return;
    }
    
    if ( door.keyname == "fortress" )
    {
        function_38bbdf788e1b01d4( player, "unlock_stronghold", 1 );
        return;
    }
    
    if ( !isdefined( level.lockedspacesopened ) )
    {
        level.lockedspacesopened = [];
    }
    
    if ( isdefined( level.lockedspacesopened[ door.keyname ] ) )
    {
        return;
    }
    
    level.lockedspacesopened[ door.keyname ] = 1;
    function_37e945722d6497f3( player, "unlocked_door", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0x58f28dc2, Offset: 0x12672
// Size: 0x17b
function function_5c3667480287d225( params )
{
    players = params.players;
    vehicle = params.vehicle;
    
    foreach ( player in players )
    {
        function_37e945722d6497f3( player, "dmz_vehicle_refueled_at_gas_station", 1 );
        
        if ( vehicle.challengedata && vehicle.challengedata.was_refueled )
        {
            function_37e945722d6497f3( player, "vehicle_refueled", 1 );
            vehicle.challengedata.was_refueled = 0;
        }
        
        if ( vehicle.challengedata && ( vehicle.challengedata.was_repaired || vehicle.challengedata.var_45600ba5c795f8d7 ) )
        {
            function_37e945722d6497f3( player, "vehicle_repaired", 1 );
            vehicle.challengedata.was_repaired = 0;
            vehicle.challengedata.var_45600ba5c795f8d7 = 0;
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0x43806905, Offset: 0x127f5
// Size: 0x33
function function_2bda238d3137cb52( params )
{
    player = params.player;
    function_37e945722d6497f3( player, "dmz_looted_airdrop", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0xe8d011f6, Offset: 0x12830
// Size: 0xc7
function onsquadwiped( params )
{
    attackers = params.attackers;
    attackerteams = [];
    
    foreach ( attacker in attackers )
    {
        if ( !isdefined( attackerteams[ attacker.team ] ) )
        {
            attackerteams[ attacker.team ] = 1;
            function_37e945722d6497f3( attacker, "squad_wipe", 1 );
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0x4756c55a, Offset: 0x128ff
// Size: 0x37
function function_c583b6bd77ec7f99( fortress )
{
    name = fortress.name;
    
    if ( isdefined( name ) )
    {
        return ( "cleared_" + name );
    }
    
    return "";
}

// Namespace challenges
// Params 1
// Checksum 0x8e730883, Offset: 0x1293f
// Size: 0x74
function function_b826e89ae082c296( params )
{
    player = params.player;
    fortress = params.fortress;
    
    if ( ai_fortress::function_c4cc2f9a17167e1b( fortress ) )
    {
        ref = function_c583b6bd77ec7f99( fortress );
        function_37e945722d6497f3( player, ref, 1 );
        return;
    }
    
    function_37e945722d6497f3( player, "clear_stronghold", 1 );
}

// Namespace challenges
// Params 1
// Checksum 0xf6ae5470, Offset: 0x129bb
// Size: 0xc6
function function_1d339a64becbde9b( params )
{
    newteam = params.newteam;
    
    if ( !isdefined( newteam ) )
    {
        return;
    }
    
    playersonteam = teams::getteamdata( newteam, "players" );
    
    if ( playersonteam.size < 4 )
    {
        return;
    }
    
    foreach ( teammate in playersonteam )
    {
        function_37e945722d6497f3( teammate, "complete_assimilation", 1 );
        break;
    }
}

// Namespace challenges
// Params 1
// Checksum 0x8d62de8e, Offset: 0x12a89
// Size: 0x2e2
function function_b023f79a238af6c2( ref )
{
    switch ( ref )
    {
        case #"hash_f4a9126c03d3385b":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"domination" );
        case #"hash_e91729d4ef79ca26":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"geiger_search" );
        case #"hash_75b6db03edb1e84e":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"elimination" );
        case #"hash_82ea0e6e4f123b62":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"trap" );
        case #"hash_e0b82e0f064c17d6":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"hostage" );
        case #"hash_9db32d30f2603c35":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"vehicledrive" );
        case #"hash_37bb23543c319104":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"hunt" );
        case #"hash_1e754eb11fa62651":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"boatdrive" );
        case #"hash_cf3abe09f0094696":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"demolition" );
        case #"hash_c5a5568c914ba427":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"samsite" );
        case #"hash_9682e089e580b4b8":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"safe" );
        case #"hash_7e9cf92ed0a526f1":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"bomb" );
        case #"hash_890e226c519dc6ab":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"person_of_interest" );
        case #"hash_218ddcea32fa5fbc":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"hacker_phone" );
        case #"hash_be386dc37be6968e":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"supply" );
        case #"hash_88570f89de3f4680":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"scav" );
        case #"hash_4f62da1c4ed6f790":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"convoy_attack" );
        case #"hash_5c317bf7b4be6e08":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"convoy_defend" );
        case #"hash_2a58b3d6862b2cdf":
            return ae_utility::function_2d1565a236387b2( #"activity_type", #"train_safe" );
        default:
            return;
    }
}

// Namespace challenges
// Params 1
// Checksum 0x64d6f399, Offset: 0x12d73
// Size: 0x17c
function function_2a24fb223cef78d6( params )
{
    team = params.team;
    activityref = params.activityref;
    iscompletion = params.iscompletion;
    playersonteam = teams::getteamdata( team, "players" );
    
    if ( playersonteam.size == 0 )
    {
        return;
    }
    
    activityindex = function_b023f79a238af6c2( activityref );
    
    if ( !isdefined( activityindex ) )
    {
        return;
    }
    
    activitytype = function_a23641f33e985edb( 0, activityindex );
    
    if ( iscompletion )
    {
        foreach ( player in playersonteam )
        {
            function_918534454a508804( player, activitytype );
        }
        
        return;
    }
    
    foreach ( player in playersonteam )
    {
        function_39b530dd29c848fb( player, activitytype );
    }
}

// Namespace challenges
// Params 1
// Checksum 0x3fdabb01, Offset: 0x12ef7
// Size: 0x65
function onextract( params )
{
    player = params.player;
    
    if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_c0635ebb0978e50c )
    {
        items = player common_inventory_groups::function_4e8ec7c4c3d604e4();
        function_680e579720fe376( player, items, 1 );
    }
}

// Namespace challenges
// Params 1
// Checksum 0xed0afcee, Offset: 0x12f64
// Size: 0x66
function function_c8a2ae95b4786b5f( params )
{
    player = params.player;
    
    if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_7bfee98161b86c51 )
    {
        items = player common_inventory_groups::function_4e8ec7c4c3d604e4();
        function_680e579720fe376( player, items, 0, 1 );
    }
}

// Namespace challenges
// Params 1
// Checksum 0x51bde05d, Offset: 0x12fd2
// Size: 0xb3
function function_a9cc756d803543a5( params )
{
    player = params.player;
    
    if ( params.fromground || isdefined( params.fromgroup ) && !common_inventory_groups::function_bdd40ff62071d8a0( params.fromgroup ) )
    {
        method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"loot" ) );
        lootid = common_item::function_b01955b20c77371d( params.itembundlename );
        reportlootitemevent( player, lootid, undefined, method, params.quantity );
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x6aec036d, Offset: 0x1308d
// Size: 0x108
function private function_f36b4d06a03b16b9( bitfield1 )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    gametype = function_9edd00e9e48c0821();
    operatorlootid = function_6a3bd1af73a5a390();
    aeeventname = #"champions_quest";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    function_93ae9f94893d99e0( self, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_ecf2f40148801ac5" ) ] = bitfield1;
    
    /#
        function_ee4471f0d17f1d51( aeeventid, eventparams );
    #/
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xb25cb7f5, Offset: 0x1319d
// Size: 0x58
function function_cbbd0e7b71fa0d1e( var_7790f1bb82341752 )
{
    var_82a2163fbb84a684 = playerachievements::function_ce48098d17912e1f( self, var_7790f1bb82341752, "progress", 0 );
    logstring( "++++++++++++++++++++++ challenges::initChampionsQuest " + self.name + ", ach id " + var_7790f1bb82341752 + ", progress/tokens " + var_82a2163fbb84a684 );
    self.var_82a2163fbb84a684 = var_82a2163fbb84a684;
}

// Namespace challenges
// Params 0
// Checksum 0xfe1527c9, Offset: 0x131fd
// Size: 0x89
function function_bf3b05129da76942()
{
    if ( !isdefined( self.var_82a2163fbb84a684 ) )
    {
        self.var_82a2163fbb84a684 = 0;
    }
    
    self.var_82a2163fbb84a684 += 1;
    logstring( "++++++++++++++++++++++ challenges::awardChampionsQuestToken " + self.name + ", tokens " + self.var_82a2163fbb84a684 );
    var_6d77c80b83cbac31 = 0;
    var_6d77c80b83cbac31 = function_a23641f33e985edb( var_6d77c80b83cbac31, ae_utility::function_2d1565a236387b2( #"hash_ecf2f40148801ac5", #"token_award" ) );
    function_f36b4d06a03b16b9( var_6d77c80b83cbac31 );
}

// Namespace challenges
// Params 0
// Checksum 0xbe61ed9, Offset: 0x1328e
// Size: 0x89
function function_fd116258fc6dabb()
{
    if ( !isdefined( self.var_82a2163fbb84a684 ) )
    {
        self.var_82a2163fbb84a684 = 0;
    }
    
    self.var_82a2163fbb84a684 += 1;
    logstring( "++++++++++++++++++++++ challenges::refundChampionsQuestToken " + self.name + ", tokens " + self.var_82a2163fbb84a684 );
    refundflag = 0;
    refundflag = function_a23641f33e985edb( refundflag, ae_utility::function_2d1565a236387b2( #"hash_ecf2f40148801ac5", #"token_refund" ) );
    function_f36b4d06a03b16b9( refundflag );
}

// Namespace challenges
// Params 0
// Checksum 0x8b3fb16d, Offset: 0x1331f
// Size: 0x97
function function_c3bb7e398db26f49()
{
    if ( !isdefined( self.var_82a2163fbb84a684 ) )
    {
        self.var_82a2163fbb84a684 = 0;
    }
    
    if ( self.var_82a2163fbb84a684 > 0 )
    {
        self.var_82a2163fbb84a684 -= 1;
        logstring( "++++++++++++++++++++++ challenges::redeemChampionsQuestToken " + self.name + ", tokens " + self.var_82a2163fbb84a684 );
        redeemflag = 0;
        redeemflag = function_a23641f33e985edb( redeemflag, ae_utility::function_2d1565a236387b2( #"hash_ecf2f40148801ac5", #"token_redeem" ) );
        function_f36b4d06a03b16b9( redeemflag );
    }
}

// Namespace challenges
// Params 2
// Checksum 0x44ecec22, Offset: 0x133be
// Size: 0x119
function usedkillstreak( streakname, eventtypebit )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    gametype = function_9edd00e9e48c0821();
    gamemode = getchallengegamemode();
    var_2a8e658c842f2c38 = 0;
    var_2a8e658c842f2c38 = function_a23641f33e985edb( var_2a8e658c842f2c38, eventtypebit );
    killstreak_lootid = loot::getlootidfromref( streakname );
    aeeventname = #"killstreak";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = killstreak_lootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = var_2a8e658c842f2c38;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

/#

    // Namespace challenges
    // Params 0
    // Checksum 0x9bfb3850, Offset: 0x134df
    // Size: 0x4a, Type: dev
    function function_f4a7e95c05084567()
    {
        while ( true )
        {
            wait 0.1;
            
            if ( getdvarint( @"hash_48ae63d778571691", 0 ) )
            {
                continue;
            }
            
            level.var_1043ddee36584561 = 0;
            closefile( level.var_fdb0598462ca980 );
            level.var_fdb0598462ca980 = undefined;
            return;
        }
    }

#/

// Namespace challenges
// Params 0
// Checksum 0x8b905b6c, Offset: 0x13531
// Size: 0x38
function function_95ac1f9f23edbe0c()
{
    aeeventname = #"interactible_item_destroy";
    eventparams = [];
    function_93ae9f94893d99e0( self, eventparams, aeeventname );
    function_271cda783e719559( self, aeeventname, eventparams );
}

// Namespace challenges
// Params 2
// Checksum 0x53f1e5ec, Offset: 0x13571
// Size: 0x245
function function_5111030b13d7c1ca( objweapon, shitloc )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    enemy_type = function_a23641f33e985edb( 0, 5 );
    gamemode = getchallengegamemode();
    playlistid = getplaylistid();
    var_49a734ae41b667b3 = function_a9a45e1ae76e75db( objweapon );
    entities_distance = int( math::round_float( distance( self.origin, shitloc ) / 39.37, 2 ) );
    aeeventname = #"kill";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    gunsmith_attachments = findgunsmithattachments( objweapon );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_22d8c6e760626656" ) ] = enemy_type;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = playlistid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"distance" ) ] = entities_distance;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment1" ) ] = gunsmith_attachments[ 0 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment2" ) ] = gunsmith_attachments[ 1 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment3" ) ] = gunsmith_attachments[ 2 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment4" ) ] = gunsmith_attachments[ 3 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment5" ) ] = gunsmith_attachments[ 4 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment6" ) ] = gunsmith_attachments[ 5 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment7" ) ] = gunsmith_attachments[ 6 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment8" ) ] = gunsmith_attachments[ 7 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment9" ) ] = gunsmith_attachments[ 8 ];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_attachment10" ) ] = gunsmith_attachments[ 9 ];
    println( "<dev string:xa0e>" );
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

/#

    // Namespace challenges
    // Params 7
    // Checksum 0xacda2e69, Offset: 0x137be
    // Size: 0x4f, Type: dev
    function function_3f8e2fd842c5ddac( playerstreak, squadstreak, var_51c49ede4b249ed8, var_17c5649c66076eff, var_22433ad7d7b473b, var_391b55dc66bdd664, takeover )
    {
        println( "<dev string:xa42>" );
    }

    // Namespace challenges
    // Params 3
    // Checksum 0xe8ea1468, Offset: 0x13815
    // Size: 0x2b, Type: dev
    function function_94ff20a74186a43d( squadstreak, var_17c5649c66076eff, var_391b55dc66bdd664 )
    {
        println( "<dev string:xa74>" );
    }

#/

// Namespace challenges
// Params 2
// Checksum 0x2c2866fa, Offset: 0x13848
// Size: 0xa0
function function_49b564bacaa49917( numpulse, numplayersdetected )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = getchallengegamemode();
    playlistid = getplaylistid();
    println( "<dev string:xab0>" );
    event = "720";
    params = [ 8, gamemode, 83, playlistid, 207, numpulse, 208, numplayersdetected ];
    self function_2e45314624fdfdb8( event, params );
}

// Namespace challenges
// Params 4
// Checksum 0x33030a9, Offset: 0x138f0
// Size: 0x86
function function_271cda783e719559( eventplayer, aeeventname, params, var_b263f31ce0e76beb )
{
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    
    if ( !isdefined( aeeventid ) || !isint( aeeventid ) && !isstring( aeeventid ) || !isdefined( params ) )
    {
        /#
            iprintln( "<dev string:xafc>" );
        #/
        
        return;
    }
    
    /#
        function_ee4471f0d17f1d51( aeeventid, params );
    #/
    
    eventplayer reportchallengeuserserializedeventwrapper( aeeventid, params );
}

// Namespace challenges
// Params 2
// Checksum 0xb794e9a1, Offset: 0x1397e
// Size: 0x72d
function function_ee4471f0d17f1d51( event, params )
{
    /#
        if ( !getdvarint( @"hash_48ae63d778571691", 0 ) )
        {
            return;
        }
        
        if ( !isdefined( level.var_1043ddee36584561 ) )
        {
            thread function_f4a7e95c05084567();
            level.var_1043ddee36584561 = 1;
        }
        
        filename = getdvar( @"hash_7276451aeafc2854", "<dev string:xb5e>" );
        activatechallengeid = getdvar( @"hash_4164d219a03096db", "<dev string:xb76>" );
        
        if ( !isdefined( level.var_fdb0598462ca980 ) )
        {
            level.var_2923a2298e9fbf27 = 0;
            level.var_fdb0598462ca980 = openfile( filename, "<dev string:xb7c>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xb82>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xb8e>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xbb1>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xbc0>" + level.var_2923a2298e9fbf27 + "<dev string:xbe7>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xbea>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xc07>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xc17>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xc39>" );
            fprintln( level.var_fdb0598462ca980, "<dev string:xc5b>" + activatechallengeid + "<dev string:xc6e>" );
            level.var_2923a2298e9fbf27 += 1;
            level.var_33e0705e0b3f01fb = [];
            nextrow = -1;
            
            while ( true )
            {
                nextrow += 1;
                
                if ( nextrow >= tablelookupgetnumrows( "<dev string:xc81>" ) )
                {
                    break;
                }
                
                eventkeys = tablelookupbyrow( "<dev string:xc81>", nextrow, 5 );
                
                if ( !isdefined( eventkeys ) || eventkeys == "<dev string:xc97>" )
                {
                    continue;
                }
                
                eventinteger = int( tablelookupbyrow( "<dev string:xc81>", nextrow, 0 ) );
                
                foreach ( keyname in strtok( eventkeys, "<dev string:xc98>" ) )
                {
                    keyinteger = int( tablelookup( "<dev string:xc9a>", 1, keyname, 0 ) );
                    keytype = tablelookup( "<dev string:xc9a>", 1, keyname, 2 );
                    keybitfield = tablelookup( "<dev string:xc9a>", 1, keyname, 3 );
                    level.var_33e0705e0b3f01fb[ eventinteger ][ "<dev string:xcb4>" ][ keyinteger ][ "<dev string:xcb9>" ] = keyname;
                    level.var_33e0705e0b3f01fb[ eventinteger ][ "<dev string:xcb4>" ][ keyinteger ][ "<dev string:xcbe>" ] = keytype;
                    bitfield = [];
                    
                    foreach ( bitpair in strtok( keybitfield, "<dev string:xc98>" ) )
                    {
                        var_a0ebf540d7271d8 = strtok( bitpair, "<dev string:xcc3>" );
                        bitname = var_a0ebf540d7271d8[ 0 ];
                        bitshift = int( var_a0ebf540d7271d8[ 1 ] );
                        bitfield[ bitshift ] = bitname;
                    }
                    
                    level.var_33e0705e0b3f01fb[ eventinteger ][ "<dev string:xcb4>" ][ keyinteger ][ "<dev string:xcc5>" ] = bitfield;
                }
            }
        }
        
        eventstring = tablelookup( "<dev string:xc81>", 0, event, 1 );
        fprintln( level.var_fdb0598462ca980, "<dev string:xc97>" );
        fprintln( level.var_fdb0598462ca980, "<dev string:xb82>" );
        fprintln( level.var_fdb0598462ca980, "<dev string:xcce>" + eventstring );
        fprintln( level.var_fdb0598462ca980, "<dev string:xcde>" + event );
        fprintln( level.var_fdb0598462ca980, "<dev string:xbc0>" + level.var_2923a2298e9fbf27 + "<dev string:xbe7>" );
        fprintln( level.var_fdb0598462ca980, "<dev string:xceb>" + eventstring );
        fprintln( level.var_fdb0598462ca980, "<dev string:xc07>" );
        
        foreach ( key, value in params )
        {
            keystring = "<dev string:xc97>";
            keytype = "<dev string:xc97>";
            keydescription = "<dev string:xc97>";
            
            if ( isdefined( level.var_33e0705e0b3f01fb[ int( event ) ][ "<dev string:xcb4>" ][ key ] ) )
            {
                keydata = level.var_33e0705e0b3f01fb[ int( event ) ][ "<dev string:xcb4>" ][ key ];
                keystring = keydata[ "<dev string:xcb9>" ];
                keytype = keydata[ "<dev string:xcbe>" ];
                keybitfield = keydata[ "<dev string:xcc5>" ];
                
                if ( isdefined( value ) )
                {
                    if ( keytype == "<dev string:xcc5>" )
                    {
                        bitarray = function_2ddc3608d4c7369f( value );
                        
                        for ( n = 0; n < keybitfield.size ; n++ )
                        {
                            if ( !bitarray[ n ] )
                            {
                                continue;
                            }
                            
                            if ( keydescription.size > 0 )
                            {
                                keydescription += "<dev string:xc98>";
                            }
                            
                            keydescription += keybitfield[ n ];
                        }
                        
                        if ( keydescription == "<dev string:xc97>" )
                        {
                            keydescription = "<dev string:xcfb>";
                        }
                        
                        keydescription = "<dev string:xcfd>" + keydescription;
                    }
                    else if ( keystring == "<dev string:xd00>" || keystring == "<dev string:xd0f>" || keystring == "<dev string:xd1f>" )
                    {
                        keydescription = "<dev string:xcfd>" + tablelookup( "<dev string:xd32>", 0, value, 1 );
                    }
                    else if ( keystring == "<dev string:xd4f>" || keystring == "<dev string:xd62>" || keystring == "<dev string:xd6e>" || keystring == "<dev string:xd7e>" )
                    {
                        keydescription = "<dev string:xcfd>" + tablelookup( "<dev string:xd93>", 0, value, 2 ) + "<dev string:xda8>" + tablelookup( "<dev string:xd93>", 0, value, 1 ) + "<dev string:xdab>";
                    }
                }
            }
            else
            {
                keystring = tablelookup( "<dev string:xc9a>", 0, key, 1 ) + "<dev string:xdad>";
            }
            
            comment = "<dev string:xc97>";
            
            if ( !isdefined( value ) )
            {
                comment = "<dev string:xdc2>";
                value = "<dev string:xdc4>";
            }
            
            fprintln( level.var_fdb0598462ca980, "<dev string:xdd0>" + comment + "<dev string:xddd>" + key + "<dev string:xddf>" + value + "<dev string:xde3>" + keystring + "<dev string:xde7>" + keydescription );
        }
        
        fprintln( level.var_fdb0598462ca980, "<dev string:xc97>" );
        level.var_2923a2298e9fbf27 += 1;
    #/
}

// Namespace challenges
// Params 2
// Checksum 0xc66c1a6c, Offset: 0x140b3
// Size: 0x3b
function reportchallengeuserserializedeventwrapper( eventid, params )
{
    if ( level.challengesallowed && isdefined( eventid ) && challengesenabledforplayer() )
    {
        self function_2e45314624fdfdb8( eventid, params );
    }
}

// Namespace challenges
// Params 1
// Checksum 0x2feb4abb, Offset: 0x140f6
// Size: 0x127
function onentervehicle( vehicle )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"vehicle_exit" );
    vehicle endon( #"hash_d6edc10648d757d7" );
    self.var_5d13ef61e862344c = 0;
    self.var_fc6fd8ef2c6feb6b = vehicle getorigin();
    
    for ( var_d64c0313279bc961 = gettime(); true ; var_d64c0313279bc961 = curtime )
    {
        wait 0.5;
        curorigin = vehicle getorigin();
        delta = distance( curorigin, self.var_fc6fd8ef2c6feb6b );
        self.var_5d13ef61e862344c += delta;
        self.var_fc6fd8ef2c6feb6b = curorigin;
        curtime = gettime();
        reportinterval = getdvarint( @"hash_cdb76282cf690ab9" );
        
        if ( curtime - var_d64c0313279bc961 >= reportinterval && self.var_5d13ef61e862344c > 0 )
        {
            function_9798933b210b054c( self, vehicle, self.var_5d13ef61e862344c );
            self.var_5d13ef61e862344c = 0;
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0xca08446e, Offset: 0x14225
// Size: 0x8b
function onexitvehicle( vehicle )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    delta = 0;
    
    if ( isdefined( vehicle ) )
    {
        curorigin = vehicle getorigin();
        delta = distance( curorigin, self.var_fc6fd8ef2c6feb6b );
    }
    
    self.var_5d13ef61e862344c += delta;
    
    if ( self.var_5d13ef61e862344c > 0 )
    {
        function_9798933b210b054c( self, vehicle, self.var_5d13ef61e862344c );
        self.var_5d13ef61e862344c = 0;
    }
}

// Namespace challenges
// Params 3
// Checksum 0xc8f08c25, Offset: 0x142b8
// Size: 0x5b
function function_9798933b210b054c( player, vehicle, var_837a5d335e745ed )
{
    if ( !challengesenabledforplayer() )
    {
        return;
    }
    
    var_adc0155d1bded646 = 0.0254;
    distancemeter = int( math::round_float( var_adc0155d1bded646 * var_837a5d335e745ed, 2 ) );
    
    if ( distancemeter > 0 )
    {
    }
}

// Namespace challenges
// Params 0
// Checksum 0x3636b82, Offset: 0x1431b
// Size: 0x11d
function function_7441802b6039d246()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( isdefined( level.sharedfuncs[ #"gulag" ][ #"hash_dc636254c56e696a" ] ) )
        {
            if ( player [[ level.sharedfuncs[ #"gulag" ][ #"hash_dc636254c56e696a" ] ]]() )
            {
                continue;
            }
        }
        
        if ( !player challengesenabledforplayer() )
        {
            continue;
        }
        
        if ( !flags::gameflag( "br_ready_to_jump" ) )
        {
            continue;
        }
        
        if ( !isdefined( player.var_3e662dc66b9845d ) )
        {
            player.var_3e662dc66b9845d = 0;
        }
        
        player.var_3e662dc66b9845d += 1;
    }
}

// Namespace challenges
// Params 1
// Checksum 0x20784684, Offset: 0x14440
// Size: 0x8c
function set_medal_challenge( medal_name_hash )
{
    if ( !challengesenabled() )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isxhash( medal_name_hash ) )
    {
        assertmsg( "<dev string:xde9>" );
        return;
    }
    
    if ( !isdefined( self.medal_challenges ) )
    {
        self.medal_challenges = [];
    }
    
    if ( !isdefined( self.medal_challenges[ medal_name_hash ] ) )
    {
        self.medal_challenges[ medal_name_hash ] = 0;
    }
    
    self.medal_challenges[ medal_name_hash ] += int( 1 );
}

// Namespace challenges
// Params 1
// Checksum 0xa5579dae, Offset: 0x144d4
// Size: 0x78
function function_1b9535068b88ec7e( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"hash_50e6c1a5e84bd764";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x9ce83704, Offset: 0x14554
// Size: 0x78
function function_5c77e5a42636de6( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"shock_player_zapped";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 3
// Checksum 0xc0939257, Offset: 0x145d4
// Size: 0xb6
function function_ed57a973bf4fe0fc( player, count, seconds )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"hash_c24183862494aa9b";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = count;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value_0" ) ] = seconds;
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x89255037, Offset: 0x14692
// Size: 0x78
function function_4a612752c982452d( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"frontline_invincible";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xa3da61f1, Offset: 0x14712
// Size: 0x78
function function_3f862695ea4a72d0( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"frontline_annihilation";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x24e488f9, Offset: 0x14792
// Size: 0x78
function front_reportkillstreakmultikill( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"frontline_killstreaks";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x286dfafa, Offset: 0x14812
// Size: 0x78
function function_606d7368953e226b( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"hash_bd6850a89fb250ff";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0xca3aad15, Offset: 0x14892
// Size: 0x78
function function_ec32732c1716a384( player )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    aeeventname = #"hash_ab03280a87857e10";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 3
// Checksum 0xa47565ee, Offset: 0x14912
// Size: 0xe8
function function_a5855417fbf48c62( player, actionindex, param )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    actionbitfield = 0;
    actionbitfield = function_a23641f33e985edb( actionbitfield, actionindex );
    var_cce55fce39c3f608 = 0;
    
    if ( isdefined( param ) )
    {
        var_cce55fce39c3f608 = function_a23641f33e985edb( var_cce55fce39c3f608, param );
    }
    
    aeeventname = #"hash_d7f13f0f473d8d2c";
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"event_action_index" ) ] = actionbitfield;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"event_action_param_bitfield" ) ] = var_cce55fce39c3f608;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = function_9edd00e9e48c0821();
    function_271cda783e719559( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 1
// Checksum 0x91be000d, Offset: 0x14a02
// Size: 0x8d
function function_21b5f21603591966( player )
{
    if ( getdvarint( @"hash_3dff092bcdda4c75", 1 ) != 0 )
    {
        gamemode = getchallengegamemode();
        
        if ( !getdvarint( @"hash_bd29bd0b9e202679", 0 ) && !function_a827305d0f204d0e( gamemode ) )
        {
            logstring( "challenges::reportLeaderboardEventsEnrollEvent(): no active leaderboard event, don't send enroll event" );
            return;
        }
        
        aeeventname = #"hash_ce9c12757eacebfd";
        eventparams = [];
        function_f4c306eea6673ab0( aeeventname, eventparams );
        function_271cda783e719559( player, aeeventname, eventparams );
    }
}

// Namespace challenges
// Params 2
// Checksum 0xee322a70, Offset: 0x14a97
// Size: 0x6d
function function_f964e38c28c1e64b( player, matchresult )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    eventparams = [];
    aeeventname = #"br_round_end";
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"match_result" ) ] = matchresult;
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

// Namespace challenges
// Params 3
// Checksum 0x11fa98de, Offset: 0x14b0c
// Size: 0x99
function function_fbb52a28f31c6fd0( player, roundresult, var_fade070058a74a6f )
{
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    eventparams = [];
    aeeventname = #"mp_round_end";
    
    if ( !ae_utility::function_8645a430dc4bffb9( aeeventname ) )
    {
        return;
    }
    
    function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"match_result" ) ] = roundresult;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f6773e0d9305962e" ) ] = var_fade070058a74a6f;
    reportchallengeuserserializeddicteventinternal( player, aeeventname, eventparams );
}

/#

    // Namespace challenges
    // Params 1
    // Checksum 0x7fb3365b, Offset: 0x14bad
    // Size: 0x9a, Type: dev
    function function_26ef1cb49afeb946( args )
    {
        itemtype = args[ 0 ];
        
        foreach ( player in level.players )
        {
            function_37e945722d6497f3( player, itemtype, 1, 1 );
        }
    }

    // Namespace challenges
    // Params 2
    // Checksum 0xc978a62, Offset: 0x14c4f
    // Size: 0x49, Type: dev
    function debugchallenge( command, args )
    {
        switch ( command )
        {
            case #"hash_d25e77d47ed62681":
                function_26ef1cb49afeb946( args );
                break;
            default:
                break;
        }
    }

#/

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xc7d45a91, Offset: 0x14ca0
// Size: 0x77
function private function_60129a10c37d5c5( params )
{
    player = params.player;
    masktype = params.masktype;
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( isdefined( masktype ) )
    {
        function_37e945722d6497f3( player, "dmz_" + masktype + "_gasmask_equipped", 1 );
        return;
    }
    
    function_37e945722d6497f3( player, "dmz_generic_gasmask_equipped", 1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xb6eb9666, Offset: 0x14d1f
// Size: 0xbe
function private function_46cac71384f3e55e( params )
{
    players = params.attackers;
    
    if ( !isdefined( players ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        player = player.attackerent;
        
        if ( !player challengesenabledforplayer() )
        {
            continue;
        }
        
        function_37e945722d6497f3( player, "dmz_agent_dropped_gas_mask", 1 );
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xc6cd5ab9, Offset: 0x14de5
// Size: 0x7c0
function private function_a0a78ce46ff39e07( params )
{
    attacker = params.attacker;
    victim = params.victim;
    equipmentent = params.equipmentent;
    equipmentref = params.equipmentref;
    effectref = params.effectref;
    var_32eda36c3bdd3a6a = params.var_32eda36c3bdd3a6a ?? 0;
    
    if ( !isdefined( attacker ) || attacker == victim || !isdefined( equipmentref ) || !isdefined( effectref ) )
    {
        return;
    }
    
    if ( victim )
    {
        if ( !isdefined( victim.challengedata ) )
        {
            victim.challengedata = {};
        }
        
        if ( !isdefined( victim.challengedata.bitmodifiers ) )
        {
            victim.challengedata.bitmodifiers = [];
        }
        
        victim.challengedata.var_1d37af6e89904fb6 = equipmentref;
        victim.challengedata.var_14c15a6f3f57eae6 = equipmentent;
        victim.challengedata.var_da37af497838d1a8 = gettime();
        victim.challengedata.var_a7ea7e51edad6018 = attacker;
    }
    
    switch ( effectref )
    {
        case #"hash_2d05cb0816458820":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"flashed" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"flashed" ] );
            }
            
            break;
        case #"hash_36fc7b43e7ac2f84":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"stunned" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"stunned" ] );
            }
            
            break;
        case #"hash_7fa51eb5aa5f9168":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"shocked" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"shocked" ] );
            }
            
            break;
        case #"hash_a55192111b5cfba6":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"smoked" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"smoked" ] );
            }
            
            break;
        case #"hash_1b779e48097aafee":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"pulsed" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"pulsed" ] );
            }
            
            break;
        case #"hash_ce06266978fd636":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_9950c6e9426a3796" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"hash_9950c6e9426a3796" ] );
            }
        case #"hash_73c4af18a720fb5b":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"disoriented" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"disoriented" ] );
            }
            
            break;
        case #"hash_b478d5a3df8870a6":
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"bamboozled" ) );
            
            if ( victim )
            {
                victim.challengedata.bitmodifiers = arraycombineunique( victim.challengedata.bitmodifiers, [ #"bamboozled" ] );
            }
            
            break;
        default:
            return;
    }
    
    bundle = level.equipment.table[ equipmentref ].bundle;
    
    if ( isdefined( bundle ) )
    {
        if ( bundle.var_4b1f9bf5abd1ea92 > 0 )
        {
            if ( !isdefined( equipmentent.challengedata ) )
            {
                equipmentent.challengedata = {};
            }
            
            if ( !isdefined( equipmentent.challengedata.victim_map ) )
            {
                equipmentent.challengedata.victim_map = [];
            }
            
            if ( isdefined( equipmentent.challengedata.victim_map ) && victim )
            {
                equipmentent.challengedata.victim_map = arraycombineunique( equipmentent.challengedata.victim_map, [ victim.guid ] );
            }
            
            if ( equipmentent.challengedata.victim_map.size >= bundle.var_4b1f9bf5abd1ea92 )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"multi_hit" ) );
            }
        }
    }
    
    if ( equipmentent.challengedata.bitmodifiers )
    {
        foreach ( modifier in equipmentent.challengedata.bitmodifiers )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", modifier ) );
        }
    }
    
    angle = function_e9cda8d1c50b72e9( equipmentent );
    
    if ( angle == "wall" )
    {
        var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_b140d3b7a1a7d172" ) );
    }
    else if ( angle == "ceiling" )
    {
        var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_1bb5a2538d5ba0b9" ) );
    }
    else if ( angle == "floor" )
    {
        var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_710003afb12e9fa4" ) );
    }
    
    if ( effectref )
    {
        var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_f44b964c87719d9a" ) );
    }
    
    function_3d7a169dbae062fb( equipmentref, attacker, undefined, undefined, undefined, 0, var_32eda36c3bdd3a6a, victim );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x9e7a32f2, Offset: 0x155ad
// Size: 0x1aa
function private function_852de430774c0908( params )
{
    victim = params.player;
    attacker = params.trigger.owner;
    equipmentent = params.trigger.equipmentent;
    equipmentref = %"equip_smoke";
    effectref = "smoked";
    var_32eda36c3bdd3a6a = params.var_32eda36c3bdd3a6a ?? 0;
    
    if ( !isdefined( attacker ) || attacker == victim || !isdefined( equipmentref ) || !isdefined( effectref ) )
    {
        return;
    }
    
    if ( equipmentent.challengedata.bitmodifiers )
    {
        foreach ( modifier in equipmentent.challengedata.bitmodifiers )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", modifier ) );
        }
    }
    
    if ( victim.exitedsmoke )
    {
        var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"exited_smoke" ) );
    }
    
    function_3d7a169dbae062fb( equipmentref, attacker, undefined, undefined, undefined, 0, var_32eda36c3bdd3a6a, victim );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xa6f5832a, Offset: 0x1575f
// Size: 0x513
function private function_6dbcd6a03cc2995( params )
{
    attacker = params.eattacker;
    inflictor = params.einflictor;
    objweapon = params.objweapon;
    damage = params.idamage ?? 0;
    meansofdeath = params.smeansofdeath;
    victim = params.victim;
    
    if ( !isdefined( attacker ) || attacker == victim || !isdefined( inflictor ) )
    {
        return;
    }
    
    equipmentref = inflictor.var_aaeb245b57a6cf86;
    
    if ( !isdefined( equipmentref ) && isdefined( objweapon ) )
    {
        refcandidate = equipment_mp::getequipmentreffromweapon( objweapon );
        
        if ( isdefined( refcandidate ) )
        {
            equipmentref = refcandidate;
            inflictor.var_aaeb245b57a6cf86 = equipmentref;
        }
    }
    
    if ( !isdefined( equipmentref ) )
    {
        return;
    }
    
    if ( !attacker challengesenabledforplayer() )
    {
        return;
    }
    
    var_23d620b078fa9ffc = 0;
    profilestart();
    
    if ( !isdefined( inflictor.challengeonce ) )
    {
        inflictor.challengeonce = { #victimmap:[] };
    }
    
    entry = inflictor.challengeonce.victimmap[ victim.guid ];
    
    if ( !isdefined( entry ) )
    {
        entry = { #totaldamage:0, #firstreported:0 };
        inflictor.challengeonce.victimmap[ victim.guid ] = entry;
        var_23d620b078fa9ffc = 1;
    }
    
    entry.totaldamage += damage;
    profilestop();
    var_32eda36c3bdd3a6a = 0;
    
    if ( var_23d620b078fa9ffc && !entry.firstreported )
    {
        if ( isdefined( inflictor ) )
        {
            if ( inflictor.threwback )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_a371d1680af62647" ) );
            }
            
            if ( inflictor.iscooked )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"cooked_damage" ) );
            }
            
            if ( !inflictor.planted && inflictor.exploding )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"airburst_damage" ) );
            }
        }
        
        if ( isdefined( meansofdeath ) )
        {
            switch ( meansofdeath )
            {
                case #"hash_b1078ff213fddba6":
                    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"damagetype_impact" ) );
                    break;
                case #"hash_a911a1880d996edb":
                    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"damagetype_explosive" ) );
                    break;
                case #"hash_c22b13f81bed11f0":
                    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_7e2ecae8f7b73a45" ) );
                    break;
                default:
                    break;
            }
        }
        
        if ( game_utility_mp::isassaulting( attacker ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_53dec980106ee2da" ) );
        }
        
        if ( game_utility_mp::isdefending( attacker ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_ed48614235dc4119" ) );
        }
        
        if ( isplayer( victim ) )
        {
            if ( game_utility_mp::isassaulting( victim ) )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_152b4d4543408017" ) );
            }
            
            if ( game_utility_mp::isdefending( victim ) )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_bbb412c288eab06" ) );
            }
            
            if ( gameobjects_common::function_8ca4dd777670917b( victim ) )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_51fab00f9e75779a" ) );
            }
        }
        
        var_d38d244f01558df8 = isinsight( attacker, inflictor );
        
        if ( !var_d38d244f01558df8 )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"out_of_sight" ) );
        }
        
        if ( function_642aea422786e72f( inflictor ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_3efc1d2bbea2609d" ) );
        }
        
        if ( function_21f89245c36f1704( inflictor ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_9989407564cb2f27" ) );
        }
        
        function_3d7a169dbae062fb( equipmentref, attacker, undefined, undefined, damage, 0, var_32eda36c3bdd3a6a, victim );
        inflictor.challengeonce.victimmap[ victim.guid ].firstreported = 1;
        return;
    }
    
    function_3d7a169dbae062fb( equipmentref, attacker, undefined, undefined, damage, 0, 0, victim );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x919f4cec, Offset: 0x15c7a
// Size: 0x456
function private function_56741bf9f7e6cf94( params )
{
    attacker = params.attacker;
    victim = params.victim;
    fieldupgraderef = params.fieldupgraderef;
    fieldupgradeent = params.fieldupgradeent;
    value = params.value ?? 1;
    var_9755e6d557d8a5d3 = params.var_9755e6d557d8a5d3 ?? 0;
    var_f2e9694e4b4b52ee = params.var_f2e9694e4b4b52ee ?? 0;
    eventtype = params.eventtype ?? ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" );
    function_4fd386d590e901d8( fieldupgradeent, #"hash_c50cf868c6994df3", #"hit_target" );
    
    if ( !attacker challengesenabledforplayer() || !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) || attacker == victim || !isdefined( fieldupgraderef ) )
    {
        return;
    }
    
    if ( !isdefined( victim.challengedata ) )
    {
        victim.challengedata = {};
    }
    
    if ( !isdefined( victim.challengedata.bitmodifiers ) )
    {
        victim.challengedata.bitmodifiers = [];
    }
    
    victim.challengedata.var_43929b8ce92ac01b = fieldupgraderef;
    victim.challengedata.var_9150288dddd4774f = fieldupgradeent;
    victim.challengedata.var_a66cc96ea491bef3 = gettime();
    victim.challengedata.var_f61180b90c8c088d = attacker;
    fieldupgradeid = 0;
    fieldupgradeid = loot::getlootidfromref( fieldupgraderef );
    
    /#
        if ( !isdefined( fieldupgradeid ) || fieldupgradeid == 0 )
        {
            println( "<dev string:x893>" + fieldupgraderef + "<dev string:x7e3>" );
        }
    #/
    
    attackerloadoutperks = attacker getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( attackerloadoutperks );
    aeeventname = #"field_upgrade";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( attacker, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = fieldupgradeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = eventtype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"steal" ) ] = var_9755e6d557d8a5d3;
    
    if ( fieldupgradeent.challengedata.var_df779c91e88a795c )
    {
        foreach ( var_287b59528920243d, var_df779c91e88a795c in fieldupgradeent.challengedata.var_df779c91e88a795c )
        {
            var_3b4c7057fe11076c = 0;
            
            foreach ( bit in var_df779c91e88a795c )
            {
                var_3b4c7057fe11076c = function_a23641f33e985edb( var_3b4c7057fe11076c, ae_utility::function_2d1565a236387b2( var_287b59528920243d, bit ) );
            }
            
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, var_287b59528920243d ) ] = var_3b4c7057fe11076c;
        }
    }
    
    if ( isdefined( victim.lootid ) )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"victim_loot_id" ) ] = victim.lootid ?? 0;
    }
    
    fieldupgradeent.challengedata.var_df779c91e88a795c = [];
    reportchallengeuserserializeddicteventinternal( attacker, aeeventname, eventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x2c27c88, Offset: 0x160d8
// Size: 0x35b
function private function_91abe0d8db7d5339( params )
{
    player_respawning = params.player_respawning;
    fieldupgraderef = params.fieldupgraderef;
    fieldupgradeent = params.fieldupgradeent;
    value = params.value ?? 1;
    var_9755e6d557d8a5d3 = params.var_9755e6d557d8a5d3 ?? 0;
    var_f2e9694e4b4b52ee = params.var_f2e9694e4b4b52ee ?? 0;
    eventtype = params.eventtype ?? ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" );
    
    if ( !player_respawning challengesenabledforplayer() || !isplayer( player_respawning ) )
    {
        return;
    }
    
    if ( !isdefined( player_respawning ) || !isdefined( fieldupgraderef ) )
    {
        return;
    }
    
    if ( !isdefined( player_respawning.challengedata ) )
    {
        player_respawning.challengedata = {};
    }
    
    if ( !isdefined( player_respawning.challengedata.bitmodifiers ) )
    {
        player_respawning.challengedata.bitmodifiers = [];
    }
    
    player_respawning.challengedata.var_c141459273c22c62 = fieldupgraderef;
    player_respawning.challengedata.var_73dc98917f7b2e9a = fieldupgradeent;
    player_respawning.challengedata.var_ced23b8b6514a264 = gettime();
    fieldupgradeid = 0;
    fieldupgradeid = loot::getlootidfromref( fieldupgraderef );
    
    /#
        if ( !isdefined( fieldupgradeid ) || fieldupgradeid == 0 )
        {
            println( "<dev string:x893>" + fieldupgraderef + "<dev string:x7e3>" );
        }
    #/
    
    var_ae78950a2fe4a894 = player_respawning getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( var_ae78950a2fe4a894 );
    aeeventname = #"field_upgrade";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( player_respawning, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = fieldupgradeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = eventtype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"steal" ) ] = var_9755e6d557d8a5d3;
    
    if ( fieldupgradeent.challengedata.bitmodifiers )
    {
        foreach ( modifier in fieldupgradeent.challengedata.bitmodifiers )
        {
            var_f2e9694e4b4b52ee = function_a23641f33e985edb( var_f2e9694e4b4b52ee, ae_utility::function_2d1565a236387b2( #"hash_c50cf868c6994df3", modifier ) );
        }
    }
    
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_c50cf868c6994df3" ) ] = var_f2e9694e4b4b52ee;
    reportchallengeuserserializeddicteventinternal( player_respawning, aeeventname, eventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xb77a018d, Offset: 0x1643b
// Size: 0x401
function private function_f3ffc3fa6aa3a992( params )
{
    fieldupgradeowner = params.fieldupgradeowner;
    fieldupgraderef = params.fieldupgraderef;
    fieldupgradeent = params.fieldupgradeent;
    value = params.value ?? 1;
    var_9755e6d557d8a5d3 = params.var_9755e6d557d8a5d3 ?? 0;
    eventtype = params.eventtype ?? ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" );
    
    if ( !fieldupgradeowner challengesenabledforplayer() || !isplayer( fieldupgradeowner ) || !isdefined( fieldupgraderef ) )
    {
        return;
    }
    
    if ( !fieldupgradeowner.challengedata.var_4be7ad89b5be7807 || fieldupgradeowner.challengedata.var_4be7ad89b5be7807 != fieldupgraderef )
    {
        return;
    }
    else
    {
        fieldupgradeowner.challengedata.var_4be7ad89b5be7807 = undefined;
    }
    
    if ( !isdefined( fieldupgradeowner.challengedata ) )
    {
        fieldupgradeowner.challengedata = {};
    }
    
    if ( !isdefined( fieldupgradeowner.challengedata.bitmodifiers ) )
    {
        fieldupgradeowner.challengedata.bitmodifiers = [];
    }
    
    fieldupgradeowner.challengedata.var_ef3411eb535d2b8d = fieldupgraderef;
    fieldupgradeowner.challengedata.var_7ffeec1ad5ffa5 = fieldupgradeent;
    fieldupgradeowner.challengedata.var_ed04acb99f0a7589 = gettime();
    fieldupgradeid = 0;
    fieldupgradeid = loot::getlootidfromref( fieldupgraderef );
    
    /#
        if ( !isdefined( fieldupgradeid ) || fieldupgradeid == 0 )
        {
            println( "<dev string:x893>" + fieldupgraderef + "<dev string:x7e3>" );
        }
    #/
    
    var_bd2839c6f55f99b3 = fieldupgradeowner getloadoutperks();
    var_86c674a64c35ed94 = function_526f9ed44fd5b893( var_bd2839c6f55f99b3 );
    aeeventname = #"field_upgrade";
    eventparams = [];
    function_f4c306eea6673ab0( aeeventname, eventparams );
    function_93ae9f94893d99e0( fieldupgradeowner, eventparams, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = value;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = fieldupgradeid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loadout_item_method" ) ] = eventtype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_bd518e95df4103fe" ) ] = var_86c674a64c35ed94.var_ec7be02dd7cc6d7d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"steal" ) ] = var_9755e6d557d8a5d3;
    
    if ( fieldupgradeent.challengedata.var_df779c91e88a795c )
    {
        foreach ( var_287b59528920243d, var_df779c91e88a795c in fieldupgradeent.challengedata.var_df779c91e88a795c )
        {
            var_3b4c7057fe11076c = 0;
            
            foreach ( bit in var_df779c91e88a795c )
            {
                var_3b4c7057fe11076c = function_a23641f33e985edb( var_3b4c7057fe11076c, ae_utility::function_2d1565a236387b2( var_287b59528920243d, bit ) );
            }
            
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, var_287b59528920243d ) ] = var_3b4c7057fe11076c;
        }
    }
    
    fieldupgradeent.challengedata.var_df779c91e88a795c = [];
    reportchallengeuserserializeddicteventinternal( fieldupgradeowner, aeeventname, eventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xea813094, Offset: 0x16844
// Size: 0xc6, Type: bool
function private function_642aea422786e72f( equipment )
{
    if ( level.objectives )
    {
        foreach ( zone in level.objectives )
        {
            if ( !( zone.type_hash == #"gameobject_type_capture_zone" ) )
            {
                continue;
            }
            
            if ( isdefined( equipment ) && equipment istouching( zone.trigger ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace challenges
// Params 2, eflags: 0x4
// Checksum 0xe9cf3409, Offset: 0x16913
// Size: 0x162
function private isinsight( player, target )
{
    if ( !isplayer( player ) || !isdefined( target ) )
    {
        return;
    }
    
    playertacpoints = function_a034a927128ada11( player.origin, 50, 0 );
    targettacpoints = function_a034a927128ada11( target.origin, 50, 0 );
    
    if ( !isdefined( playertacpoints ) || playertacpoints.size == 0 )
    {
        return;
    }
    
    foreach ( playertacpoint in playertacpoints )
    {
        foreach ( targettacpoint in targettacpoints )
        {
            if ( hastacvis( playertacpoint.origin, targettacpoint.origin ) )
            {
                return 1;
            }
        }
    }
    
    return 0;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xea8e3703, Offset: 0x16a7e
// Size: 0x367
function private function_749d24e2330d50e8( params )
{
    attacker = params.attacker;
    equipmentref = params.equipmentref;
    challengeref = params.challengeref;
    var_d9d43b607fa88e1b = params.linkdata;
    
    if ( !isdefined( attacker ) || !attacker challengesenabledforplayer() || !isdefined( equipmentref ) || !isdefined( challengeref ) )
    {
        return;
    }
    
    var_32eda36c3bdd3a6a = 0;
    
    if ( challengeref == "tangled" )
    {
        var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"tripwire_tangled" ) );
    }
    
    if ( challengeref == "connected" && !var_d9d43b607fa88e1b.var_4d60ed1379d05125.var_5461e8ad3253eead && !var_d9d43b607fa88e1b.var_4d60ea1379d04a8c.var_5461e8ad3253eead )
    {
        connections = params.connections;
        
        if ( connections > 1 )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_37ebcb11b584946b" ) );
            
            if ( var_d9d43b607fa88e1b.var_4d60ea1379d04a8c.owner != attacker || var_d9d43b607fa88e1b.var_4d60ea1379d04a8c.owner != attacker )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_80353f6da59809f4" ) );
            }
        }
        
        if ( function_642aea422786e72f( self ) || function_642aea422786e72f( var_d9d43b607fa88e1b.linktrigger ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_3efc1d2bbea2609d" ) );
        }
        
        wireorientation = function_7cb27abdac78250c( var_d9d43b607fa88e1b.var_4d60ed1379d05125.origin, var_d9d43b607fa88e1b.var_4d60ea1379d04a8c.origin );
        var_1a7f4a7eaf870222 = function_e9cda8d1c50b72e9( var_d9d43b607fa88e1b.var_4d60ed1379d05125 );
        var_11694d7bcb36f0dd = function_e9cda8d1c50b72e9( var_d9d43b607fa88e1b.var_4d60ea1379d04a8c );
        var_c0a4a0ac0b9ff6fa = var_d9d43b607fa88e1b.var_4d60ed1379d05125 getlinkedparent();
        var_c0a49fac0b9ff4c7 = var_d9d43b607fa88e1b.var_4d60ea1379d04a8c getlinkedparent();
        
        if ( !isdefined( var_c0a4a0ac0b9ff6fa ) && !isdefined( var_c0a49fac0b9ff4c7 ) )
        {
            if ( var_1a7f4a7eaf870222 == "wall" && var_11694d7bcb36f0dd == "wall" )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_da7d181893f99e92" ) );
            }
            
            if ( ( var_1a7f4a7eaf870222 == "ceiling" && var_11694d7bcb36f0dd == "floor" || var_1a7f4a7eaf870222 == "floor" && var_11694d7bcb36f0dd == "ceiling" ) && wireorientation == "vertical" )
            {
                var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_76f838970dd4c017" ) );
            }
        }
        
        var_d9d43b607fa88e1b.var_4d60ed1379d05125.var_5461e8ad3253eead = 1;
        var_d9d43b607fa88e1b.var_4d60ea1379d04a8c.var_5461e8ad3253eead = 1;
    }
    
    if ( var_32eda36c3bdd3a6a == 0 )
    {
        return;
    }
    
    function_3d7a169dbae062fb( equipmentref, attacker, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x74651dfe, Offset: 0x16ded
// Size: 0xec
function private function_e9cda8d1c50b72e9( node )
{
    if ( !isdefined( node ) || !isdefined( node.angles ) )
    {
        return "unknown";
    }
    
    up = anglestoup( node.angles );
    
    if ( !isdefined( up ) )
    {
        return "unknown";
    }
    
    len = length( up );
    
    if ( len <= 0.001 )
    {
        return "unknown";
    }
    
    upnorm = up / len;
    z = upnorm[ 2 ];
    absz = abs( z );
    var_321efc24da549bff = 0.75;
    var_fa578bf1031ece04 = 0.25;
    
    if ( z >= var_321efc24da549bff )
    {
        return "floor";
    }
    
    if ( z <= var_321efc24da549bff * -1 )
    {
        return "ceiling";
    }
    
    if ( absz <= var_fa578bf1031ece04 )
    {
        return "wall";
    }
    
    return "slanted";
}

// Namespace challenges
// Params 2, eflags: 0x4
// Checksum 0xad02ef5e, Offset: 0x16ee2
// Size: 0xdc
function private function_7cb27abdac78250c( pointa, pointb )
{
    if ( !( isdefined( pointa ) && isdefined( pointb ) ) )
    {
        return "unknown";
    }
    
    delta = pointb - pointa;
    len = length( delta );
    
    if ( len <= 0.001 )
    {
        return "unknown";
    }
    
    dir = delta / len;
    vertical = abs( dir[ 2 ] );
    horizontal = sqrt( dir[ 0 ] * dir[ 0 ] + dir[ 1 ] * dir[ 1 ] );
    var_5c83eab8ef72cb00 = 0.75;
    var_4651c1a57f991856 = 0.95;
    
    if ( vertical >= var_5c83eab8ef72cb00 )
    {
        return "vertical";
    }
    
    if ( horizontal >= var_4651c1a57f991856 )
    {
        return "horizontal";
    }
    
    return "diagonal";
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x22d154d0, Offset: 0x16fc6
// Size: 0x59
function private function_35a7c37cc251fab1( params )
{
    var_32eda36c3bdd3a6a = 0;
    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_8d5a483220f10916" ) );
    function_3d7a169dbae062fb( "equip_at_mine", params.victim, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xe3f66ad5, Offset: 0x17027
// Size: 0x93
function private function_8ef70448286a463f( params )
{
    player = params.player;
    equipmentref = params.equipmentref;
    
    if ( !isdefined( player ) || !player challengesenabledforplayer() || !isdefined( equipmentref ) )
    {
        return;
    }
    
    var_32eda36c3bdd3a6a = 0;
    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"bounced" ) );
    function_3d7a169dbae062fb( equipmentref, player, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x20f56bae, Offset: 0x170c2
// Size: 0x83
function private function_357d6dd4398b72b1( params )
{
    player = params.player;
    equipmentref = params.equipmentref;
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    var_32eda36c3bdd3a6a = 0;
    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"reclaimed" ) );
    function_3d7a169dbae062fb( equipmentref, player, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xbb1048c9, Offset: 0x1714d
// Size: 0x170
function private function_382d10bdfa3df537( params )
{
    player = params.attacker;
    equipmentref = params.equipmentref;
    victim = params.stuckto;
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    var_32eda36c3bdd3a6a = 0;
    
    if ( isdefined( params.var_8df1180983085de3 ) )
    {
        if ( params.var_8df1180983085de3 == "super_riot_shield" )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"stuck_riotshield" ) );
        }
    }
    else if ( isdefined( params.stuckto ) )
    {
        stuckto = params.stuckto;
        
        if ( isplayer( stuckto ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"stuck_player" ) );
        }
        else if ( isagent( stuckto ) )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"stuck_agent" ) );
        }
        else if ( stuckto vehicle::is_vehicle() )
        {
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"stuck_vehicle" ) );
        }
    }
    else
    {
        return;
    }
    
    function_3d7a169dbae062fb( equipmentref, player, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a, victim );
}

// Namespace challenges
// Params 1
// Checksum 0x8314daf2, Offset: 0x172c5
// Size: 0x55, Type: bool
function function_21f89245c36f1704( einflictor )
{
    if ( !isdefined( einflictor.origin ) || !einflictor.isequipment )
    {
        return false;
    }
    
    door = function_6cf720856f2ecd74( einflictor.origin, 64 );
    
    if ( isdefined( door ) )
    {
        return true;
    }
    
    return false;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x2af905f1, Offset: 0x17323
// Size: 0xc6
function private function_9608ed71aa7de8f0( params )
{
    player = params.player;
    
    if ( !player challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ #"objective_use_time" ] ) )
    {
        player.pers[ #"objective_use_time" ] = {};
    }
    
    player.pers[ #"objective_use_time" ].starttime = gettime();
    
    if ( !isdefined( player.pers[ #"objective_use_time" ].totaltime ) )
    {
        player.pers[ #"objective_use_time" ].totaltime = 0;
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x5ab26c24, Offset: 0x173f1
// Size: 0x415
function private function_58eb48ff5906a8c2( params )
{
    if ( !params.player challengesenabledforplayer() )
    {
        return;
    }
    
    player = params.player;
    
    if ( !isdefined( player.challengedata ) )
    {
        player.challengedata = {};
    }
    
    player.challengedata.exited_zone = 1;
    player.challengedata.var_867c407f8b8559bf = gettime();
    
    if ( player.attackerdata.size > 0 )
    {
        foreach ( attacker in player.attackerdata )
        {
            if ( attacker.var_22b37ea8a43d69a2 && attacker.attackerent != player && player.team != attacker.attackerent.team && isalive( player ) )
            {
                canzone = level.equipment.table[ attacker.var_22b37ea8a43d69a2 ].bundle.var_a8ad37962d0bfbfe ?? 0;
                
                if ( canzone )
                {
                    var_32eda36c3bdd3a6a = 0;
                    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_76eccb6c4831acfd" ) );
                    function_3d7a169dbae062fb( attacker.var_22b37ea8a43d69a2, attacker.attackerent, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a );
                }
            }
        }
    }
    else if ( isdefined( player.challengedata.var_da37af497838d1a8 ) )
    {
        equipmentref = player.challengedata.var_1d37af6e89904fb6;
        effect_duration_ms = ( level.equipment.table[ equipmentref ].effect_duration ?? 5 ) * 1000;
        
        if ( player.challengedata && player.challengedata.var_867c407f8b8559bf - player.challengedata.var_da37af497838d1a8 < effect_duration_ms )
        {
            var_32eda36c3bdd3a6a = 0;
            
            if ( player.challengedata.bitmodifiers )
            {
                foreach ( modifier in player.challengedata.bitmodifiers )
                {
                    var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", modifier ) );
                }
            }
            
            var_32eda36c3bdd3a6a = function_a23641f33e985edb( var_32eda36c3bdd3a6a, ae_utility::function_2d1565a236387b2( #"equipment_bitfield1", #"hash_76eccb6c4831acfd" ) );
            function_3d7a169dbae062fb( player.challengedata.var_1d37af6e89904fb6, player.challengedata.var_a7ea7e51edad6018, undefined, undefined, 1, 0, var_32eda36c3bdd3a6a );
        }
    }
    
    starttime = player.pers[ #"objective_use_time" ].starttime;
    player.pers[ #"objective_use_time" ].totaltime += gettime() - starttime;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x72cba4ef, Offset: 0x1780e
// Size: 0x24
function private function_d510bc68cca04cf2( params )
{
    level.var_d5d1baab32eedb10.var_76cc85bad806c828 = gettime();
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x847a7643, Offset: 0x1783a
// Size: 0x3f
function private function_f6f69ec70065b12d( params )
{
    gameobject = params.game_object;
    level.var_d5d1baab32eedb10.var_f6ff35f521b62b1b = gameobjects_shared::function_55c8ebe2dd649ae5( gameobject );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x1e457487, Offset: 0x17881
// Size: 0x1e1
function private onroundend( params )
{
    winner = params.winner;
    
    foreach ( player in level.players )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_none" );
        
        if ( !isdefined( winner ) )
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_draw" );
        }
        else if ( isstring( winner ) )
        {
            if ( winner == "tie" )
            {
                result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_draw" );
            }
            else if ( winner == "none" )
            {
                result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_draw" );
            }
            else if ( isstring( player.team ) )
            {
                if ( player.team == winner )
                {
                    result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_win" );
                }
                else
                {
                    result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss" );
                }
            }
        }
        else if ( winner == player )
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_win" );
        }
        else
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss" );
        }
        
        var_fade070058a74a6f = 0;
        function_fbb52a28f31c6fd0( player, result, var_fade070058a74a6f );
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x552e509c, Offset: 0x17a6a
// Size: 0x130
function private function_ec101d3f878494bf( params )
{
    gameobject = params.game_object;
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    
    if ( isdefined( params.var_d5d1baab32eedb10 ) )
    {
        if ( params.var_d5d1baab32eedb10.instant_capture )
        {
            if ( params.var_d5d1baab32eedb10.var_2858ab6b89f74fb6 )
            {
                var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_3b5972c79a902a4" ) );
                function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
            }
            
            return;
        }
    }
    
    if ( isdefined( gameobject ) && gameobjects_shared::function_55c8ebe2dd649ae5( gameobject ) == #"hash_bb332da19f9944df" )
    {
        var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_c37311fe00a894b7" ) );
    }
    
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_570a439caf4b7c46" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xdb6813a9, Offset: 0x17ba2
// Size: 0x70
function private function_5ffc53c827692fa4( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"zone_capture_defense" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xc04cf084, Offset: 0x17c1a
// Size: 0x70
function private function_489ca7f201fde686( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_c37311fe00a894b7" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xc22629f2, Offset: 0x17c92
// Size: 0x115
function private onpickedup( params )
{
    player = params.player;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    
    if ( !self.team_first_pickup )
    {
        self.team_first_pickup = params.player.team;
    }
    
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"pick_up_objective" ) );
    
    if ( self.last_carrier && player && !player::isreallyalive( self.last_carrier ) && self.last_carrier.team == player.team && self.last_carrier != player )
    {
        function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_eae4cb53a252633" ) );
    }
    
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x9ee0bc70, Offset: 0x17daf
// Size: 0x70
function private ondropped( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"drop_objective" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xb5c3fa51, Offset: 0x17e27
// Size: 0x70
function private function_e47a24fd9221ed8b( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_fb12d48638ef7da3" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x17e692a4, Offset: 0x17e9f
// Size: 0x70
function private onplanted( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"plant_bomb" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xca0b964d, Offset: 0x17f17
// Size: 0x70
function private ondefused( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"defuse_bomb" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x71ea7470, Offset: 0x17f8f
// Size: 0x70
function private ondetonated( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"detonate_bomb" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x3372b582, Offset: 0x18007
// Size: 0x70
function private function_355c3101e536f3bc( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_a1edeffbfb42f1cc" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x7b9c3f0, Offset: 0x1807f
// Size: 0x70
function private function_2f8940e6d018a0df( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = 0;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"hash_7d489a3ba5c02c21" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x33ca3475, Offset: 0x180f7
// Size: 0x6d
function private function_c054f1da22a3a72a( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"capture_segment" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x4cca5541, Offset: 0x1816c
// Size: 0x6d
function private function_5fe28738af655c6e( params )
{
    player = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    var_cb60d0b7f316eff1 = function_a23641f33e985edb( var_cb60d0b7f316eff1, ae_utility::function_2d1565a236387b2( #"game_objective_bitfield1", #"deposit_objective" ) );
    function_c68ea96ea7a6c35a( player, var_380e1341c05f576b, var_cb60d0b7f316eff1 );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xbe9a88ee, Offset: 0x181e1
// Size: 0xcd
function private function_89b9d583de74725c( params )
{
    player = params.player;
    itemlootid = params.itemlootid;
    quantity = params.quantity;
    container = params.container;
    additionaleventparams = [];
    var_cc1f618c12b5db01 = function_d9305fc31d40bc5d( container );
    
    if ( var_cc1f618c12b5db01 )
    {
        additionaleventparams[ #"loot_cache_type" ] = var_cc1f618c12b5db01;
    }
    
    method = function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"deposit" ) );
    reportlootitemevent( player, itemlootid, undefined, method, quantity, undefined, undefined, additionaleventparams );
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0xe29a75ec, Offset: 0x182b6
// Size: 0x44
function private function_1d1f7091b3bbad40( params )
{
    player = params.player;
    
    if ( params.starlevel == 5 )
    {
        function_37e945722d6497f3( player, "STAR_SYSTEM_LEVEL_5", 1 );
    }
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0xe1cdfc10, Offset: 0x18302
// Size: 0x173
function private function_c68ea96ea7a6c35a( player, var_2b03add3a518dea6, flags = 0 )
{
    gametype = function_9edd00e9e48c0821();
    gamemode = getchallengegamemode();
    aeeventname = #"game_objective";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"game_objective_bitfield1" ) ] = flags;
    
    if ( isdefined( player ) )
    {
        if ( player challengesenabledforplayer() )
        {
            player reportchallengeuserserializedeventwrapper( aeeventid, eventparams );
        }
    }
    
    if ( isdefined( var_2b03add3a518dea6 ) )
    {
        foreach ( var_bfcacfc3e65ffcb1 in var_2b03add3a518dea6 )
        {
            if ( !var_bfcacfc3e65ffcb1 challengesenabledforplayer() )
            {
                continue;
            }
            
            var_bfcacfc3e65ffcb1 reportchallengeuserserializedeventwrapper( aeeventid, eventparams );
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x7954fcca, Offset: 0x1847d
// Size: 0x41
function private function_fb0433a0cedcce1( challengeevent )
{
    if ( !isdefined( challengeevent ) || !isdefined( level.var_27467e8785e675b ) )
    {
        return 0;
    }
    
    if ( level.var_27467e8785e675b[ challengeevent ] )
    {
        return level.var_27467e8785e675b[ challengeevent ];
    }
    
    return 0;
}

// Namespace challenges
// Params 0, eflags: 0x4
// Checksum 0x2bfbee14, Offset: 0x184c7
// Size: 0xd5
function private function_a88e01ba79fb2a02()
{
    level.var_27467e8785e675b = [];
    var_8f5fb7dd4d5c586f = getscriptbundle( hashcat( %"hash_10678328fc286f8a", level.gametypebundle.var_8f5fb7dd4d5c586f ) );
    
    if ( !isdefined( var_8f5fb7dd4d5c586f ) )
    {
        return;
    }
    
    foreach ( callback in var_8f5fb7dd4d5c586f.challengecallbacks )
    {
        level.var_27467e8785e675b[ callback.fieldname ] = callback.enabled;
    }
}

// Namespace challenges
// Params 3, eflags: 0x4
// Checksum 0x442c5564, Offset: 0x185a4
// Size: 0x5e
function private function_31317dfecad821b0( challengeevent, eventcallback, eventfunction )
{
    if ( function_fb0433a0cedcce1( challengeevent ) )
    {
        if ( callback::function_2c2c3cf92a917620( eventcallback, #"hash_abf23dc6100798bc" ) )
        {
            callback::function_dc654a4d4126a928( eventcallback, #"hash_abf23dc6100798bc", eventfunction );
            return;
        }
        
        callback::add( eventcallback, eventfunction );
    }
}

// Namespace challenges
// Params 3
// Checksum 0xc284e453, Offset: 0x1860a
// Size: 0x111
function function_4fd386d590e901d8( var_9536e549aa68740, var_287b59528920243d, var_3570b5b5420f9e49 )
{
    /#
        assert( isxhash( var_287b59528920243d ), var_287b59528920243d + "<dev string:xe1e>" );
        assert( isxhash( var_3570b5b5420f9e49 ), var_287b59528920243d + "<dev string:xe31>" );
    #/
    
    if ( !var_9536e549aa68740 )
    {
        var_9536e549aa68740 = {};
    }
    
    if ( !isdefined( var_9536e549aa68740.challengedata ) )
    {
        var_9536e549aa68740.challengedata = {};
    }
    
    if ( !isdefined( var_9536e549aa68740.challengedata.var_df779c91e88a795c ) )
    {
        var_9536e549aa68740.challengedata.var_df779c91e88a795c = [];
    }
    
    if ( !isdefined( var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ] ) )
    {
        var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ] = [];
    }
    
    var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ] = arraycombineunique( var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ], [ var_3570b5b5420f9e49 ] );
}

// Namespace challenges
// Params 3
// Checksum 0xa6dc0f06, Offset: 0x18723
// Size: 0xb6
function function_a3a53b46f5108e77( var_9536e549aa68740, var_287b59528920243d, var_5293d5ca4cf93476 )
{
    /#
        assert( isxhash( var_287b59528920243d ), var_287b59528920243d + "<dev string:xe1e>" );
        assert( isxhash( var_5293d5ca4cf93476 ), var_5293d5ca4cf93476 + "<dev string:xe1e>" );
    #/
    
    if ( var_9536e549aa68740.challengedata.var_df779c91e88a795c )
    {
        if ( var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ] )
        {
            var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ] = arrayremove( var_9536e549aa68740.challengedata.var_df779c91e88a795c[ var_287b59528920243d ], var_5293d5ca4cf93476 );
        }
    }
}

// Namespace challenges
// Params 2
// Checksum 0x391b7ad2, Offset: 0x187e1
// Size: 0xcc
function function_3fbf171c373d7ee1( ent, var_287b59528920243d )
{
    var_15f8364317e047e4 = 0;
    
    if ( ent.challengedata.var_df779c91e88a795c )
    {
        foreach ( bit in ent.challengedata.var_df779c91e88a795c[ var_287b59528920243d ] )
        {
            var_15f8364317e047e4 = function_a23641f33e985edb( var_15f8364317e047e4, ae_utility::function_2d1565a236387b2( var_287b59528920243d, bit ) );
        }
    }
    
    return var_15f8364317e047e4;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x7726df5c, Offset: 0x188b6
// Size: 0x85
function private function_201616a995d283bc( objweapon )
{
    weaponlootid = 0;
    
    if ( isdefined( objweapon ) )
    {
        weaponlootid = weapon::function_57559cfce1d2812d( objweapon );
        
        if ( !isdefined( weaponlootid ) )
        {
            weaponlootid = 0;
        }
        
        if ( weaponlootid == 0 )
        {
            equipmentweaponname = function_ff0a3bbd357d5501( objweapon );
            equipmentstruct = level.equipment.table[ equipmentweaponname ];
            
            if ( isdefined( equipmentstruct ) )
            {
                weaponlootid = loot::getlootidfromref( equipmentstruct.ref );
            }
        }
    }
    
    return weaponlootid;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x3655b483, Offset: 0x18944
// Size: 0x52
function private function_3899b7b9609e5689( var_d83451c1bf446403 )
{
    if ( isdefined( level.sharedfuncs[ #"challenges" ][ #"hash_9a0a0c803c627950" ] ) )
    {
        return self [[ level.sharedfuncs[ #"challenges" ][ #"hash_9a0a0c803c627950" ] ]]( var_d83451c1bf446403 );
    }
    
    return var_d83451c1bf446403;
}

