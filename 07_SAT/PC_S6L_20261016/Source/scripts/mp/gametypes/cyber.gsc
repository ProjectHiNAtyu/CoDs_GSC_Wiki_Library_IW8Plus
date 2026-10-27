// scripts\mp\gametypes\cyber.gsc  (hash_5ef30008f8fe780d.gscc) (size: 65796 Bytes / 0x10104 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73dde24c (1943921228)
// size ...... 65796 (0x10104)
// includes .. 50  (offset: 0xedb4)
// strings ... 207 (offset: 0xef44)
// dev strs .. 24  (offset: 0xff68)
// exports ... 103 (offset: 0xa664)
// cseg ...... 0x10df + 0x9585 (0xa664)
// imports ... 425 (offset: 0xb67c)
// animtree1 . 0   (offset: 0x10104)
// animtree2 . 0   (offset: 0x10104)
#using script_5acfd9b1af0b41bc;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots_util;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\usability;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\motiondetectors;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;

#namespace cyber;

// Namespace cyber
// Params 0
// Checksum 0x1021fd20, Offset: 0x10fd
// Size: 0x862
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        if ( !level.multibomb )
        {
            var_36671917263a4dfc = [ &function_eb2a9f2ae9018f2d, &function_be2de377ce070e51 ];
            gameobjects_common::function_22117b1fd559026f( #"cyberbomb", { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) }, var_36671917263a4dfc );
        }
        
        var_6f0815c7a46a5120 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_6f0815c7a46a5120.var_c68e9f43ed9cc918 = #"hash_ce911e3bbe99421f";
        var_6f0815c7a46a5120.use_time_seconds = level.planttime;
        gameobjects_common::function_22117b1fd559026f( #"hash_b0ba25c8bc04e5f1", var_6f0815c7a46a5120, &function_53d5a8d65ee1ab77, #"hash_7118f9343873352b" );
        var_94f23465f1e5041e = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_94f23465f1e5041e.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
        var_94f23465f1e5041e.use_time_seconds = level.defusetime;
        gameobjects_common::function_22117b1fd559026f( #"hash_a6e991c2688316df", var_94f23465f1e5041e, &function_57a3bfd87f9b58c1, #"hash_7118f9343873352b" );
        var_cc642a89bc32990c = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_cc642a89bc32990c.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
        var_cc642a89bc32990c.use_time_seconds = level.planttime;
        gameobjects_common::function_22117b1fd559026f( #"hash_65d0eb95bc9f8d85", var_cc642a89bc32990c, &function_53d5a8d65ee1ab77, #"hash_ce911e3bbe99421f" );
        var_51f8408b3584a1ea = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_51f8408b3584a1ea.var_c68e9f43ed9cc918 = #"hash_ce911e3bbe99421f";
        var_51f8408b3584a1ea.use_time_seconds = level.defusetime;
        gameobjects_common::function_22117b1fd559026f( #"hash_5308701fd5543e23", var_51f8408b3584a1ea, &function_57a3bfd87f9b58c1, #"hash_ce911e3bbe99421f" );
    }
    else
    {
        allowed[ 0 ] = game_utility::getgametype();
        allowed[ 1 ] = "blocker";
        gameobjects::main( allowed );
    }
    
    level.objectivebased = 1;
    level.teambased = 1;
    println( "<dev string:x24>" + gettime() );
    level callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.nobuddyspawns = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.onnormaldeath = &onnormaldeath;
    level.gamemodemaydropweapon = &game_utility_mp::isplayeroutsideofanybombsite;
    level.onexfilstarted = &onexfilstarted;
    level.onmaprestart = &function_f219e66c55b6101c;
    level.resetuiomnvargamemode = &obj_bombzone::resetuiomnvargamemode;
    level.var_40cd999d911308e0 = &game_utility_mp::function_78d7264eab1f870;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_1eb2797be76408e9;
    level.emplightsoff = &emplightsoff;
    level.allowlatecomers = 0;
    level.bombplanted = 0;
    level.bombplantedteam = undefined;
    level.bombexploded = 0;
    game[ "canScoreOnTie" ] = 1;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_cybr_mode_uktl_cyt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "iw9_cybr_mode_uktl_cynm";
    }
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        boostvo = "iw9_cybr_mode_uktl_cybo";
    }
    else
    {
        boostvo = "iw9_cybr_mode_uktl_cybs";
    }
    
    game[ "dialog" ][ "offense_obj" ] = boostvo;
    game[ "dialog" ][ "defense_obj" ] = boostvo;
    game[ "dialog" ][ "emppickup_friendly" ] = "iw9_cybr_mode_uktl_cyaa";
    game[ "dialog" ][ "emppickup_friendly_first" ] = "iw9_cybr_mode_uktl_cyab";
    game[ "dialog" ][ "emppickup_enemy" ] = "iw9_cybr_mode_uktl_cyac";
    game[ "dialog" ][ "empdefused_friendly" ] = "iw9_cybr_mode_uktl_cyba";
    game[ "dialog" ][ "empdefused_final_friendly" ] = "iw9_cybr_mode_uktl_cybb";
    game[ "dialog" ][ "empdefused_enemy" ] = "iw9_cybr_mode_uktl_cybc";
    game[ "dialog" ][ "empdefused_final_enemy" ] = "iw9_cybr_mode_uktl_cybd";
    game[ "dialog" ][ "empplanted_friendly" ] = "iw9_cybr_mode_uktl_cyca";
    game[ "dialog" ][ "empplanted_enemy" ] = "iw9_cybr_mode_uktl_cycb";
    game[ "dialog" ][ "lead_lost" ] = "iw9_cybr_mode_uktl_cyla";
    game[ "dialog" ][ "lead_taken" ] = "iw9_cybr_mode_uktl_cylb";
    setomnvar( "ui_bomb_carrier", -1 );
    setomnvar( "ui_bomb_owner_team", -1 );
    setomnvar( "ui_bomb_interacting", 0 );
    setomnvar( "ui_bomb_timer_endtime_a", 0 );
    
    /#
        setdevdvarifuninitialized( @"hash_3f3a15fb7e7c9b0", 0 );
        thread function_be9a98d6817ff396();
        thread function_f9e6f27c5a64ceb8();
        thread function_69aae105718a70a3();
        thread function_8080aef11830a2bc();
        thread function_e5188375b6d0bfbf();
    #/
}

// Namespace cyber
// Params 0
// Checksum 0x19dd1dcd, Offset: 0x1967
// Size: 0xd8
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.empspawnindex = getmatchrulesdata( "cyberData", "empSpawn" );
    level.radarpingtime = getmatchrulesdata( "cyberData", "radarPingTime" );
    level.persbombtimer = getmatchrulesdata( "cyberData", "persBombTimer" );
    level.detonatescore = getmatchrulesdata( "cyberData", "detonateScore" );
    level.bombtimer = getmatchrulesdata( "bombData", "bombTimer" );
    level.planttime = getmatchrulesdata( "bombData", "plantTime" );
    level.defusetime = getmatchrulesdata( "bombData", "defuseTime" );
    level.multibomb = getmatchrulesdata( "bombData", "multiBomb" );
    level.showenemycarrier = getmatchrulesdata( "carryData", "showEnemyCarrier" );
}

// Namespace cyber
// Params 0
// Checksum 0x39ab9f9, Offset: 0x1a47
// Size: 0x19
function waittooverridegraceperiod()
{
    flags::gameflagwait( "prematch_done" );
    level.overrideingraceperiod = 1;
}

// Namespace cyber
// Params 0
// Checksum 0xe139921d, Offset: 0x1a68
// Size: 0x1c
function onprecachegametype()
{
    game[ "bomb_dropped_sound" ] = "iw9_mp_ui_objective_lost";
    game[ "bomb_recovered_sound" ] = "iw9_mp_ui_objective_taken";
}

// Namespace cyber
// Params 0
// Checksum 0x429911d2, Offset: 0x1a8c
// Size: 0x4f2
function onstartgametype()
{
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    setclientnamemode( "manual_change" );
    level._effect[ "emp_detonation" ] = loadfxasset( "vfx_iw9_gameplay_mp_cyber_emp_explode" );
    level._effect[ "vehicle_explosion" ] = loadfxasset( "vfx_core_explo_small_vehicle_new" );
    level._effect[ "building_explosion" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    game_utility_mp::setobjectivetext( game[ "attackers" ], &"objectives/sd_attacker" );
    game_utility_mp::setobjectivetext( game[ "defenders" ], &"objectives/sd_defender" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/sd_attacker" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/sd_defender" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/sd_attacker_score" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/sd_defender_score" );
    }
    
    game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives/sd_attacker_hint" );
    game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives/sd_defender_hint" );
    cyberemps = getentarray( "cyber_emp", #targetname );
    
    foreach ( cyberemp in cyberemps )
    {
        cyberemp delete();
    }
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        if ( istrue( level.game_objects.var_5f329cd264226f08 ) )
        {
            utility::flag_wait( "cs_gameobjects_constructed" );
        }
        else
        {
            utility::flag_wait( "gameobject_system_post_init" );
            function_641684784f5044ff();
            waitframe();
        }
        
        bomb_plant_weapon_ref = common::get_gametype_asset( #"bomb_plant_weapon" );
        bomb_defuse_weapon_ref = common::get_gametype_asset( #"bomb_defuse_weapon" );
        bombzone_scriptable_ref = common::get_gametype_asset( #"bombzone_scriptable" );
        
        foreach ( var_7f4958ce4e4277c3, var_794f056b1925e462 in level.var_4e40f7256e1dc35b )
        {
            var_e5e9b2d488ed113 = var_794f056b1925e462.planting;
            var_8bb4439dc05d7221 = var_794f056b1925e462.defusing;
            var_57e217cafb730cb = gameobjects_common::get_origin( var_e5e9b2d488ed113 );
            var_445bed1a80eddd45 = gameobjects_common::function_63e25df7cfbb206f( var_e5e9b2d488ed113 );
            bombzone_scriptable_spawn_origin = utility::drop_to_ground( var_57e217cafb730cb, 64, -1024 );
            var_77dcf432047cb49c = [ #"teamselect", var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" ? 1 : 2 ];
            var_e5e9b2d488ed113.scriptable = spawnscriptable( bombzone_scriptable_ref, bombzone_scriptable_spawn_origin, var_445bed1a80eddd45, undefined, var_77dcf432047cb49c );
            
            /#
                assert( var_e5e9b2d488ed113.scriptable getscriptablehaspart( #"explosion" ), "<dev string:x4c>" );
                assert( var_e5e9b2d488ed113.scriptable getscriptableparthasstate( #"explosion", #"trigger" ), "<dev string:x7b>" );
            #/
            
            var_8bb4439dc05d7221.objective_id = var_e5e9b2d488ed113.objective_id;
            var_8bb4439dc05d7221.scriptable = var_e5e9b2d488ed113.scriptable;
            bombzone::initialize_bombzone( var_e5e9b2d488ed113, var_8bb4439dc05d7221, level.cyberemp, bomb_plant_weapon_ref, bomb_defuse_weapon_ref );
        }
        
        level.var_4e40f7256e1dc35b = undefined;
        callback::add( #"hash_4b88ae7136a85bfd", &function_b82d4c1cd71245dc );
        callback::add( #"hash_e19a9f3d97f3e18f", &function_7dff5f203814911e );
        callback::add( #"hash_3a1fe5e4df493585", &function_13433513804ffe34 );
    }
    else
    {
        cyberattack();
        setupwaypointicons();
        thread startmatchobjectiveicons();
    }
    
    callback::add( #"hash_89e109eb26a160ed", &function_f3a8689e0f98f3d7 );
    callback::add( #"hash_2a6553431436974f", &function_4c9dd25d05697cad );
    initspawns();
    thread waittooverridegraceperiod();
}

// Namespace cyber
// Params 0
// Checksum 0xb45da539, Offset: 0x1f86
// Size: 0xce
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"primary_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"start", #"primary_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_cyber_spawn_allies", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_cyber_spawn_axis", game[ "defenders" ], 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace cyber
// Params 0
// Checksum 0x729c5aad, Offset: 0x205c
// Size: 0x32
function getspawnpoint()
{
    spawnlogic::setactivespawnlogic( #"start" );
    return spawnlogic::getspawnpoint( self, self.pers[ "team" ], #"start", undefined );
}

// Namespace cyber
// Params 1
// Checksum 0xa2af32a3, Offset: 0x2097
// Size: 0xa0, Type: bool
function isenemyteameliminated( teamname )
{
    players = level.teamdata[ teamname ][ "players" ];
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace cyber
// Params 0
// Checksum 0x98d66b18, Offset: 0x2140
// Size: 0x45c
function assignteamspawns()
{
    level.spawnnodetype = "mp_ctf_spawn";
    spawnpoints = spawnlogic::getspawnpointarray( level.spawnnodetype );
    ispathdataavailable = spawnlogic::ispathdataavailable();
    level.teamspawnpoints[ "axis" ] = [];
    level.teamspawnpoints[ "allies" ] = [];
    level.teamspawnpoints[ "neutral" ] = [];
    
    if ( level.objectives.size == 2 )
    {
        axisbombsite = level.objectives[ "axis" ];
        alliesbombsite = level.objectives[ "allies" ];
        var_d89c6705f28f949c = ( axisbombsite.curorigin[ 0 ], axisbombsite.curorigin[ 1 ], 0 );
        var_c593151406ea6b0d = ( alliesbombsite.curorigin[ 0 ], alliesbombsite.curorigin[ 1 ], 0 );
        bombsitedelta = var_c593151406ea6b0d - var_d89c6705f28f949c;
        bombsitedist = length2d( bombsitedelta );
        
        foreach ( spawnpoint in spawnpoints )
        {
            spawnpointorigin2d = ( spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], 0 );
            var_225cd03b4df3c09e = spawnpointorigin2d - var_d89c6705f28f949c;
            dotvalue = vectordot( var_225cd03b4df3c09e, bombsitedelta );
            var_e909075714042156 = dotvalue / bombsitedist * bombsitedist;
            
            if ( var_e909075714042156 < 0.33 )
            {
                spawnpoint.teambase = axisbombsite.ownerteam;
                level.teamspawnpoints[ spawnpoint.teambase ][ level.teamspawnpoints[ spawnpoint.teambase ].size ] = spawnpoint;
                continue;
            }
            
            if ( var_e909075714042156 > 0.67 )
            {
                spawnpoint.teambase = alliesbombsite.ownerteam;
                level.teamspawnpoints[ spawnpoint.teambase ][ level.teamspawnpoints[ spawnpoint.teambase ].size ] = spawnpoint;
                continue;
            }
            
            var_446440e8092a41fc = undefined;
            var_1a513c0287cf08a7 = undefined;
            
            if ( ispathdataavailable )
            {
                var_446440e8092a41fc = distance( spawnpoint.origin, axisbombsite.curorigin );
            }
            
            if ( isdefined( var_446440e8092a41fc ) && var_446440e8092a41fc != -1 )
            {
                var_1a513c0287cf08a7 = distance( spawnpoint.origin, alliesbombsite.curorigin );
            }
            
            if ( !isdefined( var_1a513c0287cf08a7 ) || var_1a513c0287cf08a7 == -1 )
            {
                var_446440e8092a41fc = distance2d( axisbombsite.curorigin, spawnpoint.origin );
                var_1a513c0287cf08a7 = distance2d( alliesbombsite.curorigin, spawnpoint.origin );
            }
            
            var_aeb5bfe4a587beee = max( var_446440e8092a41fc, var_1a513c0287cf08a7 );
            var_a653d736f4316c82 = min( var_446440e8092a41fc, var_1a513c0287cf08a7 );
            distpercent = var_a653d736f4316c82 / var_aeb5bfe4a587beee;
            
            if ( distpercent > 0.5 )
            {
                level.teamspawnpoints[ "neutral" ][ level.teamspawnpoints[ "neutral" ].size ] = spawnpoint;
            }
        }
        
        return;
    }
    
    foreach ( spawnpoint in spawnpoints )
    {
        spawnpoint.teambase = getnearestbombsiteteam( spawnpoint );
        
        if ( spawnpoint.teambase == "axis" )
        {
            level.teamspawnpoints[ "axis" ][ level.teamspawnpoints[ "axis" ].size ] = spawnpoint;
            continue;
        }
        
        level.teamspawnpoints[ "allies" ][ level.teamspawnpoints[ "allies" ].size ] = spawnpoint;
    }
}

// Namespace cyber
// Params 1
// Checksum 0x3d796d1a, Offset: 0x25a4
// Size: 0x122
function getnearestbombsiteteam( spawnpoint )
{
    ispathdataavailable = spawnlogic::ispathdataavailable();
    nearestbombsite = undefined;
    nearestdist = undefined;
    
    foreach ( bombsite in level.objectives )
    {
        dist = undefined;
        
        if ( ispathdataavailable )
        {
            dist = distance( spawnpoint.origin, bombsite.curorigin );
        }
        
        if ( !isdefined( dist ) || dist == -1 )
        {
            dist = distancesquared( bombsite.curorigin, spawnpoint.origin );
        }
        
        if ( !isdefined( nearestbombsite ) || dist < nearestdist )
        {
            nearestbombsite = bombsite;
            nearestdist = dist;
        }
    }
    
    return team_utility::getotherteam( nearestbombsite.ownerteam );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xebc29849, Offset: 0x26cf
// Size: 0xea
function private function_3a6311dfa69b8740( spawntriggers )
{
    assert( isdefined( spawntriggers ) && spawntriggers.size > 0, "<dev string:xaf>" );
    
    switch ( level.mapname )
    {
        case #"hash_b4040d028dc0782a":
            foreach ( spawntrigger in spawntriggers )
            {
                if ( distancesquared( ( 9770, 11472, -82 ), spawntrigger.origin ) < 1 )
                {
                    spawntriggers = arrayremove( spawntriggers, spawntrigger );
                }
            }
            
            break;
        default:
            break;
    }
    
    return spawntriggers;
}

// Namespace cyber
// Params 0
// Checksum 0x22cdeae9, Offset: 0x27c2
// Size: 0x8d8
function cyberattack()
{
    var_39d83481a931e7a8 = utility::getstructarray( "cyber_emp_pickup_trig", "script_noteworthy" ) ?? [];
    
    if ( var_39d83481a931e7a8.size > 0 )
    {
        level.scriptedsetup = 1;
    }
    else
    {
        var_39d83481a931e7a8 = getentarray( "cyber_emp_pickup_trig", #targetname );
        
        if ( var_39d83481a931e7a8.size > 0 )
        {
            var_39d83481a931e7a8 = function_3a6311dfa69b8740( var_39d83481a931e7a8 );
        }
        else
        {
            assertmsg( "<dev string:xcb>" );
            return;
        }
    }
    
    if ( level.empspawnindex == 3 )
    {
        if ( isdefined( game[ "empSpawn" ] ) )
        {
            randarray = [];
            
            for ( i = 0; i < var_39d83481a931e7a8.size ; i++ )
            {
                randarray[ randarray.size ] = i;
            }
            
            randarray = arrayremove( randarray, game[ "empSpawn" ] );
            level.empspawnindex = utility::array_random( randarray );
        }
        else
        {
            level.empspawnindex = randomintrange( 0, var_39d83481a931e7a8.size );
        }
        
        game[ "empSpawn" ] = level.empspawnindex;
    }
    else if ( level.empspawnindex == 4 )
    {
        if ( isdefined( game[ "empSpawn" ] ) )
        {
            level.empspawnindex = game[ "empSpawn" ] + 1;
            
            if ( level.empspawnindex == var_39d83481a931e7a8.size )
            {
                level.empspawnindex = 0;
            }
        }
        else
        {
            level.empspawnindex = 0;
        }
        
        game[ "empSpawn" ] = level.empspawnindex;
    }
    
    emptrigger = var_39d83481a931e7a8[ level.empspawnindex ];
    
    if ( !level.allowempweapon )
    {
        emptrigger = spawn( "trigger_radius", emptrigger.origin, 0, 32, 128 );
    }
    
    visuals[ 0 ] = spawn( "script_model", emptrigger.origin );
    visuals[ 0 ] setmodel( "projectile_cyber_emp_v0" );
    tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
    traceend = visuals[ 0 ].origin + ( 0, 0, -100 );
    ignoreents = [ visuals[ 0 ] ];
    contentoverride = trace::create_contents( 1, 1, 1, 1, 1, 1, 1 );
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    
    if ( trace[ "fraction" ] < 1 )
    {
        visuals[ 0 ].origin = trace[ "position" ] + ( 0, 0, 2 );
    }
    
    emptrigger enablelinkto();
    emptrigger linkto( visuals[ 0 ] );
    emptrigger.baseorigin = emptrigger.origin;
    emptrigger.no_moving_platfrom_unlink = 1;
    emptrigger.linktoenabledflag = 1;
    
    if ( !level.multibomb )
    {
        level.cyberemp = gameobjects::createcarryobject( "neutral", emptrigger, visuals, ( 0, 0, 16 ), undefined, 1 );
        level.cyberemp.cancontestclaim = 1;
        level.cyberemp.stalemate = 0;
        level.cyberemp.wasstalemate = 1;
        level.cyberemp gameobjects::allowuse( "any" );
        level.cyberemp.curprogress = 0;
        level.cyberemp.usetime = 0.05;
        level.cyberemp.userate = 1;
        level.cyberemp.id = "";
        level.cyberemp.exclusiveuse = 0;
        level.cyberemp.skiptouching = 1;
        level.cyberemp.skipminimapids = 1;
        level.cyberemp.onuse = &emptriggerholdonuse;
        
        if ( level.cyberemp.triggertype == "use" )
        {
            level.cyberemp.trigger setcursorhint( "HINT_NOICON" );
            level.cyberemp.trigger sethintstring( &"mp/emp_pickup_use" );
            level.cyberemp.trigger setusepriority( -4 );
        }
        
        level.cyberemp gameobjects::setusetime( level.cyberemp.usetime );
        level.cyberemp gameobjects::setwaitweaponchangeonuse( 0 );
        level.cyberemp.allowweapons = 1;
        level.cyberemp.onpickup = &onpickup;
        level.cyberemp.ondrop = &ondrop;
        level.cyberemp.firstpickup = 1;
        level thread empsitewatcher();
        level.bombrespawnpoint = level.cyberemp.visuals[ 0 ].origin;
        level.bombrespawnangles = level.cyberemp.visuals[ 0 ].angles;
        level.cyberemp.visualgroundoffset = ( 0, 0, 2 );
        
        if ( getdvarint( @"hash_484e617d6f7b7fa7" ) != 0 )
        {
            level.cyberemp gameobjects::function_a8c99f0b8d97b750( [ level.cyberemp.visuals[ 0 ] ], level.cyberemp.trigger, 1, 80, 0, &onempdropped );
        }
    }
    else
    {
        emptrigger delete();
        visuals[ 0 ] delete();
    }
    
    var_95e31cfad2f140b5 = getentarray( "cyber_empzone_allies", #targetname );
    
    if ( !isdefined( var_95e31cfad2f140b5[ 0 ] ) )
    {
        assertmsg( "<dev string:x122>" );
        return;
    }
    
    var_4ea3baab5216acaa = getentarray( "cyber_empzone_axis", #targetname );
    
    if ( !isdefined( var_4ea3baab5216acaa[ 0 ] ) )
    {
        assertmsg( "<dev string:x179>" );
        return;
    }
    
    var_7b5248ff3d757862 = utility::getstruct( "cyber_empzone_allies", "script_noteworthy" );
    
    if ( isdefined( var_7b5248ff3d757862 ) )
    {
        var_95e31cfad2f140b5[ 0 ].origin = utility::drop_to_ground( var_7b5248ff3d757862.origin, 10, -10 );
    }
    
    var_6fefa23c37c49735 = utility::getstruct( "cyber_empzone_axis", "script_noteworthy" );
    
    if ( isdefined( var_6fefa23c37c49735 ) )
    {
        var_4ea3baab5216acaa[ 0 ].origin = utility::drop_to_ground( var_6fefa23c37c49735.origin, 10, -10 );
    }
    
    var_bd8b29e073e1f1bd = getentarray( "cyber_emp_defuse_allies", #targetname );
    
    if ( isdefined( var_bd8b29e073e1f1bd ) )
    {
        foreach ( trigger in var_bd8b29e073e1f1bd )
        {
            trigger delete();
        }
    }
    
    var_12e202419db72322 = getentarray( "cyber_emp_defuse_axis", #targetname );
    
    if ( isdefined( var_12e202419db72322 ) )
    {
        foreach ( trigger in var_12e202419db72322 )
        {
            trigger delete();
        }
    }
    
    if ( game[ "switchedsides" ] )
    {
        level.objectives[ "allies" ] = createbombzone( "allies", var_4ea3baab5216acaa[ 0 ] );
        level.objectives[ "axis" ] = createbombzone( "axis", var_95e31cfad2f140b5[ 0 ] );
    }
    else
    {
        level.objectives[ "allies" ] = createbombzone( "allies", var_95e31cfad2f140b5[ 0 ] );
        level.objectives[ "axis" ] = createbombzone( "axis", var_4ea3baab5216acaa[ 0 ] );
    }
    
    level notify( #"hash_2ed90cfccb18c373" );
    level.objectives[ "axis" ] thread data_center_sfx_loop();
    level.objectives[ "allies" ] thread data_center_sfx_loop();
    
    if ( "mp_hackney_yard" == level.mapname )
    {
        thread destroytvs();
    }
}

// Namespace cyber
// Params 2
// Checksum 0x35404f37, Offset: 0x30a2
// Size: 0x315
function createbombzone( team, trigger )
{
    cyberempzones = undefined;
    
    if ( isdefined( trigger ) && isdefined( trigger.target ) )
    {
        cyberempzones = getentarray( trigger.target, #targetname );
        
        foreach ( cyberempzone in cyberempzones )
        {
            cyberempzone delete();
        }
    }
    
    visuals[ 0 ] = spawn( "script_model", utility::drop_to_ground( trigger.origin, 10, -10 ) );
    visuals[ 0 ] setmodel( "misc_carepackage_friendly" );
    
    if ( level.scriptedsetup )
    {
        trigger = visuals[ 0 ];
        trigger.usetype = 1;
        trigger.isuseobject = 1;
        trigger.skiptouching = 1;
        trigger makeusable();
    }
    
    bombzone = gameobjects::createuseobject( team, trigger, visuals, ( 0, 0, 64 ), undefined, 1 );
    bombzone.onuse = &onuse;
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.oncantuse = &oncantuse;
    bombzone.useweapon = makeweapon( "iw9_cyberemp_plant_mp" );
    bombzone.id = "bomb_zone";
    bombzone.trigger setusepriority( -4 );
    bombzone.trigger setuseholdduration( "duration_none" );
    bombzone.trigger setusehideprogressbar( 1 );
    bombzone.bombplanted = 0;
    bombzone.bombexploded = undefined;
    bombzone gameobjects::setusetime( level.planttime );
    bombzone gameobjects::setusetext( &"mp/planting_explosive" );
    bombzone gameobjects::setusehinttext( &"mp/hold_to_plant_explosives" );
    bombzone gameobjects::setwaitweaponchangeonuse( 0 );
    bombzone.objectivekey = "_" + team;
    bombzone.label = bombzone.objectivekey;
    bombzone resetbombsite( 1, undefined, 1 );
    
    for ( i = 0; i < visuals.size ; i++ )
    {
        if ( isdefined( visuals[ i ].script_exploder ) )
        {
            bombzone.exploderindex = visuals[ i ].script_exploder;
            visuals[ i ] thread setupkillcament( bombzone );
            break;
        }
    }
    
    bombzone.noweapondropallowedtrigger = spawn( "trigger_radius", bombzone.trigger.origin, 0, 140, 100 );
    return bombzone;
}

// Namespace cyber
// Params 0
// Checksum 0xb953ea3d, Offset: 0x33c0
// Size: 0x245
function startmatchobjectiveicons()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    level.objectives[ "allies" ] gameobjects::requestid( 1, 1 );
    level.objectives[ "allies" ] gameobjects::setobjectivestatusicons( "icon_waypoint_defend_empsite", "icon_waypoint_target_empsite" );
    level.objectives[ "allies" ] gameobjects::setvisibleteam( "any" );
    level.objectives[ "axis" ] gameobjects::requestid( 1, 1 );
    level.objectives[ "axis" ] gameobjects::setobjectivestatusicons( "icon_waypoint_defend_empsite", "icon_waypoint_target_empsite" );
    level.objectives[ "axis" ] gameobjects::setvisibleteam( "any" );
    level thread hidebombsitesaftermatchstart();
    level.cyberemp gameobjects::requestid( 1, 1 );
    level.cyberemp gameobjects::setobjectivestatusicons( "icon_waypoint_emp" );
    level.cyberemp gameobjects::setvisibleteam( "any" );
    
    if ( isdefined( level.cyberemp.visuals[ 0 ] ) )
    {
        level.cyberemp.visuals[ 0 ] obj_bombzone::setteaminhuddatafromteamname( "neutral" );
        level.cyberemp.visuals[ 0 ] setasgametypeobjective();
    }
    
    objidpoolmanager::objective_set_play_intro( level.cyberemp.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( level.cyberemp.objidnum, 0 );
    objective_setspecialobjectivedisplay( level.cyberemp.objidnum, 1 );
    pingobjid = objidpoolmanager::requestobjectiveid( 99 );
    level.cyberemp.pingobjidnum = pingobjid;
    objidpoolmanager::objective_add_objective( pingobjid, "done", level.cyberemp.origin );
    level.cyberemp gameobjects::setvisibleteam( "none", pingobjid );
    objective_setownerteam( pingobjid, undefined );
    level.cyberemp gameobjects::setobjectivestatusallicons( "icon_waypoint_escort_emp", "waypoint_capture_kill", undefined, pingobjid );
    setcarriervisibility();
}

// Namespace cyber
// Params 0
// Checksum 0x1cca2c95, Offset: 0x360d
// Size: 0x11c
function hidebombsitesaftermatchstart()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    objidpoolmanager::objective_set_play_intro( level.objectives[ "allies" ].objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( level.objectives[ "allies" ].objidnum, 0 );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "allies" ].objidnum, 1 );
    objidpoolmanager::objective_set_play_intro( level.objectives[ "axis" ].objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( level.objectives[ "axis" ].objidnum, 0 );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "axis" ].objidnum, 1 );
    level.objectives[ "allies" ] gameobjects::setvisibleteam( "none" );
    level.objectives[ "axis" ] gameobjects::setvisibleteam( "none" );
}

// Namespace cyber
// Params 1
// Checksum 0xbb08cf1f, Offset: 0x3731
// Size: 0xc
function emptriggerholdonuse( player )
{
    
}

// Namespace cyber
// Params 1
// Checksum 0xc30a2b5c, Offset: 0x3745
// Size: 0x15e
function setupkillcament( bombzone )
{
    temporg = spawn( "script_origin", self.origin );
    temporg.angles = self.angles;
    temporg rotateyaw( -45, 0.05 );
    waitframe();
    campos = undefined;
    bulletstart = self.origin + ( 0, 0, 45 );
    bulletend = self.origin + anglestoforward( temporg.angles ) * 100 + ( 0, 0, 128 );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle" ];
    contentoverride = physics_createcontents( content );
    result = trace::ray_trace( bulletstart, bulletend, self, contentoverride );
    campos = result[ "position" ];
    self.killcament = spawn( "script_model", campos );
    self.killcament setscriptmoverkillcam( "explosive" );
    bombzone.killcamentnum = self.killcament getentitynumber();
    temporg delete();
    
    /#
        self.killcament thread debugkillcament( self );
    #/
}

/#

    // Namespace cyber
    // Params 1
    // Checksum 0x85bc37e8, Offset: 0x38ab
    // Size: 0x1d3, Type: dev
    function debugkillcament( visual )
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        visual endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_3f3a15fb7e7c9b0" ) > 0 )
            {
                line( self.origin, self.origin + anglestoforward( self.angles ) * 10, ( 1, 0, 0 ) );
                line( self.origin, self.origin + anglestoright( self.angles ) * 10, ( 0, 1, 0 ) );
                line( self.origin, self.origin + anglestoup( self.angles ) * 10, ( 0, 0, 1 ) );
                line( visual.origin + ( 0, 0, 5 ), self.origin, ( 0, 0, 1 ) );
                line( visual.origin, visual.origin + anglestoforward( visual.angles ) * 10, ( 1, 0, 0 ) );
                line( visual.origin, visual.origin + anglestoright( visual.angles ) * 10, ( 0, 1, 0 ) );
                line( visual.origin, visual.origin + anglestoup( visual.angles ) * 10, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

#/

// Namespace cyber
// Params 0
// Checksum 0x30b63302, Offset: 0x3a86
// Size: 0x79
function empsitewatcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"bomb_pickup" );
        
        if ( level.cyberemp.carrier.team == "allies" )
        {
            level.objectives[ "axis" ] setupforplanting();
        }
        else
        {
            level.objectives[ "allies" ] setupforplanting();
        }
        
        waitframe();
    }
}

// Namespace cyber
// Params 0
// Checksum 0x82f84676, Offset: 0x3b07
// Size: 0x64
function data_center_sfx_loop()
{
    ent = utility::spawn_script_origin( self.trigger.origin, self.trigger.angles );
    ent thread utility::play_loop_sound_on_entity( "data_center_cyber_lp" );
    level waittill( #"emp_detonated" );
    ent stopsounds();
    waitframe();
    ent delete();
}

// Namespace cyber
// Params 1
// Checksum 0xdb64b335, Offset: 0x3b73
// Size: 0x173
function onbeginuse( player )
{
    if ( !gameobjects::isfriendlyteam( player.pers[ "team" ] ) && !level.bombplanted )
    {
        player.isplanting = 1;
        setomnvar( "ui_bomb_interacting", 1 );
        gameobjects::setobjectivestatusicons( "icon_waypoint_defend_empsite", "icon_waypoint_emp_planting" );
    }
    else
    {
        player.isdefusing = 1;
        setomnvar( "ui_bomb_interacting", 3 );
        codcaster_utils::function_3038b6eafc46c037( 2, player.team, player getentitynumber() );
        gameobjects::setobjectivestatusicons( "icon_waypoint_defend_empsite_nt", "icon_waypoint_emp_defusing" );
        objidpoolmanager::objective_teammask_removefrommask( self.radialtimeobjid, player.team );
    }
    
    player thread allowedwhileplanting( 0 );
    
    if ( level.bombplanted && !gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
    {
        player bots_util_mp::notify_enemy_bots_bomb_used( "defuse" );
        player.isdefusing = 1;
        setomnvar( "ui_bomb_interacting", 3 );
        setomnvar( "ui_bomb_defuser", player getentitynumber() );
        
        if ( isdefined( level.cyberemp.visuals[ 0 ] ) )
        {
            level.cyberemp.visuals[ 0 ] hide();
        }
        
        player thread startnpcbombusesound( "briefcase_bomb_defuse_mp", "equip_suitcase_defuse_button" );
    }
}

// Namespace cyber
// Params 1
// Checksum 0x5252045d, Offset: 0x3cee
// Size: 0xa1
function allowedwhileplanting( isallowed )
{
    val::set( "planting", "melee", isallowed );
    val::set( "planting", "allow_jump", isallowed );
    val::set( "planting", "gesture", isallowed );
    
    if ( isallowed )
    {
        self waittill( #"bomb_allow_offhands" );
    }
    
    val::set( "planting", "melee", isallowed );
    val::set( "planting", "mantle", isallowed );
    val::set( "planting", "offhand_weapons", isallowed );
    
    if ( isallowed )
    {
        val::reset_all( "planting" );
    }
}

// Namespace cyber
// Params 3
// Checksum 0x3170938e, Offset: 0x3d97
// Size: 0x1a2
function onenduse( team, player, result )
{
    objid = self.objidnum;
    objidpoolmanager::objective_set_progress( objid, 0 );
    objidpoolmanager::objective_show_progress( objid, 0 );
    
    if ( !result )
    {
        if ( player.isdefusing )
        {
            gameobjects::setobjectivestatusallicons( "icon_waypoint_defuse_empsite_nt", "icon_waypoint_defend_empsite_nt", "mlg_icon_waypoint_emp_planted" );
        }
        else
        {
            gameobjects::setobjectivestatusallicons( "icon_waypoint_defend_empsite", "icon_waypoint_target_empsite", undefined );
        }
        
        if ( isdefined( self.radialtimeobjid ) )
        {
            objidpoolmanager::objective_teammask_addtomask( self.radialtimeobjid, player.team );
        }
        
        if ( player meleebuttonpressed() )
        {
            interruptbombplanting( player );
        }
        else
        {
            player inventory::switchtolastweapon();
        }
    }
    
    if ( player.isdefusing || player.isplanting )
    {
        setomnvar( "ui_bomb_interacting", 0 );
    }
    
    player.isplanting = 0;
    player.isdefusing = 0;
    setomnvar( "ui_bomb_defuser", -1 );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player thread allowedwhileplanting( 1 );
    player.bombplantweapon = undefined;
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        player.ui_bomb_planting_defusing = undefined;
    }
    
    if ( !gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
    {
        if ( isdefined( level.cyberemp ) && !result )
        {
            level.cyberemp.visuals[ 0 ] show();
        }
    }
}

// Namespace cyber
// Params 2
// Checksum 0xa048068f, Offset: 0x3f41
// Size: 0xea
function startnpcbombusesound( weaponname, soundname )
{
    self endon( #"death" );
    self endon( #"hash_eb6e0059397c7fef" );
    
    if ( game_utility_mp::isanymlgmatch() || level.silentplant || isdefined( self.perks[ "specialty_engineer" ] ) )
    {
        self setentitysoundcontext( "silent_plant", "on" );
        return;
    }
    
    while ( true )
    {
        self waittill( #"weapon_change", newweaponobj );
        
        if ( newweaponobj.basename == weaponname )
        {
            break;
        }
    }
    
    self playsoundtoteam( soundname, self.team, self );
    enemyteam = team_utility::getotherteam( self.team );
    self playsoundtoteam( soundname, enemyteam );
    self waittill( #"weapon_change" );
    self notify( #"hash_eb6e0059397c7fef" );
}

// Namespace cyber
// Params 3
// Checksum 0x85dfd96c, Offset: 0x4033
// Size: 0x3c3
function onpickup( player, playervo, defused )
{
    level notify( #"bomb_pickup" );
    
    if ( level.allowempweapon )
    {
        player inventory_utility::_giveweapon( "iw9_cyberemp_mp" );
        
        if ( !defused && !player killstreak::isjuggernaut() && !isbot( player ) )
        {
            player inventory_utility::_switchtoweaponimmediate( "iw9_cyberemp_mp" );
        }
    }
    
    player thread empradarwatcher();
    setomnvar( "ui_bomb_carrier", player getentitynumber() );
    player setclientomnvar( "ui_emp_carrier_hud", 1 );
    codcaster_utils::function_3038b6eafc46c037( 16, player.team, player getentitynumber() );
    
    if ( self.firstpickup )
    {
        player thread points::doscoreevent( #"emp_grab" );
    }
    
    level.usestartspawns = 0;
    team = player.pers[ "team" ];
    
    if ( team == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    player.isbombcarrier = 1;
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
    
    if ( !isdefined( defused ) )
    {
        if ( self.firstpickup )
        {
            var_83c21091abe057b2 = "emppickup_friendly_first";
            self.firstpickup = 0;
        }
        else
        {
            var_83c21091abe057b2 = "emppickup_friendly";
        }
        
        dialog::leaderdialog( var_83c21091abe057b2, team, "bomb" );
        dialog::leaderdialog( "emppickup_enemy", otherteam, "bomb" );
        sound::playsoundonplayers( game[ "bomb_recovered_sound" ], team );
        skipplayers = teams::getteamdata( player.team, "players" );
        level thread hud_message::notifyteam( "emp_pickup", "emp_pickup_enemy", player.team, skipplayers );
        player thread hud_message::showsplash( "emp_pickup" );
        level thread hud_util::teamplayercardsplash( "callout_emppickup", player, player.team, undefined, 1 );
    }
    
    level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_c8adeffe7d960156", #"hash_5795d231e988aa4", player, #"hash_e015ff4fe81e2cfc" );
    self.offset3d = ( 0, 0, 85 );
    gameobjects::setownerteam( team );
    gameobjects::allowuse( "none" );
    
    if ( isdefined( level.showenemycarrier ) )
    {
        if ( level.showenemycarrier == 0 )
        {
            gameobjects::setvisibleteam( "friendly" );
            objective_state( self.pingobjidnum, "done" );
        }
        else
        {
            gameobjects::setvisibleteam( "friendly" );
            objective_state( self.pingobjidnum, "current" );
            gameobjects::updatecompassicon( "enemy", self.pingobjidnum );
            objective_icon( self.pingobjidnum, "icon_waypoint_kill" );
        }
    }
    
    gameobjects::setobjectivestatusicons( "icon_waypoint_escort_emp", "waypoint_capture_kill" );
    level.objectives[ team ] gameobjects::setvisibleteam( "none" );
    level.objectives[ otherteam ] gameobjects::setvisibleteam( "any" );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "allies" ].objidnum, 0 );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "axis" ].objidnum, 0 );
    telemetry_data = spawnstruct();
    telemetry_data.player = player;
    telemetry_data.eventname = "pickup";
    telemetry_data.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
}

// Namespace cyber
// Params 1
// Checksum 0xa1170876, Offset: 0x43fe
// Size: 0x1a6
function ondrop( player )
{
    self notify( #"emp_dropped" );
    setomnvar( "ui_bomb_carrier", -1 );
    
    if ( level.bombplanted )
    {
        gameobjects::setownerteam( player.team );
        gameobjects::allowuse( "none" );
    }
    else
    {
        foreach ( objective in level.objectives )
        {
            objective resetbombsite( 1 );
        }
        
        sound::playsoundonplayers( game[ "bomb_dropped_sound" ], gameobjects::getownerteam() );
        self.offset3d = ( 0, 0, 16 );
        gameobjects::allowuse( "any" );
        gameobjects::setobjectivestatusicons( "icon_waypoint_emp", "icon_waypoint_emp" );
        gameobjects::setownerteam( "neutral" );
        gameobjects::setvisibleteam( "any" );
        
        if ( isdefined( player ) )
        {
            print::printonteamarg( &"mp/explosives_dropped_by", gameobjects::getownerteam(), player );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_42726130fdbde172", #"hash_42726130fdbde172" );
        
        if ( level.idleresettime > 0 )
        {
            thread returnaftertime();
        }
    }
    
    if ( level.allowempweapon )
    {
        player inventory_utility::_takeweapon( "iw9_cyberemp_mp" );
        player inventory::switchtolastweapon();
    }
}

// Namespace cyber
// Params 0
// Checksum 0x46dddda2, Offset: 0x45ac
// Size: 0xd7
function returnaftertime()
{
    level endon( #"bomb_pickup" );
    currentwaittime = 0;
    
    while ( currentwaittime < level.idleresettime )
    {
        waitframe();
        
        if ( self.ownerteam == "neutral" )
        {
            currentwaittime += level.framedurationseconds;
        }
    }
    
    foreach ( team in level.teamnamelist )
    {
        sound::playsoundonplayers( game[ "bomb_dropped_sound" ], team );
    }
    
    gameobjects::returnhome();
}

// Namespace cyber
// Params 1
// Checksum 0x2b809e96, Offset: 0x468b
// Size: 0x730
function onuse( player )
{
    team = player.pers[ "team" ];
    otherteam = team_utility::getotherteam( team );
    
    if ( !gameobjects::isfriendlyteam( player.pers[ "team" ] ) && !level.bombplanted )
    {
        level thread empjamandrumbleclients( 0 );
        setomnvar( "ui_bomb_timer_endtime_a", int( gamelogic_mp::gettimeremaining() ) + gettime() );
        level notify( #"bomb_planted" );
        player notify( #"bomb_planted" );
        player notify( #"objective", "plant" );
        codcaster_utils::function_3038b6eafc46c037( 15, player.team, player getentitynumber() );
        skipplayers = [];
        skipplayers[ skipplayers.size ] = player;
        level thread hud_message::notifyteam( "emp_planted", "emp_planted_enemy", player.team, skipplayers );
        player thread hud_message::showsplash( "emp_planted", rank::getscoreinfovalue( #"plant" ) );
        level thread hud_util::teamplayercardsplash( "callout_empplanted", player, undefined, undefined, 1 );
        level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_2c480ffbc16191a9", #"hash_7a219ec4f9db8347" );
        player setclientomnvar( "ui_emp_carrier_hud", 0 );
        dialog::leaderdialog( "empplanted_friendly", team );
        player playsoundtoteam( "mp_bombplaced_friendly", team );
        dialog::leaderdialog( "empplanted_enemy", otherteam );
        player playsoundtoteam( "mp_bombplaced_enemy", otherteam );
        player thread points::doscoreevent( #"plant" );
        challenges::function_a3678ff124a05f01( player );
        telemetry_data = spawnstruct();
        telemetry_data.player = player;
        telemetry_data.eventname = "plant";
        telemetry_data.position = player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        player.bombplantedtime = gettime();
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "plants" ] ) )
            {
                player.leaderboarddata[ "plants" ] = player.leaderboarddata[ "plants" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "plants" ] ) )
            {
                [[ level.leaderboardfunc[ "plants" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
            
            if ( isdefined( player.pers[ "plants" ] ) )
            {
                player.pers[ "plants" ] = player.pers[ "plants" ] + 1;
            }
        }
        
        player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
        player persistence::statsetchild( "round", "plants", player.pers[ "plants" ] );
        player stats::setextrascore0( player.pers[ "plants" ] );
        level.bombplanted = 1;
        level thread bombplanted( self, player.pers[ "team" ] );
        level.bombowner = player;
        level.bombowner.isbombcarrier = 0;
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
        
        level.cyberemp gameobjects::setdropped();
        level.cyberemp gameobjects::allowuse( "none" );
        level.cyberemp gameobjects::setvisibleteam( "none" );
        
        if ( level.allowempweapon )
        {
            player inventory_utility::_takeweapon( "iw9_cyberemp_mp" );
            player inventory::switchtolastweapon();
        }
        
        self.useweapon = makeweapon( "iw9_cyberemp_defuse_mp" );
        setupfordefusing( self, player );
        return;
    }
    
    player notify( #"bomb_defused" );
    player notify( #"objective", "defuse" );
    defusedgameend = isenemyteameliminated( otherteam );
    
    if ( defusedgameend )
    {
        var_716398f132ef8480 = "empdefused_final_friendly";
        var_2207a2bffa6953d1 = "empdefused_final_enemy";
        level.var_71e380fabc40f094 = 1;
    }
    else
    {
        var_716398f132ef8480 = "empdefused_friendly";
        var_2207a2bffa6953d1 = "empdefused_enemy";
    }
    
    dialog::leaderdialog( var_716398f132ef8480, team );
    dialog::leaderdialog( var_2207a2bffa6953d1, otherteam );
    skipplayers = [];
    skipplayers[ skipplayers.size ] = player;
    level thread hud_message::notifyteam( "emp_defuse", "emp_defuse_enemy", player.team, skipplayers );
    level thread hud_util::teamplayercardsplash( "callout_empdefused", player, undefined, undefined, 1 );
    level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_c8adeffe7d960156", #"hash_5795d231e988aa4", player, #"hash_e015ff4fe81e2cfc" );
    
    if ( level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && player::isreallyalive( level.bombowner ) )
    {
        player thread points::doscoreevent( #"ninja_defuse" );
    }
    else
    {
        player thread points::doscoreevent( #"emp_defuse" );
    }
    
    player thread points::doscoreevent( #"mode_sd_defuse" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "defuses" ] ) )
        {
            player.leaderboarddata[ "defuses" ] = player.leaderboarddata[ "defuses" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "defuses" ] ) )
        {
            [[ level.leaderboardfunc[ "defuses" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
        
        if ( isdefined( player.pers[ "defuses" ] ) )
        {
            player.pers[ "defuses" ] = player.pers[ "defuses" ] + 1;
        }
    }
    
    player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    player persistence::statsetchild( "round", "defuses", player.pers[ "defuses" ] );
    player challenges::function_5f09e82f1ba9ce65();
    telemetry_data = spawnstruct();
    telemetry_data.player = player;
    telemetry_data.eventname = "defuse";
    telemetry_data.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    level.bombplanted = 0;
    level thread bombdefused( self );
    resetbombsite( 1, player );
    
    if ( defusedgameend )
    {
        wait 3;
    }
    
    level.cyberemp gameobjects::allowuse( "any" );
    level.cyberemp gameobjects::setpickedup( player, 0, 1 );
}

// Namespace cyber
// Params 2
// Checksum 0xcac90355, Offset: 0x4dc3
// Size: 0x121
function empjamandrumbleclients( rumble, endgame )
{
    foreach ( player in level.players )
    {
        player setempjammed( 1 );
        
        if ( rumble )
        {
            player playrumbleonpositionforclient( "artillery_rumble", player.origin );
        }
    }
    
    if ( !endgame )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            player setempjammed( 0 );
        }
    }
}

// Namespace cyber
// Params 3
// Checksum 0xef29af70, Offset: 0x4eec
// Size: 0xd0
function resetbombsite( defused, player, matchstart )
{
    if ( !defused )
    {
        gameobjects::setobjectivestatusicons( "icon_waypoint_planted_empsite", "icon_waypoint_target_empsite" );
        gameobjects::setvisibleteam( "any" );
        return;
    }
    
    if ( matchstart )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        self.ownerteam = player.team;
    }
    
    self.id = "bomb_zone";
    gameobjects::allowuse( "none" );
    gameobjects::setvisibleteam( "none" );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "allies" ].objidnum, 1 );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "axis" ].objidnum, 1 );
}

// Namespace cyber
// Params 0
// Checksum 0x91326eae, Offset: 0x4fc4
// Size: 0x9c
function setupforplanting()
{
    self.trigger enableplayeruse( level.cyberemp.carrier );
    gameobjects::allowuse( "enemy" );
    gameobjects::setusetime( level.planttime );
    gameobjects::setusetext( &"mp/planting_explosive" );
    gameobjects::setusehinttext( &"mp/hold_to_plant_emp" );
    gameobjects::setkeyobject( level.cyberemp );
    self.useweapon = makeweapon( "iw9_cyberemp_plant_mp" );
    gameobjects::setobjectivestatusicons( "icon_waypoint_defend_empsite", "icon_waypoint_target_empsite" );
    self.bombplanted = 0;
}

// Namespace cyber
// Params 2
// Checksum 0x9f323044, Offset: 0x5068
// Size: 0x222
function setupfordefusing( defuseobject, player )
{
    self.trigger setusepriority( -4 );
    self.ownerteam = player.team;
    gameobjects::allowuse( "enemy" );
    gameobjects::setusetime( level.defusetime );
    gameobjects::setusetext( &"mp/defusing_explosive" );
    gameobjects::setusehinttext( &"mp/hold_to_defuse_emp" );
    gameobjects::setkeyobject( undefined );
    gameobjects::setobjectivestatusicons( "icon_waypoint_defend_empsite_nt", "icon_waypoint_defuse_empsite_nt" );
    thread obj_bombzone::bombradialfill( player.team, "icon_waypoint_planted_empsite", "icon_waypoint_defuse_empsite" );
    gameobjects::setvisibleteam( "any", self.radialtimeobjid );
    self.id = "defuse_object";
    self.bombplanted = 1;
    [ defuseownerteam ] = team_utility::getenemyteams( player.team );
    
    foreach ( p in teams::getteamdata( defuseownerteam, "players" ) )
    {
        self.trigger enableplayeruse( p );
    }
    
    if ( level.scriptedsetup )
    {
        teammates = teams::getsquadmates( player.team );
        
        foreach ( mate in teammates )
        {
            self.trigger disableplayeruse( mate );
        }
    }
}

// Namespace cyber
// Params 1
// Checksum 0xc790fdad, Offset: 0x5292
// Size: 0x6d
function bombdefused( object )
{
    gamelogic_mp::resumetimer();
    level.timelimitoverride = 0;
    level.scorelimitoverride = 0;
    object.bombplanted = 0;
    setomnvar( "ui_bomb_owner_team", -1 );
    level thread [[ level.updategameevents ]]();
    object.visuals[ 0 ] gamelogic_mp::stoptickingsound();
    level notify( #"bomb_defused" );
}

// Namespace cyber
// Params 1
// Checksum 0x4e90e304, Offset: 0x5307
// Size: 0xc
function oncantuse( player )
{
    
}

// Namespace cyber
// Params 2
// Checksum 0x3095b8d0, Offset: 0x531b
// Size: 0x5b5
function bombplanted( destroyedobj, team )
{
    level endon( #"overtime" );
    gamelogic_mp::pausetimer();
    setomnvar( "ui_match_timer_stopped", 0 );
    level.bombplantedteam = team;
    level.timelimitoverride = 1;
    level.scorelimitoverride = 1;
    
    if ( isdefined( team ) )
    {
        if ( team == "allies" )
        {
            setomnvar( "ui_bomb_owner_team", 2 );
        }
        else
        {
            setomnvar( "ui_bomb_owner_team", 1 );
        }
    }
    
    setgameendtime( int( gettime() + level.bombtimer * 1000 ) );
    destroyedobj.visuals[ 0 ] thread gamelogic_mp::playtickingsound();
    starttime = gettime();
    thread bomb_pre_exp_music();
    thread bomb_pre_exp_sfx_wait( destroyedobj.visuals[ 0 ].origin );
    bombtimerwait();
    destroyedobj.visuals[ 0 ] gamelogic_mp::stoptickingsound();
    
    if ( !level.bombplanted )
    {
        if ( level.persbombtimer )
        {
            timepassed = ( gettime() - starttime ) / 1000;
            level.bombtimer -= timepassed;
        }
        
        return;
    }
    
    explosionorigin = destroyedobj.visuals[ 0 ].origin;
    level.bombexploded = 1;
    setdvar( @"ui_danger_team", "BombExploded" );
    
    if ( isdefined( level.bombowner ) )
    {
        destroyedobj.visuals[ 0 ] radiusdamage( explosionorigin, 512, 1, 1, level.bombowner, "MOD_EXPLOSIVE", "bomb_site_mp" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( level.bombowner ) ) )
        {
            if ( isdefined( level.bombowner.leaderboarddata[ "destructions" ] ) )
            {
                level.bombowner.leaderboarddata[ "destructions" ] = level.bombowner.leaderboarddata[ "destructions" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "destructions" ] ) )
            {
                [[ level.leaderboardfunc[ "destructions" ] ]]( level.bombowner, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
            
            if ( isdefined( level.bombowner.pers[ "destructions" ] ) )
            {
                level.bombowner.pers[ "destructions" ] = level.bombowner.pers[ "destructions" ] + 1;
            }
        }
        
        level.bombowner persistence::statsetchild( "round", "destructions", level.bombowner.pers[ "destructions" ] );
    }
    else
    {
        destroyedobj.visuals[ 0 ] radiusdamage( explosionorigin, 512, 1, 1, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );
    }
    
    playsoundatpos( explosionorigin, "iw9_exp_cyber_emp_close" );
    vfxorigin = destroyedobj.visuals[ 0 ] gettagorigin( "tag_origin" );
    explosioneffect = spawnfx( level._effect[ "emp_detonation" ], vfxorigin );
    triggerfx( explosioneffect );
    earthquake( 0.6, 1.5, explosionorigin, 10000 );
    destroyedobj.visuals[ 0 ] setmodel( "misc_carepackage_friendly_dmg" );
    level thread empjamandrumbleclients( 1, 1 );
    level notify( #"emp_detonated" );
    
    foreach ( objective in level.objectives )
    {
        objective notify( #"disabled" );
        objective.trigger usability::setallunusable();
    }
    
    if ( game[ "switchedsides" ] )
    {
        destroyedobj.exploderindex = 200;
    }
    else
    {
        destroyedobj.exploderindex = 201;
    }
    
    if ( isdefined( destroyedobj.exploderindex ) )
    {
        utility::exploder( destroyedobj.exploderindex );
    }
    
    destroyedobj.bombplanted = 0;
    level.cyberemp gameobjects::setvisibleteam( "none" );
    level.objectives[ "allies" ] gameobjects::setvisibleteam( "none" );
    level.objectives[ "axis" ] gameobjects::setvisibleteam( "none" );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "allies" ].objidnum, 0 );
    objidpoolmanager::function_1f589e274283d14a( level.objectives[ "axis" ].objidnum, 0 );
    setgameendtime( 0 );
    level.scorelimitoverride = 1;
    
    if ( isdefined( level.bombowner ) )
    {
        level thread hud_util::teamplayercardsplash( "callout_destroyed_cyberbombsite", level.bombowner );
    }
    
    destroyedobj gameobjects::releaseid();
    
    if ( level.nukeinfo.incoming )
    {
        return;
    }
    
    wait 3;
    thread gamelogic_mp::endgame( team, game[ "end_reason" ][ "target_destroyed" ], undefined, undefined, level.detonatescore );
}

// Namespace cyber
// Params 0
// Checksum 0x6b2ae32, Offset: 0x58d8
// Size: 0x62
function bombtimerwait()
{
    level endon( #"bomb_defused" );
    level endon( #"overtime_ended" );
    var_fc65cde94aa01b65 = int( level.bombtimer * 1000 + gettime() );
    setomnvar( "ui_bomb_timer_endtime", var_fc65cde94aa01b65 );
    level thread handlehostmigration( var_fc65cde94aa01b65 );
    hostmigration::waitlongdurationwithgameendtimeupdate( level.bombtimer );
}

// Namespace cyber
// Params 0
// Checksum 0x7c352d9b, Offset: 0x5942
// Size: 0x2d
function bomb_pre_exp_music()
{
    thread music_and_dialog::stopsuspensemusic();
    level callback::callback( #"music_event", { #event_type:#"bomb_planted" } );
}

// Namespace cyber
// Params 1
// Checksum 0xa72be253, Offset: 0x5977
// Size: 0x46
function bomb_pre_exp_sfx_wait( sfx_org )
{
    level endon( #"bomb_defused" );
    level endon( #"overtime_ended" );
    wait max( level.bombtimer - 2, 0.1 );
    playsoundatpos( sfx_org, "iw9_exp_cyber_emp_preexplode" );
}

// Namespace cyber
// Params 1
// Checksum 0xb0b74f97, Offset: 0x59c5
// Size: 0x70
function handlehostmigration( var_fc65cde94aa01b65 )
{
    level endon( #"bomb_defused" );
    level endon( #"overtime_ended" );
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level waittill( #"host_migration_begin" );
    timepassed = hostmigration::waittillhostmigrationdone();
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_bomb_timer_endtime", var_fc65cde94aa01b65 + timepassed );
    }
}

// Namespace cyber
// Params 1
// Checksum 0x2b766d77, Offset: 0x5a3d
// Size: 0x34
function overtimethread( time )
{
    level endon( #"game_ended" );
    level.inovertime = 1;
    wait 5;
    level.disablespawning = 1;
}

// Namespace cyber
// Params 0
// Checksum 0x7c1eb4f9, Offset: 0x5a79
// Size: 0x90
function givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( "last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( "last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
}

// Namespace cyber
// Params 0
// Checksum 0xfc6a90ea, Offset: 0x5b11
// Size: 0x2f
function ontimelimit()
{
    if ( level.bombexploded )
    {
        return;
    }
    
    function_a055a471e094ad55();
    thread gamelogic_mp::endgame( "tie", game[ "end_reason" ][ "cyber_tie" ] );
}

// Namespace cyber
// Params 1
// Checksum 0xde25aeb6, Offset: 0x5b48
// Size: 0xe5
function onspawnplayer( revivespawn )
{
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_securing_progress", 0 );
    hud_message::function_ef4318a0090caa0f( #"hide_match_hint" );
    
    if ( level.multibomb )
    {
        self setclientomnvar( "ui_emp_carrier_hud", 1 );
    }
    else
    {
        self setclientomnvar( "ui_emp_carrier_hud", 0 );
        thread updatebombsiteusability();
    }
    
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    
    if ( game_utility_mp::inovertime() && !isdefined( self.otspawned ) )
    {
        thread printothint();
    }
    
    stats::setextrascore0( self.pers[ "plants" ] ?? 0, "plants" );
    stats::setextrascore1( self.pers[ "rescues" ] ?? 0, "rescues" );
    thread updatematchstatushintonspawn();
}

// Namespace cyber
// Params 0
// Checksum 0x832b24d7, Offset: 0x5c35
// Size: 0xae
function updatebombsiteusability()
{
    if ( !isdefined( level.objectives ) )
    {
        level waittill( #"hash_2ed90cfccb18c373" );
    }
    
    foreach ( bombzone in level.objectives )
    {
        if ( bombzone.bombplanted == 0 )
        {
            bombzone.trigger disableplayeruse( self );
        }
    }
}

// Namespace cyber
// Params 0
// Checksum 0x76b7f959, Offset: 0x5ceb
// Size: 0xf9
function updatematchstatushintonspawn()
{
    if ( level.bombplanted )
    {
        if ( level.bombplantedteam == self.team )
        {
            hud_message::function_ef4318a0090caa0f( #"hash_2c480ffbc16191a9" );
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"hash_7a219ec4f9db8347" );
        }
        
        return;
    }
    
    if ( isdefined( level.cyberemp ) && isdefined( level.cyberemp.carrier ) )
    {
        if ( level.cyberemp.carrier.team == self.team )
        {
            if ( level.cyberemp.carrier == self )
            {
                hud_message::function_ef4318a0090caa0f( #"hash_e015ff4fe81e2cfc" );
            }
            else
            {
                hud_message::function_ef4318a0090caa0f( #"hash_c8adeffe7d960156" );
            }
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"hash_5795d231e988aa4" );
        }
        
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"hash_42726130fdbde172" );
}

// Namespace cyber
// Params 0
// Checksum 0xd1a55289, Offset: 0x5dec
// Size: 0x80
function function_a055a471e094ad55()
{
    foreach ( player in level.players )
    {
        if ( interruptbombplanting( player ) )
        {
            break;
        }
    }
}

// Namespace cyber
// Params 1
// Checksum 0x687813ff, Offset: 0x5e74
// Size: 0x42, Type: bool
function interruptbombplanting( player )
{
    if ( player.isplanting && isdefined( player.lastnonuseweapon ) )
    {
        player inventory_utility::_switchtoweaponimmediate( player.lastnonuseweapon );
        return true;
    }
    
    return false;
}

// Namespace cyber
// Params 1
// Checksum 0xba46e26d, Offset: 0x5ebf
// Size: 0x148
function ondeadevent( team )
{
    function_a055a471e094ad55();
    
    if ( level.bombexploded > 0 && !level.postgameexfil )
    {
        return;
    }
    
    if ( team == "all" )
    {
        if ( level.bombplanted )
        {
            otherteam = team_utility::getotherteam( level.bombplantedteam );
            thread gamelogic_mp::endgame( level.bombplantedteam, game[ "end_reason" ][ "mp_faction_eliminated" ], undefined, undefined, level.detonatescore );
        }
        else
        {
            thread gamelogic_mp::endgame( "tie", game[ "end_reason" ][ "tie" ] );
        }
        
        return;
    }
    
    if ( level.bombplanted )
    {
        if ( team != level.bombplantedteam )
        {
            thread gamelogic_mp::endgame( level.bombplantedteam, game[ "end_reason" ][ "mp_faction_eliminated" ], undefined, undefined, level.detonatescore );
        }
        else
        {
            return;
        }
        
        return;
    }
    
    if ( team == game[ "attackers" ] )
    {
        level thread gamelogic_mp::endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        level thread gamelogic_mp::endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace cyber
// Params 1
// Checksum 0x62c49ba7, Offset: 0x600f
// Size: 0x4c
function ononeleftevent( team )
{
    if ( level.bombexploded > 0 )
    {
        return;
    }
    
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    
    if ( isdefined( lastplayer ) )
    {
        lastplayer.laststanding = 1;
        lastplayer thread givelastonteamwarning();
    }
}

// Namespace cyber
// Params 1
// Checksum 0x8db49eb9, Offset: 0x6063
// Size: 0x168
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    idamage = deathdata.damage;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    vdir = deathdata.direction_vec;
    shitloc = deathdata.hitloc;
    psoffsettime = deathdata.psoffsettime;
    deathanimduration = deathdata.deathanimduration;
    killid = deathdata.lifeid;
    victim setclientomnvar( "ui_emp_carrier_hud", 0 );
    thread checkallowspectating();
    
    if ( !isplayer( attacker ) || attacker.team == victim.team )
    {
        return;
    }
    
    if ( victim.isbombcarrier && level.codcasterenabled )
    {
        victim setgametypevip( 0 );
    }
    
    victim awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
}

// Namespace cyber
// Params 0
// Checksum 0xb0af1622, Offset: 0x61d3
// Size: 0x8c
function checkallowspectating()
{
    waitframe();
    update = 0;
    
    if ( !teams::getteamdata( game[ "attackers" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "attackers" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( !teams::getteamdata( game[ "defenders" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "defenders" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( update )
    {
        spectating::updatespectatesettings();
    }
}

// Namespace cyber
// Params 6
// Checksum 0x564dd3e2, Offset: 0x6267
// Size: 0x1c1
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( victim.isplanting )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "planting" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        return;
    }
    
    if ( victim.isbombcarrier )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "carrying" );
        return;
    }
    
    if ( victim.isdefusing )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "defusing" );
    }
}

// Namespace cyber
// Params 0
// Checksum 0x9e1565f, Offset: 0x6430
// Size: 0x1f
function printothint()
{
    self endon( #"disconnect" );
    wait 0.25;
    self.otspawned = 1;
}

// Namespace cyber
// Params 10
// Checksum 0x893718c8, Offset: 0x6457
// Size: 0x5f4
function awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    victim = self;
    victimpos = victim.origin;
    attackerpos = attacker.origin;
    attackerisinflictor = 0;
    
    if ( isdefined( einflictor ) )
    {
        attackerpos = einflictor.origin;
        attackerisinflictor = einflictor == attacker;
    }
    
    if ( isdefined( level.cyberemp.carrier ) )
    {
        if ( isplayer( attacker ) && attacker.pers[ "team" ] != victim.pers[ "team" ] )
        {
            if ( isdefined( attacker.isbombcarrier ) && isdefined( objweapon ) && attackerisinflictor && objweapon.basename == "iw9_cyberemp_mp" )
            {
                attacker thread rank::scoreeventpopup( #"emp_carrier_kill" );
                attacker thread points::doscoreevent( #"mode_cyber_kill_with_emp" );
            }
            else if ( victim.isbombcarrier )
            {
                victim.isbombcarrier = 0;
                
                if ( victim.showempminimap )
                {
                    victim player::hideminimap();
                }
                
                attacker thread rank::scoreeventpopup( #"killed_emp_carrier" );
                attacker thread points::doscoreevent( #"mode_cyber_kill_carrier" );
                thread utility::trycall( level.matchdata_logvictimkillevent, killid, "carrying" );
            }
            
            if ( attacker.pers[ "team" ] == level.cyberemp.ownerteam && attacker != level.cyberemp.carrier )
            {
                var_56aca49aacdd2f85 = distancesquared( level.cyberemp.carrier.origin, attackerpos );
                
                if ( var_56aca49aacdd2f85 < 105625 )
                {
                    attacker thread rank::scoreeventpopup( #"defend" );
                    attacker events::function_20a5f572df6afd43();
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                        {
                            attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                        {
                            [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
                        
                        if ( isdefined( attacker.pers[ "defends" ] ) )
                        {
                            attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                        }
                    }
                    
                    attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                    thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                }
            }
        }
    }
    
    foreach ( bombzone in level.objectives )
    {
        if ( bombzone.trigger.trigger_off )
        {
            continue;
        }
        
        ownerteam = bombzone gameobjects::getownerteam();
        
        if ( ownerteam != attacker.team )
        {
            giveassault = distsquaredcheck( bombzone.trigger, attackerpos, victimpos );
            
            if ( giveassault )
            {
                attacker thread rank::scoreeventpopup( #"assault" );
                attacker events::function_58da673c1c3fc9f2();
                bombzone notify( #"assault", attacker );
                thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                continue;
            }
            
            continue;
        }
        
        givedefend = distsquaredcheck( bombzone.trigger, attackerpos, victimpos );
        
        if ( givedefend )
        {
            attacker thread rank::scoreeventpopup( #"defend" );
            attacker events::function_20a5f572df6afd43();
            bombzone notify( #"defend", attacker );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                {
                    attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                {
                    [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
                
                if ( isdefined( attacker.pers[ "defends" ] ) )
                {
                    attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                }
            }
            
            attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
            thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
        }
    }
}

// Namespace cyber
// Params 3
// Checksum 0xc2011b91, Offset: 0x6a53
// Size: 0xc3
function distsquaredcheck( trigger, attackerpos, victimpos )
{
    var_239d2a4c215037cd = distancesquared( trigger.origin, attackerpos );
    var_675b1291697b281a = distancesquared( trigger.origin, victimpos );
    
    if ( var_239d2a4c215037cd < 105625 || var_675b1291697b281a < 105625 )
    {
        if ( !isdefined( trigger.modifieddefendcheck ) )
        {
            return 1;
        }
        else if ( attackerpos[ 2 ] - trigger.origin[ 2 ] < 100 || victimpos[ 2 ] - trigger.origin[ 2 ] < 100 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace cyber
// Params 0
// Checksum 0xa5be794d, Offset: 0x6b1e
// Size: 0x9
function function_f219e66c55b6101c()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace cyber
// Params 0
// Checksum 0xf0e69f25, Offset: 0x6b2f
// Size: 0x11f
function empradarwatcher()
{
    level endon( #"game_ended" );
    level endon( #"bomb_dropped" );
    self endon( #"death_or_disconnect" );
    self endon( #"bomb_planted" );
    self endon( #"last_stand_enter" );
    self endon( #"emp_dropped" );
    
    if ( level.allowempweapon )
    {
        thread weaponswapwatcher();
    }
    
    while ( isdefined( level.cyberemp.carrier ) && self == level.cyberemp.carrier )
    {
        waitframe();
        
        if ( level.allowempweapon && self.currentprimaryweapon.basename != "iw9_cyberemp_mp" )
        {
            continue;
        }
        
        if ( !isdefined( self.nextradarpingtime ) || gettime() > self.nextradarpingtime )
        {
            if ( level.allowempweapon )
            {
                triggeroneoffradarsweep( self );
            }
            else
            {
                triggerportableradarping( self.origin, self, 1000 );
            }
            
            self.nextradarpingtime = gettime() + level.radarpingtime * 1000;
        }
    }
}

// Namespace cyber
// Params 0
// Checksum 0x26584d40, Offset: 0x6c56
// Size: 0x94
function weaponswapwatcher()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"bomb_planted" );
    self.showempminimap = 0;
    
    while ( true )
    {
        if ( self.currentprimaryweapon.basename == "iw9_cyberemp_mp" )
        {
            if ( !self.showempminimap )
            {
                player::showminimap();
                self.showempminimap = 1;
            }
        }
        else if ( self.showempminimap )
        {
            player::hideminimap();
            self.showempminimap = 0;
        }
        
        waitframe();
    }
}

// Namespace cyber
// Params 0
// Checksum 0x6089c2e, Offset: 0x6cf2
// Size: 0xd2
function applybombcarrierclass()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self.iscarrying == 1 )
    {
        self notify( #"force_cancel_placement" );
        waitframe();
    }
    
    while ( self ismantling() )
    {
        waitframe();
    }
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.pers[ "gamemodeLoadout" ] = level.cyber_loadouts[ self.team ];
    playerlogic::spawnpoint_setspawnpoint( self.origin, self.angles );
    self.gamemode_chosenclass = self.class;
    class::function_e84a99f0f4904c66();
    self notify( #"faux_spawn" );
    self.gameobject_fauxspawn = 1;
    self.faux_spawn_stance = self getstance();
    thread playerlogic::spawnplayer( 1 );
}

// Namespace cyber
// Params 0
// Checksum 0x921dd932, Offset: 0x6dcc
// Size: 0xa7
function removebombcarrierclass()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self.iscarrying == 1 )
    {
        self notify( #"force_cancel_placement" );
        waitframe();
    }
    
    while ( self ismantling() )
    {
        waitframe();
    }
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self notify( #"lost_juggernaut" );
    waitframe();
    self.pers[ "gamemodeLoadout" ] = undefined;
    playerlogic::spawnpoint_setspawnpoint( self.origin, self.angles );
    self notify( #"faux_spawn" );
    self.faux_spawn_stance = self getstance();
    thread playerlogic::spawnplayer( 1 );
}

// Namespace cyber
// Params 0
// Checksum 0xcac84cea, Offset: 0x6e7b
// Size: 0x2ab
function setcarriervisibility()
{
    if ( isdefined( level.showenemycarrier ) )
    {
        switch ( level.showenemycarrier )
        {
            case 0:
                level.cyberemp.objidpingfriendly = 1;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 0;
                break;
            case 1:
                level.cyberemp.objidpingfriendly = 0;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 0.05;
                break;
            case 2:
                level.cyberemp.objidpingfriendly = 1;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 1;
                break;
            case 3:
                level.cyberemp.objidpingfriendly = 1;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 1.5;
                break;
            case 4:
                level.cyberemp.objidpingfriendly = 1;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 2;
                break;
            case 5:
                level.cyberemp.objidpingfriendly = 1;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 3;
                break;
            case 6:
                level.cyberemp.objidpingfriendly = 1;
                level.cyberemp.objidpingenemy = 0;
                level.cyberemp.objpingdelay = 4;
                break;
        }
        
        return;
    }
    
    level.cyberemp.objidpingfriendly = 1;
    level.cyberemp.objidpingenemy = 0;
    level.cyberemp.objpingdelay = 3;
}

// Namespace cyber
// Params 0
// Checksum 0x406505df, Offset: 0x712e
// Size: 0xfe
function onexfilstarted()
{
    level.cyberemp gameobjects::releaseid();
    
    if ( isdefined( level.cyberemp.carrier ) )
    {
        foreach ( empsite in level.objectives )
        {
            if ( empsite.bombplanted == 0 )
            {
                empsite.trigger disableplayeruse( level.cyberemp.carrier );
            }
        }
    }
    
    level.cyberemp.trigger delete();
    level.cyberemp.visuals[ 0 ] delete();
}

// Namespace cyber
// Params 0
// Checksum 0x77f99551, Offset: 0x7234
// Size: 0x2cd
function emplightsoff()
{
    level endon( #"game_ended" );
    level waittill( #"emp_detonated" );
    
    while ( true )
    {
        foreach ( struct in level.emplights )
        {
            struct.switchstatus = "off";
            handleemponoff( struct );
        }
        
        wait 0.1;
        
        foreach ( struct in level.emplights )
        {
            struct.switchstatus = "on";
            handleemponoff( struct );
        }
        
        wait 0.15;
        
        foreach ( struct in level.emplights )
        {
            struct.switchstatus = "off";
            handleemponoff( struct );
        }
        
        wait 0.1;
        
        foreach ( struct in level.emplights )
        {
            struct.switchstatus = "on";
            handleemponoff( struct, 0.05 );
        }
        
        wait 0.5;
        
        foreach ( struct in level.emplights )
        {
            struct.switchstatus = "off";
            handleemponoff( struct );
        }
        
        wait 10;
    }
}

// Namespace cyber
// Params 0
// Checksum 0x65542f64, Offset: 0x7509
// Size: 0x13b
function destroytvs()
{
    level endon( #"game_ended" );
    level waittill( #"emp_detonated" );
    tvs = getentarray( "destructibleTVs", #script_noteworthy );
    
    foreach ( tv in tvs )
    {
        var_612518203a64aa6c = getscriptablearray( tv.target, #targetname );
        
        foreach ( stv in var_612518203a64aa6c )
        {
            stv setscriptablepartstate( "tv", "dead" );
            waitframe();
        }
    }
}

// Namespace cyber
// Params 2
// Checksum 0xcea6b59a, Offset: 0x764c
// Size: 0x18e
function handleemponoff( struct, timeoverride )
{
    timedelay = 0.2;
    
    if ( isdefined( timeoverride ) )
    {
        timedelay = timeoverride;
    }
    
    if ( struct.switchstatus == "on" )
    {
        self notify( #"masterswitch_on" );
        
        if ( !struct.lightson )
        {
            foreach ( light in struct.lights )
            {
                light thread motiondetectors::lightonroutine( randomfloat( timedelay ) );
            }
            
            thread motiondetectors::onoffmodelswap( struct.models, "on" );
            struct.lightson = 1;
        }
        
        return;
    }
    
    if ( struct.switchstatus == "off" )
    {
        if ( struct.lightson )
        {
            level motiondetectors::lightoffroutine( struct.lights );
            thread motiondetectors::onoffmodelswap( struct.models, "off" );
            struct.lightson = 0;
        }
        
        if ( self.script_parameters == "motion" )
        {
            struct.switchstatus = "motion";
        }
        
        self notify( #"lights_off" );
    }
}

// Namespace cyber
// Params 1
// Checksum 0x86d3ba77, Offset: 0x77e2
// Size: 0x42
function onempdropped( player )
{
    if ( !level.bombplanted )
    {
        level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_42726130fdbde172" );
    }
    
    player setclientomnvar( "ui_emp_carrier_hud", 0 );
}

// Namespace cyber
// Params 0
// Checksum 0xcc84a729, Offset: 0x782c
// Size: 0x18e
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_emp", 2, "neutral", "MP_INGAME_ONLY/OBJ_EMP_CAPS", "ui_rex_icon_obj_emp", 0, 10 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_escort_emp", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "ui_rex_icon_obj_emp", 0, 10 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_defend_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0, 3 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_target_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_ATTACK_CAPS", "icon_waypoint_cyber_bombsite", 0, 3 );
    
    if ( level.gamemodebundle.var_4dc63b2cff079d78 )
    {
        gamelogic_mp::setwaypointiconinfo( "icon_waypoint_planted_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_PROTECT_CAPS", "icon_waypoint_cyber_bombsite", 0, 4 );
    }
    else
    {
        gamelogic_mp::setwaypointiconinfo( "icon_waypoint_planted_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0, 4 );
    }
    
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_defuse_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_cyber_bombsite", 0, 4 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_emp_planting", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_cyber_bombsite", 0, 3 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_emp_defusing", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_cyber_bombsite", 0, 4 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_defend_empsite_nt", 0, "friendly", "", "icon_waypoint_cyber_bombsite", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_defuse_empsite_nt", 0, "enemy", "", "icon_waypoint_cyber_bombsite", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "mlg_icon_waypoint_emp_planted", 0, "neutral", "", "icon_minimap_objective_codcaster_bomb", 0, undefined );
}

/#

    // Namespace cyber
    // Params 0
    // Checksum 0x59e9bdfd, Offset: 0x79c2
    // Size: 0xcc, Type: dev
    function function_be9a98d6817ff396()
    {
        level endon( #"game_ended" );
        self notify( #"hash_f2e083d1e21845d1" );
        self endon( #"hash_f2e083d1e21845d1" );
        self endon( #"disconnect" );
        wait 5;
        
        while ( !level.bombplanted )
        {
            if ( getdvarint( @"scr_drop_emp", 0 ) == 1 )
            {
                if ( isdefined( level.cyberemp.carrier ) )
                {
                    level.cyberemp.carrier.carryobject thread gameobjects::setdropped();
                    setdevdvar( @"scr_drop_emp", 0 );
                    break;
                }
            }
            
            wait 1;
        }
        
        if ( level.bombplanted )
        {
            level waittill( #"bomb_defused" );
        }
        
        thread function_be9a98d6817ff396();
    }

    // Namespace cyber
    // Params 0
    // Checksum 0x3cf6f5be, Offset: 0x7a96
    // Size: 0x2a9, Type: dev
    function function_f9e6f27c5a64ceb8()
    {
        level endon( #"game_ended" );
        self notify( #"hash_188db3eeb1319724" );
        self endon( #"hash_188db3eeb1319724" );
        self endon( #"disconnect" );
        wait 5;
        
        while ( !level.bombplanted )
        {
            if ( getdvarint( @"scr_plant_allies", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:x1f4>" )
                    {
                        level.cyberemp.safeorigin = level.cyberemp.trigger.origin;
                        level.cyberemp.carrier = p;
                        level.objectives[ "<dev string:x1fb>" ] [[ level.objectives[ "<dev string:x1fb>" ].onuse ]]( p );
                        setdevdvar( @"scr_plant_allies", 0 );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"scr_plant_axis", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:x1fb>" )
                    {
                        level.cyberemp.safeorigin = level.cyberemp.trigger.origin;
                        level.cyberemp.carrier = p;
                        level.objectives[ "<dev string:x1f4>" ] [[ level.objectives[ "<dev string:x1f4>" ].onuse ]]( p );
                        setdevdvar( @"scr_plant_axis", 0 );
                        break;
                    }
                }
            }
            
            wait 1;
        }
        
        level waittill( #"bomb_defused" );
        thread function_f9e6f27c5a64ceb8();
    }

    // Namespace cyber
    // Params 0
    // Checksum 0xaa2cee1d, Offset: 0x7d47
    // Size: 0x21a, Type: dev
    function function_69aae105718a70a3()
    {
        level endon( #"game_ended" );
        self notify( #"hash_2ea2c62a82add2d9" );
        self endon( #"hash_2ea2c62a82add2d9" );
        self endon( #"disconnect" );
        wait 5;
        
        while ( level.bombplanted )
        {
            if ( getdvarint( @"scr_defuse_allies", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:x1f4>" )
                    {
                        level.objectives[ "<dev string:x1f4>" ] [[ level.objectives[ "<dev string:x1f4>" ].onuse ]]( p );
                        setdevdvar( @"scr_defuse_allies", 0 );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"scr_defuse_axis", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:x1fb>" )
                    {
                        level.objectives[ "<dev string:x1fb>" ] [[ level.objectives[ "<dev string:x1fb>" ].onuse ]]( p );
                        setdevdvar( @"scr_defuse_axis", 0 );
                        break;
                    }
                }
            }
            
            wait 1;
        }
        
        level waittill( #"bomb_planted" );
        thread function_69aae105718a70a3();
    }

    // Namespace cyber
    // Params 0
    // Checksum 0xd28d0dc, Offset: 0x7f69
    // Size: 0x167, Type: dev
    function function_8080aef11830a2bc()
    {
        level endon( #"game_ended" );
        wait 1;
        team = "<dev string:x1f4>";
        
        while ( getdvarint( @"hash_d51785ab78729b60", 0 ) == 1 )
        {
            explosionorigin = level.objectives[ team ].visuals[ 0 ] gettagorigin( "<dev string:x200>" );
            level.objectives[ team ].visuals[ 0 ] radiusdamage( explosionorigin, 512, 1, 1, undefined, "<dev string:x20b>", "<dev string:x219>" );
            playsoundatpos( explosionorigin, "<dev string:x226>" );
            rot = randomfloat( 360 );
            explosioneffect = spawnfx( level._effect[ "<dev string:x23e>" ], explosionorigin + ( 0, 0, 50 ), ( 0, 0, 1 ), ( cos( rot ), sin( rot ), 0 ) );
            triggerfx( explosioneffect );
            playrumbleonposition( "<dev string:x24d>", explosionorigin );
            earthquake( 0.6, 1.5, explosionorigin, 10000 );
            level thread empjamandrumbleclients( 1 );
            
            if ( game[ "<dev string:x25e>" ] )
            {
                exploderindex = 200;
            }
            else
            {
                exploderindex = 201;
            }
            
            if ( isdefined( exploderindex ) )
            {
                utility::exploder( exploderindex );
            }
            
            wait 5;
        }
        
        wait 1;
        thread function_8080aef11830a2bc();
    }

    // Namespace cyber
    // Params 0
    // Checksum 0xfa725937, Offset: 0x80d8
    // Size: 0x167, Type: dev
    function function_e5188375b6d0bfbf()
    {
        level endon( #"game_ended" );
        wait 1;
        team = "<dev string:x1fb>";
        
        while ( getdvarint( @"hash_4d5720fef87ec87b", 0 ) == 1 )
        {
            explosionorigin = level.objectives[ team ].visuals[ 0 ] gettagorigin( "<dev string:x200>" );
            level.objectives[ team ].visuals[ 0 ] radiusdamage( explosionorigin, 512, 1, 1, undefined, "<dev string:x20b>", "<dev string:x219>" );
            playsoundatpos( explosionorigin, "<dev string:x226>" );
            rot = randomfloat( 360 );
            explosioneffect = spawnfx( level._effect[ "<dev string:x23e>" ], explosionorigin + ( 0, 0, 50 ), ( 0, 0, 1 ), ( cos( rot ), sin( rot ), 0 ) );
            triggerfx( explosioneffect );
            playrumbleonposition( "<dev string:x24d>", explosionorigin );
            earthquake( 0.6, 1.5, explosionorigin, 10000 );
            level thread empjamandrumbleclients( 1 );
            
            if ( game[ "<dev string:x25e>" ] )
            {
                exploderindex = 201;
            }
            else
            {
                exploderindex = 200;
            }
            
            if ( isdefined( exploderindex ) )
            {
                utility::exploder( exploderindex );
            }
            
            wait 5;
        }
        
        wait 1;
        thread function_e5188375b6d0bfbf();
    }

#/

// Namespace cyber
// Params 0, eflags: 0x4
// Checksum 0x9b044242, Offset: 0x8247
// Size: 0x888
function private function_641684784f5044ff()
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return;
    }
    
    if ( !level.multibomb )
    {
        bomb_triggers = getentarray( "cyber_emp_pickup_trig", #targetname );
        assert( isdefined( bomb_triggers ) && bomb_triggers.size != 0, "<dev string:x26c>" );
        
        if ( level.empspawnindex == 3 )
        {
            if ( isdefined( game[ "empSpawn" ] ) )
            {
                for ( i = 0; i < bomb_triggers.size ; i++ )
                {
                    if ( i != game[ "empSpawn" ] )
                    {
                        if ( !isdefined( rand_array ) )
                        {
                            rand_array = [];
                        }
                        
                        rand_array[ rand_array.size ] = i;
                    }
                    
                    level.empspawnindex = utility::array_random( rand_array );
                }
            }
            else
            {
                level.empspawnindex = randomintrange( 0, bomb_triggers.size );
            }
        }
        else if ( level.empspawnindex == 4 )
        {
            if ( isdefined( game[ "empSpawn" ] ) )
            {
                level.empspawnindex = game[ "empSpawn" ] + 1;
                
                if ( level.empspawnindex == bomb_triggers.size )
                {
                    level.empspawnindex = 0;
                }
            }
            else
            {
                level.empspawnindex = 0;
            }
        }
        
        game[ "empSpawn" ] = level.empspawnindex;
        bomb_trigger = bomb_triggers[ level.empspawnindex ];
        bomb_trigger.donotdelete = 1;
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = bomb_trigger.origin;
        var_24290c36e2cab388.angles = bomb_trigger.angles;
        gameobjects_common::initialize_game_object( bomb_trigger.targetname, var_24290c36e2cab388, bomb_trigger, &function_eb2a9f2ae9018f2d );
    }
    
    var_c24772dc70cc0031 = getentarray( "cyber_empzone_allies", #targetname );
    assert( !isdefined( var_c24772dc70cc0031 ) || var_c24772dc70cc0031.size != 0, "<dev string:x28b>" + "<dev string:x292>" + "<dev string:x2a7>" );
    var_c13dd24cfdaa692d = getentarray( "cyber_empzone_axis", #targetname );
    assert( !isdefined( var_c13dd24cfdaa692d ) || var_c13dd24cfdaa692d.size != 0, "<dev string:x28b>" + "<dev string:x2bf>" + "<dev string:x2a7>" );
    var_d66e32696a1a7f8c = getentarray( "cyber_emp_defuse_allies", #targetname );
    assert( !isdefined( var_d66e32696a1a7f8c ) || var_d66e32696a1a7f8c.size != 0, "<dev string:x28b>" + "<dev string:x2d2>" + "<dev string:x2a7>" );
    var_eb893b0ece5ade30 = getentarray( "cyber_emp_defuse_axis", #targetname );
    assert( !isdefined( var_eb893b0ece5ade30 ) || var_eb893b0ece5ade30.size != 0, "<dev string:x28b>" + "<dev string:x2ea>" + "<dev string:x2a7>" );
    var_c24772dc70cc0031[ 0 ].donotdelete = 1;
    var_c13dd24cfdaa692d[ 0 ].donotdelete = 1;
    var_d66e32696a1a7f8c[ 0 ].donotdelete = 1;
    var_eb893b0ece5ade30[ 0 ].donotdelete = 1;
    game_utility_mp::clean_up_entities();
    var_6f0815c7a46a5120 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    var_6f0815c7a46a5120.origin = var_c24772dc70cc0031[ 0 ].origin;
    var_6f0815c7a46a5120.angles = var_c24772dc70cc0031[ 0 ].angles;
    var_6f0815c7a46a5120.var_c68e9f43ed9cc918 = #"hash_ce911e3bbe99421f";
    var_6f0815c7a46a5120.use_time_seconds = level.planttime;
    gameobjects_common::initialize_game_object( var_c24772dc70cc0031[ 0 ].targetname, var_6f0815c7a46a5120, var_c24772dc70cc0031[ 0 ], &function_53d5a8d65ee1ab77, #"hash_7118f9343873352b" );
    var_94f23465f1e5041e = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    var_94f23465f1e5041e.origin = var_d66e32696a1a7f8c[ 0 ].origin;
    var_94f23465f1e5041e.angles = var_d66e32696a1a7f8c[ 0 ].angles;
    var_94f23465f1e5041e.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
    var_94f23465f1e5041e.use_time_seconds = level.defusetime;
    gameobjects_common::initialize_game_object( var_d66e32696a1a7f8c[ 0 ].targetname, var_94f23465f1e5041e, var_d66e32696a1a7f8c[ 0 ], &function_57a3bfd87f9b58c1, #"hash_7118f9343873352b" );
    var_cc642a89bc32990c = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    var_cc642a89bc32990c.origin = var_c13dd24cfdaa692d[ 0 ].origin;
    var_cc642a89bc32990c.angles = var_c13dd24cfdaa692d[ 0 ].angles;
    var_cc642a89bc32990c.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
    var_cc642a89bc32990c.use_time_seconds = level.planttime;
    gameobjects_common::initialize_game_object( var_c13dd24cfdaa692d[ 0 ].targetname, var_cc642a89bc32990c, var_c13dd24cfdaa692d[ 0 ], &function_53d5a8d65ee1ab77, #"hash_ce911e3bbe99421f" );
    var_51f8408b3584a1ea = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    var_51f8408b3584a1ea.origin = var_eb893b0ece5ade30[ 0 ].origin;
    var_51f8408b3584a1ea.angles = var_eb893b0ece5ade30[ 0 ].angles;
    var_51f8408b3584a1ea.var_c68e9f43ed9cc918 = #"hash_ce911e3bbe99421f";
    var_51f8408b3584a1ea.use_time_seconds = level.defusetime;
    gameobjects_common::initialize_game_object( var_eb893b0ece5ade30[ 0 ].targetname, var_51f8408b3584a1ea, var_eb893b0ece5ade30[ 0 ], &function_57a3bfd87f9b58c1, #"hash_ce911e3bbe99421f" );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xfc45ff2f, Offset: 0x8ad7
// Size: 0x10c
function private function_be2de377ce070e51( game_object_struct_array )
{
    if ( level.empspawnindex == 3 )
    {
        if ( isdefined( game[ "empSpawn" ] ) && game_object_struct_array.size > 1 )
        {
            for ( i = 0; i < game_object_struct_array.size ; i++ )
            {
                if ( i != game[ "empSpawn" ] )
                {
                    if ( !isdefined( rand_array ) )
                    {
                        rand_array = [];
                    }
                    
                    rand_array[ rand_array.size ] = i;
                }
                
                level.empspawnindex = utility::array_random( rand_array );
            }
        }
        else
        {
            level.empspawnindex = randomintrange( 0, game_object_struct_array.size );
        }
    }
    else if ( level.empspawnindex == 4 )
    {
        if ( isdefined( game[ "empSpawn" ] ) )
        {
            level.empspawnindex = game[ "empSpawn" ] + 1;
            
            if ( level.empspawnindex == game_object_struct_array.size )
            {
                level.empspawnindex = 0;
            }
        }
        else
        {
            level.empspawnindex = 0;
        }
    }
    
    game[ "empSpawn" ] = level.empspawnindex;
    return [ game_object_struct_array[ level.empspawnindex ] ];
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xc3065d42, Offset: 0x8bec
// Size: 0x1dc
function private function_eb2a9f2ae9018f2d( game_object )
{
    game_object_origin = gameobjects_shared::get_origin( game_object );
    
    if ( !istrue( level.game_objects.var_5f329cd264226f08 ) )
    {
        game_object_origin += ( 0, 0, 12 );
        gameobjects_common::function_d31ff650f04e754b( game_object, game_object_origin );
    }
    
    game_object.objective_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_set_play_intro( game_object.objective_id, 0 );
    objidpoolmanager::objective_set_play_outro( game_object.objective_id, 0 );
    objidpoolmanager::objective_playermask_showtoall( game_object.objective_id );
    objidpoolmanager::update_objective_position( game_object.objective_id, game_object_origin );
    objidpoolmanager::update_objective_state( game_object.objective_id, "current" );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bomb_neutral" );
    bomb_model_ref = common::get_gametype_asset( #"bomb_model" );
    game_object.visuals = spawn( "script_model", utility::drop_to_ground( game_object_origin, 64, -1024 ) );
    game_object.visuals.angles = gameobjects_common::function_63e25df7cfbb206f( game_object );
    game_object.visuals setmodel( bomb_model_ref );
    game_object.visuals setnonstick( 1 );
    game_object.visuals show();
    bombzone::initialize_bomb( game_object );
    level.cyberemp = game_object;
    game_object callback::function_dc654a4d4126a928( #"hash_249e26f937238db4", #"hash_6947ec89a1af6d69", &function_ac5390d71ced0852 );
    game_object callback::function_dc654a4d4126a928( #"hash_a21546ba725310a2", #"hash_6947ec89a1af6d69", &function_9ecea98a6191ed6f );
    gameobjects_shared::activate( game_object );
    flags::levelflaginit( "cyber_bomb_constructed", 1 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xc5a0333f, Offset: 0x8dd0
// Size: 0x285
function private function_ac5390d71ced0852( params )
{
    game_object = params.game_object;
    player = params.player;
    team_first_pickup = params.team_first_pickup;
    force_pickup = params.force_pickup;
    instance_id = params.instance_id;
    player thread empradarwatcher();
    objidpoolmanager::objective_teammask_addtomask( game_object.objective_id, player.team );
    objidpoolmanager::update_objective_onentity( game_object.objective_id, player );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bomb_carried" );
    game_object.visuals hide();
    
    if ( team_first_pickup )
    {
        player thread points::doscoreevent( #"emp_grab" );
    }
    
    other_team_name = game_utility_mp::getotherteam( player.team )[ 0 ];
    
    if ( !force_pickup )
    {
        player_vo_hash = team_first_pickup ? #"hash_2455cdae8e319a5b" : #"hash_e78310e5e01cab3a";
        var_18226a6ff5cba540 = team_first_pickup ? #"hash_fa621b899d9d9d89" : #"hash_63c34fabbfb0f900";
        var_697973ab574ef2a5 = [];
        
        if ( dialog_utility::dialogueexists( player_vo_hash, player.team ) )
        {
            player dialog::leaderdialogonplayer( player_vo_hash );
            
            if ( !isdefined( var_697973ab574ef2a5 ) )
            {
                var_697973ab574ef2a5 = [];
            }
            
            var_697973ab574ef2a5[ var_697973ab574ef2a5.size ] = player;
        }
        
        dialog::statusdialog( var_18226a6ff5cba540, player.team, undefined, var_697973ab574ef2a5 );
        dialog::statusdialog( #"hash_e3365b8869a50351", other_team_name );
        player gameplay_sound_fx::function_6dac8db778849e61( #"hash_63c34fabbfb0f900", player.team );
        player gameplay_sound_fx::function_6dac8db778849e61( #"hash_e3365b8869a50351", other_team_name );
        thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_c8adeffe7d960156", #"hash_5795d231e988aa4", player, #"hash_e015ff4fe81e2cfc" );
        thread hud_util::function_ddf9cb7f151d8d96( player, #"hash_fbefa3f1f2799617", #"hash_fece5d94b43aff9c", #"hash_7a89772b38659554" );
    }
    
    function_3d46c4e6e19ae06f( player );
    codcaster_utils::function_3038b6eafc46c037( 16, player.team, player getentitynumber() );
    objective_list = game_utility_mp::get_gametype_objectives( instance_id );
    gameobjects_shared::activate( objective_list[ other_team_name ] );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x74e99d25, Offset: 0x905d
// Size: 0x1ba
function private function_9ecea98a6191ed6f( params )
{
    game_object = params.game_object;
    player = params.player;
    instance_id = params.instance_id;
    game_object_origin = gameobjects_shared::get_origin( game_object );
    game_object.visuals.origin = utility::drop_to_ground( game_object_origin, 64, -1024 );
    game_object.visuals.angles = gameobjects_common::function_63e25df7cfbb206f( game_object );
    game_object.visuals show();
    other_team_name = game_utility_mp::getotherteam( player.team )[ 0 ];
    
    if ( !level.bombplanted )
    {
        objidpoolmanager::objective_playermask_showtoall( game_object.objective_id );
        objidpoolmanager::update_objective_position( game_object.objective_id, game_object_origin );
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bomb_neutral" );
        dialog::statusdialog( #"hash_c47546ecf7ba8536", player.team );
        dialog::statusdialog( #"hash_20b5cbc1cc99ea43", other_team_name );
        player gameplay_sound_fx::function_6dac8db778849e61( #"hash_c47546ecf7ba8536", player.team );
        player gameplay_sound_fx::function_6dac8db778849e61( #"hash_20b5cbc1cc99ea43", other_team_name );
        thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_42726130fdbde172", #"hash_42726130fdbde172" );
    }
    
    objective_list = game_utility_mp::get_gametype_objectives( instance_id );
    gameobjects_shared::deactivate( objective_list[ other_team_name ] );
}

// Namespace cyber
// Params 2, eflags: 0x4
// Checksum 0xf5c412b6, Offset: 0x921f
// Size: 0x294
function private function_53d5a8d65ee1ab77( game_object, var_7f4958ce4e4277c3 )
{
    game_object_origin = gameobjects_shared::get_origin( game_object );
    game_object_instance_id = gameobjects_common::get_instance_id( game_object );
    owning_team_name = var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object_instance_id ) : game_utility_mp::get_defender_team( game_object_instance_id );
    
    if ( !istrue( level.game_objects.var_5f329cd264226f08 ) )
    {
        game_object_origin += ( 0, 0, 24 );
        gameobjects_common::function_d31ff650f04e754b( game_object, game_object_origin );
    }
    
    game_object.objective_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_set_play_intro( game_object.objective_id, 0 );
    objidpoolmanager::objective_set_play_outro( game_object.objective_id, 0 );
    objidpoolmanager::objective_playermask_hidefromall( game_object.objective_id );
    objidpoolmanager::update_objective_ownerteam( game_object.objective_id, owning_team_name );
    objidpoolmanager::update_objective_position( game_object.objective_id, game_object_origin );
    objidpoolmanager::update_objective_state( game_object.objective_id, "current" );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bombzone_neutral" );
    game_utility_mp::add_gametype_objective( game_object, owning_team_name );
    game_object callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_6947ec89a1af6d69", &function_db64dbfd8567aa94 );
    game_object callback::function_dc654a4d4126a928( #"hash_89cf712b23a4d7b5", #"hash_6947ec89a1af6d69", &function_21ed60c317ab3937 );
    game_object callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_3a2e9cef8298cca );
    game_object callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_f5408a10ca9745f0 );
    game_object callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_9eecd01ceb67fdab );
    game_object callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_2c5cdc0718d004eb );
    game_object callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_b51c7e6a7c15fb4c );
    game_object callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_1231e7058a4e6bd5 );
    
    if ( !isdefined( level.var_4e40f7256e1dc35b ) )
    {
        level.var_4e40f7256e1dc35b = [];
    }
    
    if ( !isdefined( level.var_4e40f7256e1dc35b[ var_7f4958ce4e4277c3 ] ) )
    {
        level.var_4e40f7256e1dc35b[ var_7f4958ce4e4277c3 ] = {};
    }
    
    level.var_4e40f7256e1dc35b[ var_7f4958ce4e4277c3 ].planting = game_object;
}

// Namespace cyber
// Params 2, eflags: 0x4
// Checksum 0x294ba423, Offset: 0x94bb
// Size: 0x164
function private function_57a3bfd87f9b58c1( game_object, var_7f4958ce4e4277c3 )
{
    if ( !istrue( level.game_objects.var_5f329cd264226f08 ) )
    {
        game_object_origin = gameobjects_common::get_origin( game_object ) + ( 0, 0, 12 );
        gameobjects_common::function_d31ff650f04e754b( game_object, game_object_origin );
    }
    
    game_object callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_135ff669e17309fc );
    game_object callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_2002a75124883b06 );
    game_object callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_79e6a6a3e274f4c1 );
    game_object callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_2c5cdc0718d004eb );
    game_object callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_4255effe1af9f106 );
    game_object callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_1231e7058a4e6bd5 );
    
    if ( !isdefined( level.var_4e40f7256e1dc35b ) )
    {
        level.var_4e40f7256e1dc35b = [];
    }
    
    if ( !isdefined( level.var_4e40f7256e1dc35b[ var_7f4958ce4e4277c3 ] ) )
    {
        level.var_4e40f7256e1dc35b[ var_7f4958ce4e4277c3 ] = {};
    }
    
    level.var_4e40f7256e1dc35b[ var_7f4958ce4e4277c3 ].defusing = game_object;
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x1446bf0e, Offset: 0x9627
// Size: 0x35
function private function_db64dbfd8567aa94( params )
{
    game_object = params.game_object;
    objidpoolmanager::objective_playermask_showtoall( game_object.objective_id );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xee9c9fd0, Offset: 0x9664
// Size: 0x42
function private function_21ed60c317ab3937( params )
{
    game_object = params.game_object;
    
    if ( !level.bombplanted )
    {
        objidpoolmanager::objective_playermask_hidefromall( game_object.objective_id );
    }
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xe9ad252, Offset: 0x96ae
// Size: 0x4a
function private function_3a2e9cef8298cca( params )
{
    game_object = params.game_object;
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bombzone_planting" );
    setomnvar( "ui_bomb_interacting", 1 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xaffced42, Offset: 0x9700
// Size: 0x6f
function private function_135ff669e17309fc( params )
{
    game_object = params.game_object;
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bombzone_defusing" );
    
    if ( isdefined( level.cyberemp ) )
    {
        level.cyberemp.visuals hide();
    }
    
    setomnvar( "ui_bomb_interacting", 3 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x603a924a, Offset: 0x9777
// Size: 0x56
function private function_f5408a10ca9745f0( params )
{
    game_object = params.game_object;
    
    if ( !level.bombplanted )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bombzone_neutral" );
    }
    
    setomnvar( "ui_bomb_interacting", 0 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xc7153c1e, Offset: 0x97d5
// Size: 0x98
function private function_2002a75124883b06( params )
{
    game_object = params.game_object;
    
    if ( level.bombplanted )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bombzone_planted" );
        
        if ( isdefined( level.cyberemp ) )
        {
            level.cyberemp.visuals show();
        }
    }
    else
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bombzone_neutral" );
    }
    
    setomnvar( "ui_bomb_interacting", 0 );
}

// Namespace cyber
// Params 2, eflags: 0x4
// Checksum 0xadccd43f, Offset: 0x9875
// Size: 0x6e
function private function_39abfe2f903e2897( game_object, player )
{
    objidpoolmanager::objective_pin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
    objidpoolmanager::objective_show_team_progress( game_object.objective_id, player.team );
    objidpoolmanager::objective_set_progress_team( game_object.objective_id, player.team );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xf353301a, Offset: 0x98eb
// Size: 0x6b
function private function_9eecd01ceb67fdab( params )
{
    game_object = params.game_object;
    player = params.player;
    function_39abfe2f903e2897( game_object, player );
    dialog::statusdialog( #"hash_89d856132935401", player.team );
    player setclientomnvar( "ui_objective_pinned_text_param", 1 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x29834b90, Offset: 0x995e
// Size: 0x7b
function private function_79e6a6a3e274f4c1( params )
{
    game_object = params.game_object;
    player = params.player;
    function_39abfe2f903e2897( game_object, player );
    dialog::statusdialog( #"hash_fb420c82d1acbe87", player.team );
    player setclientomnvar( "ui_objective_pinned_text_param", 2 );
    setomnvar( "ui_bomb_defuser", player getentitynumber() );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x432b1959, Offset: 0x99e1
// Size: 0xb2
function private function_2c5cdc0718d004eb( params )
{
    game_object = params.game_object;
    player = params.player;
    objidpoolmanager::objective_unpin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
    objidpoolmanager::objective_hide_team_progress( game_object.objective_id, player.team );
    objidpoolmanager::objective_set_progress( game_object.objective_id, 0 );
    objidpoolmanager::objective_set_progress_team( game_object.objective_id, undefined );
    player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    setomnvar( "ui_bomb_defuser", -1 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xc442bc7c, Offset: 0x9a9b
// Size: 0x2c
function private function_b51c7e6a7c15fb4c( params )
{
    game_object = params.game_object;
    gameobjects_common::deactivate( game_object );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x902022b8, Offset: 0x9acf
// Size: 0x2c
function private function_4255effe1af9f106( params )
{
    game_object = params.game_object;
    gameobjects_common::activate( game_object );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x1ca92f1, Offset: 0x9b03
// Size: 0x4c
function private function_1231e7058a4e6bd5( params )
{
    game_object = params.game_object;
    progress = params.progress;
    objidpoolmanager::objective_set_progress( game_object.objective_id, progress );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xd2dd4edb, Offset: 0x9b57
// Size: 0x23
function private function_f3a8689e0f98f3d7( params )
{
    params.player setclientomnvar( "ui_current_weapon_is_bomb", 2 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x24d7bb47, Offset: 0x9b82
// Size: 0x22
function private function_4c9dd25d05697cad( params )
{
    params.player setclientomnvar( "ui_current_weapon_is_bomb", 0 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xc0633814, Offset: 0x9bac
// Size: 0x1be
function private function_b82d4c1cd71245dc( params )
{
    var_85c26a6c91c38374 = params.var_85c26a6c91c38374;
    bomb_game_object = params.bomb_game_object;
    player = params.player;
    level.scorelimitoverride = 1;
    level.timelimitoverride = 1;
    level.bombplantedteam = player.team;
    gamelogic_mp::pausetimer();
    setgameendtime( level.defuseendtime );
    codcaster_utils::function_3038b6eafc46c037( 0, player.team, player getentitynumber(), 2 );
    other_team_name = game_utility_mp::getotherteam( player.team )[ 0 ];
    dialog::statusdialog( #"emp_planted_friendly", player.team );
    dialog::statusdialog( #"emp_planted_enemy", other_team_name );
    thread function_d839d09abdabc686( other_team_name, 0, 1 );
    player thread points::doscoreevent( #"plant" );
    thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_2c480ffbc16191a9", #"hash_7a219ec4f9db8347" );
    thread hud_util::function_ddf9cb7f151d8d96( player, #"hash_ded34fd373effe69", #"hash_45a05088926b36e", #"hash_8157e24f8202ccca" );
    thread function_acbbf56917cbfb0a( var_85c26a6c91c38374, bomb_game_object, player.team );
    var_475858cee1383103 = gameobjects_shared::get_origin( var_85c26a6c91c38374 );
    thread bomb_pre_exp_music();
    thread bomb_pre_exp_sfx_wait( var_475858cee1383103 );
    setomnvar( "ui_bomb_owner_team", int( player.team == "allies" ) + 1 );
    setomnvar( "ui_match_timer_stopped", 0 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x315878f3, Offset: 0x9d72
// Size: 0x286
function private function_7dff5f203814911e( params )
{
    bomb_game_object = params.bomb_game_object;
    player = params.player;
    level.scorelimitoverride = 0;
    level.timelimitoverride = 0;
    gamelogic_mp::resumetimer();
    other_team_name = game_utility_mp::getotherteam( player.team )[ 0 ];
    var_e143963628b33c3c = teams::getteamdata( other_team_name, "aliveCount" ) > 0;
    var_3032705d9e45ee0a = dialog_utility::dialogueexists( #"hash_3936845913dde035", player.team ) && !var_e143963628b33c3c;
    var_9f1b92e3a0030bc1 = dialog_utility::dialogueexists( #"hash_7c8948a17c89b6de", other_team_name ) && !var_e143963628b33c3c;
    dialog::statusdialog( var_3032705d9e45ee0a ? #"hash_3936845913dde035" : #"emp_defused_friendly", player.team );
    dialog::statusdialog( var_9f1b92e3a0030bc1 ? #"hash_7c8948a17c89b6de" : #"emp_defused_enemy", other_team_name );
    thread hud_util::function_ddf9cb7f151d8d96( player, #"hash_ed20961c08d8a3f", #"hash_6ebfe699c7cef4a4", #"hash_5fecec0a1325c21c" );
    
    if ( isdefined( bomb_game_object ) )
    {
        gameobjects_shared::function_5a2d24ac6af6b087( bomb_game_object, player );
    }
    
    player thread points::doscoreevent( #"emp_defuse" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "defuses" ] ) )
        {
            player.leaderboarddata[ "defuses" ] = player.leaderboarddata[ "defuses" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "defuses" ] ) )
        {
            [[ level.leaderboardfunc[ "defuses" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1ce>" );
        
        if ( isdefined( player.pers[ "defuses" ] ) )
        {
            player.pers[ "defuses" ] = player.pers[ "defuses" ] + 1;
        }
    }
    
    player persistence::statsetchild( "round", "defuses", player.pers[ "defuses" ] );
    level thread [[ level.updategameevents ]]();
    setomnvar( "ui_bomb_owner_team", 0 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0xfa6e3384, Offset: 0xa000
// Size: 0x17e
function private function_13433513804ffe34( params )
{
    level notify( #"emp_detonated" );
    var_1b55994025b9dc25 = params.var_1b55994025b9dc25;
    player = params.player;
    plant_team_name = params.plant_team_name;
    setgameendtime( 0 );
    var_1b55994025b9dc25.scriptable setscriptabledamageowner( player );
    var_1b55994025b9dc25.scriptable setscriptablepartstate( #"explosion", #"trigger" );
    other_team_name = game_utility_mp::getotherteam( plant_team_name )[ 0 ];
    var_278f0fb1983a87d = teams::getteamdata( plant_team_name, "aliveCount" ) > 0;
    var_3032705d9e45ee0a = dialog_utility::dialogueexists( #"hash_2f281f45a1a314ab", plant_team_name ) && !var_278f0fb1983a87d;
    dialog::statusdialog( var_3032705d9e45ee0a ? #"hash_2f281f45a1a314ab" : #"hash_3c7ec30599d6e588", plant_team_name );
    dialog::statusdialog( #"hash_41ac800ee0b4be19", other_team_name );
    thread function_d839d09abdabc686( other_team_name, 1 );
    
    if ( isdefined( player ) )
    {
        thread hud_util::teamplayercardsplash( #"hash_94c8c07d5588d216", player );
        player thread rank::scoreeventpopup( #"detonate" );
    }
    
    utility::function_bf6bc5af32465d3c( 3, &gamelogic_mp::endgame, plant_team_name, game[ "end_reason" ][ "target_destroyed" ], undefined, undefined, level.detonatescore );
    setomnvar( "ui_bomb_owner_team", 0 );
}

// Namespace cyber
// Params 3, eflags: 0x4
// Checksum 0xe72c45a6, Offset: 0xa186
// Size: 0x12f
function private function_d839d09abdabc686( team_name, is_end_game, wait_time )
{
    level endon( #"game_ended" );
    players = teams::getteamdata( team_name, "players" );
    
    foreach ( player in players )
    {
        player setempjammed( 1 );
    }
    
    if ( !is_end_game && isdefined( wait_time ) )
    {
        wait max( wait_time, 0 );
        
        foreach ( player in players )
        {
            player setempjammed( 0 );
        }
    }
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x7cff77d9, Offset: 0xa2bd
// Size: 0x17
function private function_3d46c4e6e19ae06f( player )
{
    function_b66d34db9d3c53b8( player, 1 );
}

// Namespace cyber
// Params 1, eflags: 0x4
// Checksum 0x64dd4bd6, Offset: 0xa2dc
// Size: 0x16
function private function_9e8b4a44d14359dd( player )
{
    function_b66d34db9d3c53b8( player, 0 );
}

// Namespace cyber
// Params 2, eflags: 0x4
// Checksum 0xd102dd, Offset: 0xa2fa
// Size: 0x114
function private function_b66d34db9d3c53b8( player, var_4b2b323f40370860 )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player notify( #"force_cancel_placement" );
    
    if ( !isdefined( level.cyber_loadouts[ player.team ] ) )
    {
        return;
    }
    
    do
    {
        waitframe();
    }
    while ( player ismantling() || !player isonground() );
    
    if ( var_4b2b323f40370860 )
    {
        player.pers[ "gamemodeLoadout" ] = level.cyber_loadouts[ player.team ];
        player.gamemode_chosenclass = player.class;
        player class::function_e84a99f0f4904c66();
    }
    else
    {
        player.pers[ "gamemodeLoadout" ] = undefined;
    }
    
    player playerlogic::spawnpoint_setspawnpoint( player.origin, player.angles );
    player notify( #"faux_spawn" );
    player.faux_spawn_stance = player getstance();
    player thread playerlogic::spawnplayer( 1 );
}

// Namespace cyber
// Params 3, eflags: 0x4
// Checksum 0xb823840b, Offset: 0xa416
// Size: 0x24e
function private function_acbbf56917cbfb0a( var_85c26a6c91c38374, bomb_game_object, plant_team_name )
{
    assert( var_85c26a6c91c38374.bombplanted );
    level endon( #"game_ended" );
    var_caa1f590fbd64794 = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_set_play_intro( var_caa1f590fbd64794, 0 );
    objidpoolmanager::objective_set_play_outro( var_caa1f590fbd64794, 0 );
    objidpoolmanager::update_objective_state( var_caa1f590fbd64794, "current" );
    other_team_name = game_utility_mp::getotherteam( plant_team_name )[ 0 ];
    objidpoolmanager::objective_teammask_single( var_caa1f590fbd64794, plant_team_name );
    objidpoolmanager::objective_teammask_single( var_85c26a6c91c38374.objective_id, other_team_name );
    objidpoolmanager::update_objective_ownerteam( var_caa1f590fbd64794, plant_team_name );
    objidpoolmanager::update_objective_ownerteam( var_85c26a6c91c38374.objective_id, plant_team_name );
    objectiveiconstates::set_objective_icon_state( var_caa1f590fbd64794, #"bombzone_planted" );
    objectiveiconstates::set_objective_icon_state( var_85c26a6c91c38374.objective_id, #"bombzone_planted" );
    
    if ( isdefined( bomb_game_object ) )
    {
        bomb_game_object waittill( #"bomb_dropped" );
        var_bf678213e34db2dc = gameobjects_shared::get_origin( bomb_game_object );
        objidpoolmanager::update_objective_position( var_caa1f590fbd64794, var_bf678213e34db2dc );
        objidpoolmanager::update_objective_position( var_85c26a6c91c38374.objective_id, var_bf678213e34db2dc );
    }
    else
    {
        var_475858cee1383103 = gameobjects_shared::get_origin( var_85c26a6c91c38374 );
        objidpoolmanager::update_objective_position( var_caa1f590fbd64794, var_475858cee1383103 );
        objidpoolmanager::update_objective_position( var_85c26a6c91c38374.objective_id, var_475858cee1383103 );
    }
    
    objidpoolmanager::objective_show_team_progress( var_caa1f590fbd64794, plant_team_name );
    objidpoolmanager::objective_set_progress_team( var_caa1f590fbd64794, plant_team_name );
    bomb_timer_ms = int( level.bombtimer * 1000 );
    bomb_timer_start_ms = gettime();
    
    while ( var_85c26a6c91c38374.bombplanted )
    {
        time_passed_ms = gettime() - bomb_timer_start_ms;
        time_passed_ratio = min( time_passed_ms / bomb_timer_ms, 1 );
        objidpoolmanager::objective_set_progress( var_caa1f590fbd64794, time_passed_ratio );
        waitframe();
    }
    
    objidpoolmanager::returnobjectiveid( var_caa1f590fbd64794 );
    var_475858cee1383103 = gameobjects_shared::get_origin( var_85c26a6c91c38374 );
    objidpoolmanager::objective_playermask_hidefromall( var_85c26a6c91c38374.objective_id );
    objidpoolmanager::update_objective_ownerteam( var_85c26a6c91c38374.objective_id, other_team_name );
    objidpoolmanager::update_objective_position( var_85c26a6c91c38374.objective_id, var_475858cee1383103 );
    objectiveiconstates::set_objective_icon_state( var_85c26a6c91c38374.objective_id, #"bombzone_neutral" );
}

