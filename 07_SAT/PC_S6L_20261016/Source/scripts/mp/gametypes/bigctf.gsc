// scripts\mp\gametypes\bigctf.gsc  (hash_39a8b103d9252a73.gscc) (size: 75030 Bytes / 0x12516 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63675d12 (1667718418)
// size ...... 75030 (0x12516)
// includes .. 56  (offset: 0x10ce2)
// strings ... 289 (offset: 0x10ea2)
// dev strs .. 26  (offset: 0x122f6)
// exports ... 119 (offset: 0xc592)
// cseg ...... 0x1721 + 0xae71 (0xc592)
// imports ... 406 (offset: 0xd82a)
// animtree1 . 0   (offset: 0x12516)
// animtree2 . 0   (offset: 0x12516)
#using script_2f4866552f0ba818;
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\cash;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\game_utility_mp;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm_upgrades;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rally_point;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\squads;

#namespace bigctf;

// Namespace bigctf
// Params 0
// Checksum 0xe32fe45, Offset: 0x173f
// Size: 0x9c9
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "arm";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    setdvar( @"hash_405e7e20d91344cc", 0 );
    setdvar( @"scr_allow_technicals", 1 );
    setdvar( @"scr_runlean_max_technicals", 30 );
    setdvar( @"hash_e4fa721677f03de0", 1 );
    setdvar( @"cg_friendlyrevivenameplateenabled", 0 );
    setomnvar( "ui_num_dom_flags", 5 );
    setdvar( @"hash_e547fe8dfe1679f6", 30 );
    setdvar( @"hash_36374c04e23480b6", 1 );
    updategametypedvars();
    join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.scoreperplayer = undefined;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onrespawndelay = &getrespawndelay;
    level.onnormaldeath = &onnormaldeath;
    level.onobjectivecomplete = &dom::onflagcapture;
    level.updatefobspawnselection = &updatefobspawnselection;
    
    /#
        level.var_c7f22dd7cb861f3 = &function_c7f22dd7cb861f3;
    #/
    
    level.domflag_setneutral = &obj_dom::domflag_setneutral;
    level.dompoint_setcaptured = &obj_dom::dompoint_setcaptured;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = 12;
    level.requiredplayercount[ "axis" ] = 12;
    level.var_5fb58f5bb9552416 = &getmissedinfilcamerapositions;
    level.var_81d027302ddd38f4 = &calculatecameraoffset;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_mpcf_mode_uktl_cft1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "iw9_mpcf_mode_uktl_nam2";
    }
    
    game[ "dialog" ][ "ally_taken" ] = "iw9_mpcf_mode_uktl_afst";
    game[ "dialog" ][ "ally_dropped" ] = "iw9_mpcf_mode_uktl_afdr";
    game[ "dialog" ][ "ally_returned" ] = "iw9_mpcf_mode_uktl_afrt";
    game[ "dialog" ][ "ally_returning_ours" ] = "iw9_mpcf_mode_uktl_arof";
    game[ "dialog" ][ "ally_captured" ] = "iw9_mpcf_mode_uktl_afcp";
    game[ "dialog" ][ "enemy_taken" ] = "iw9_mpcf_mode_uktl_efst";
    game[ "dialog" ][ "enemy_dropped" ] = "iw9_mpcf_mode_uktl_efdr";
    game[ "dialog" ][ "enemy_returned" ] = "iw9_mpcf_mode_uktl_efrt";
    game[ "dialog" ][ "enemy_returning_theirs" ] = "iw9_mpcf_mode_uktl_ertf";
    game[ "dialog" ][ "enemy_captured" ] = "iw9_mpcf_mode_uktl_efcp";
    game[ "dialog" ][ "ally_one_cap_left" ] = "iw9_mpcf_mode_uktl_aocl";
    game[ "dialog" ][ "enemy_one_cap_left" ] = "iw9_mpcf_mode_uktl_eocl";
    game[ "dialog" ][ "boost" ] = "iw9_mpcf_mode_uktl_bost";
    game[ "dialog" ][ "one_cap_tied" ] = "iw9_mpcf_mode_uktl_ocbt";
    level.nosuspensemusic = 1;
    level._effect[ "vfx_smk_signal_gr" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal_gr" );
    level._effect[ "vfx_snatch_ac130_clouds" ] = loadfxasset( "vfx_iw8_mp_gamemode_snatch_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_scroll" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_scroll" );
    level._effect[ "vfx_br_infil_jump_smoke_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_smoke_01" );
    level._effect[ "vfx_br_infil_jump_wisp_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_01" );
    level._effect[ "vfx_br_infil_jump_wisp_02" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_02" );
    level._effect[ "vfx_br_infil_omni_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_omni_light" );
    level._effect[ "vfx_br_infil_spot_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_spot_light" );
    level.var_94f7e9904f6d47e4 = 1;
    level.disablespectate = getdvarint( @"hash_6228446f42d1367f", 1 ) == 1;
    level.nukeselectactive = getdvarint( @"hash_720c7a325f31f44b", 0 );
    level.killstoearnnukeselect = getdvarint( @"hash_b081c1dd5ea0af33", 7 );
    level.useobjectives = getdvarint( @"hash_f487c553b2ae0bdb", 1 );
    level.userallypointvehicles = getdvarint( @"hash_9381d93d96c2f50b", 1 );
    level.hideenemyfobs = getdvarint( @"hash_7aefd938edd32dcc", 0 );
    level.completelyremovelittlebird = getdvarint( @"hash_e39e476d418a5b03", 0 );
    level.usec130spawn = getdvarint( @"hash_9d9bb5a2f8144fb0", 0 );
    level.usec130spawnfirstonly = getdvarint( @"hash_930ce0bf448dadaa", 0 );
    level.c130movementmethod = getdvarint( @"hash_2a34ac7d0124085e", 0 );
    level.c130flightdist = getdvarfloat( @"hash_2d511cfd4eb77221", 4000 );
    level.c130distapart = getdvarfloat( @"hash_ef46594cd3335bd3", 5000 );
    level.c130alignedtolocale = getdvarfloat( @"hash_f4da32c36b5dcd26", 1 );
    level.var_7f0a2d7de93a21d3 = getdvarint( @"hash_e4a8296b521a6dee", 1 ) == 1;
    level.var_1273a5ffe332df4d = getdvarfloat( @"hash_91d950c33d45ae50", 60 );
    level.var_4e367de5c2d6631e = getdvarfloat( @"hash_58c456ebd6371a4b", 60 );
    level.var_b9ea12c4f2229c53 = getdvarint( @"hash_19e5cada53ccf044", 0 ) == 1;
    level.var_65526c5c4e8f9d90 = getdvarint( @"hash_67a32114ce80b58f", 0 ) == 1;
    level.var_576f7155d6a0fa48 = getdvarint( @"hash_27abaa55d7ec8eb9", 1 ) == 1;
    level.var_693302e6ea51684f = level.infilskip || getdvarint( @"hash_ff5233fcf546c6b1", 0 ) == 1;
    level.var_dfb2277145204ce4 = &arm_upgrades::function_dfb2277145204ce4;
    level.var_4aabf66864c03ef4 = &arm_upgrades::function_4aabf66864c03ef4;
    level.var_bb6300af9683b504 = &arm_upgrades::function_bb6300af9683b504;
    level.skydiveredeploy = &arm_upgrades::skydiveredeploy;
    level.dropbrloot = getdvarint( @"hash_1d196605f8a290e3", 0 );
    level.br_plunder_enabled = getdvarint( @"scr_game_cash", 0 );
    
    if ( level.br_plunder_enabled )
    {
        loot::init();
        level.var_415fc308a7faccd9 = 0;
    }
    
    level.var_99e6db424e4b2f5c = getdvarint( @"hash_644f043f54d141f5", 0 );
    level.var_f44b0da5db239f15 = getdvarint( @"hash_8fd67e929af907eb", 0 );
    
    if ( level.var_99e6db424e4b2f5c )
    {
        level.var_cc4ceaea968640d2 = &points::function_cc4ceaea968640d2;
    }
    
    level.spawnselectionshowenemy = getdvarint( @"scr_spawnselectionshowenemy", 0 );
    level.spawnselectionshowfriendly = getdvarint( @"scr_spawnselectionshowfriendly", 0 );
    level.forcetopickafob = getdvarint( @"scr_arm_forcespawning", 0 );
    level.maxhqtanks = getdvarint( @"scr_arm_maxhqtanks", 2 );
    level.tankrespawntime = getdvarint( @"hash_b624863894a18f21", 120 );
    level.apcrespawntime = getdvarint( @"hash_ba2474692378b203", 120 );
    level.longdialoguecooldown = getdvarint( @"hash_e01953fcf34a5d51", 1 );
    level.mercymatchending_nuke = getdvarint( @"hash_647cfd0a848d6ed6", 1 );
    level.mercymatchending_time = getdvarint( @"scr_arm_mercyendingtime", 30 );
    level.numnonrallyvehicles = getdvarint( @"scr_arm_numnonrallyvehicles", 25 );
    level.disablepersonalnuke = getdvarint( @"hash_f271257bddc28c95", 0 );
    level.personalnukecostoverride = getdvarint( @"scr_personalnukecostoverride", 30 );
    level.showteamtanks = getdvarint( @"scr_arm_showteamtanks", 1 );
    level.spawnselectionafktime = getdvarint( @"hash_da4e1d4c2111a1bc", 120 );
    level.manualadjustlittlebirdlocs = getdvarint( @"hash_1d04716268113cb5", 1 );
    level.var_3416583522672ad3 = getdvarint( @"hash_a9937f1a2710bcd8", 1 );
    
    if ( level.showteamtanks )
    {
        level.trackedtanks = [];
        level.trackedtanks[ "axis" ] = [];
        level.trackedtanks[ "allies" ] = [];
    }
    
    if ( level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection )
    {
        setdvar( @"scr_game_usespawnselection", 1 );
        level.disablespawncamera = 0;
        setdvar( @"hash_1a2c3b67392b6657", 1 );
    }
    else
    {
        setdvar( @"scr_game_usespawnselection", 0 );
        level.disablespawncamera = 1;
        setdvar( @"hash_1a2c3b67392b6657", 1 );
    }
    
    if ( level.c130movementmethod == 1 )
    {
        level.c130pathkilltracker = [];
        level.c130pathkilltracker[ "axis" ] = 0;
        level.c130pathkilltracker[ "allies" ] = 0;
    }
    
    level.modecontrolledvehiclespawningonly = 1;
    level.disableteamstartspawns = 1;
    level.spawnprotectionexception = &spawnprotectionexception;
    thread function_e42623be2d62d389();
    
    if ( getdvarint( @"hash_60a5cd40eb9c3192", 0 ) == 1 )
    {
        level thread namespace_14ab7f658b8ad5e4::function_a1e291f650f8bab3();
    }
    
    utility::flag_init( "stealth_enabled" );
    utility::flag_init( "level_stealth_initialized" );
    utility::flag_init( "stealth_spotted" );
}

// Namespace bigctf
// Params 0
// Checksum 0xd04ea050, Offset: 0x2110
// Size: 0x97
function function_f3f6b809c9957ef8()
{
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( isdefined( trigger.script_team ) )
            {
                trigger thread function_415518fc0267057();
            }
        }
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x6ba52290, Offset: 0x21af
// Size: 0x190
function function_415518fc0267057()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        if ( isplayer( ent ) && isalive( ent ) )
        {
            if ( isdefined( ent.carryobject ) )
            {
                ent.carryobject thread gameobjects::function_1806feb503063fe6( ent, ent.carryobject.manualdropdata );
            }
        }
        else if ( ent vehicle::is_vehicle() )
        {
            if ( isdefined( ent.occupants ) )
            {
                foreach ( player in ent.occupants )
                {
                    if ( isdefined( player.carryobject ) )
                    {
                        player.carryobject gameobjects::function_1806feb503063fe6( player, player.carryobject.manualdropdata );
                        level.teamflags[ team_utility::getotherteam( player.team ) ] gameobjects::movetoposition( getclosestpointonnavmesh( player.origin ) );
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xfd8638e0, Offset: 0x2347
// Size: 0xcd
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_a628ce6d2ccf681a", getmatchrulesdata( "kothData", "zoneLifetime" ) );
    setdynamicdvar( @"hash_bf8ece70150be9dc", getmatchrulesdata( "kothData", "zoneCaptureTime" ) );
    setdynamicdvar( @"hash_8089acae7c7dfec4", getmatchrulesdata( "kothData", "zoneActivationDelay" ) );
    setdynamicdvar( @"hash_3c161b296c1897d", getmatchrulesdata( "kothData", "randomLocationOrder" ) );
    setdynamicdvar( @"hash_6c5e3d11225e952c", getmatchrulesdata( "kothData", "additiveScoring" ) );
    setdynamicdvar( @"hash_b0e9e227d52251da", getmatchrulesdata( "kothData", "pauseTime" ) );
    setdynamicdvar( @"hash_cae6ba1d384f03a1", getmatchrulesdata( "tdefData", "spawnDelay" ) );
}

// Namespace bigctf
// Params 0
// Checksum 0x32c0316, Offset: 0x241c
// Size: 0x2cd
function onstartgametype()
{
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    foreach ( team in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( team, &"objectives/capture_flag" );
    }
    
    setclientnamemode( "auto_change" );
    level.objectives = [];
    level.uncapturableobjectives = [];
    level.usedomflag = 0;
    level.killstreakqueue = [];
    level.teamkillstreakqueue = [];
    level.teamkillstreakqueue[ "allies" ] = [];
    level.teamkillstreakqueue[ "axis" ] = [];
    level.killstreaklist = [];
    level.killstreaklist[ 4 ] = [ "cruise_predator", "scrambler_drone_guard" ];
    level.killstreaklist[ 3 ] = [ "precision_airstrike", "multi_airstrike", "bradley" ];
    level.killstreaklist[ 2 ] = [ "toma_strike", "chopper_gunner", "pac_sentry", "gunship" ];
    level.teamkillstreakqueue[ "allies" ] = [ "cruise_predator", "precision_airstrike", "cruise_predator" ];
    level.teamkillstreakqueue[ "axis" ] = [ "cruise_predator", "precision_airstrike", "cruise_predator" ];
    debug_setupmatchdata();
    setuphqs();
    flag_default_origins();
    calculatehqmidpoint();
    initspawns();
    createflagsandhud();
    setupobjectives();
    function_f3f6b809c9957ef8();
    level.disablemajoritycapprogress = 1;
    level thread runobjectives();
    
    if ( level.usec130spawn )
    {
        level thread arm_vehicles::managec130spawns();
    }
    
    /#
        level thread function_662cf4c1bdb0bdc3();
    #/
    
    if ( level.userallypointvehicles )
    {
        rally_point::init();
        
        if ( getdvarint( @"hash_c6c5667b81cd74b7", 1 ) == 1 )
        {
            function_6244243fee08d684( "veh9_palfa" );
            function_6244243fee08d684( "little_bird" );
        }
        
        level thread arm_vehicles::init_rallyvehicles();
    }
    
    thread arm_vehicles::init_groundwarvehicles();
    dialog::initstatusdialog();
    setdvar( @"hash_9365c7a237edaa2f", 1 );
    level.parachutecancutautodeploy = 1;
    level.parachutecancutparachute = 1;
    parachute::initparachutedvars();
    emergency_cleanupents();
    updatefobspawnselection();
}

// Namespace bigctf
// Params 1
// Checksum 0x975393fa, Offset: 0x26f1
// Size: 0x89
function function_6244243fee08d684( vehicleref )
{
    foreach ( vehicle in vehicle_spawn::get_spawn_structs( vehicleref ) )
    {
        vehicle.spawnflags = 1;
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x45a01125, Offset: 0x2782
// Size: 0x9a
function flag_create_team_goal( team )
{
    goal = spawnstruct();
    
    if ( !isdefined( goal.origin ) )
    {
        goal.origin = level.default_flag_origins[ team ];
    }
    
    goal flag_find_ground();
    goal.origin = goal.ground_origin;
    goal.radius = 120;
    goal.team = team;
    goal.ball_in_goal = 0;
    goal.highestspawndistratio = 0;
    return goal;
}

// Namespace bigctf
// Params 0
// Checksum 0xbe3f0aaf, Offset: 0x2825
// Size: 0x9a
function removeflagcarrierclass()
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
    
    self.pers[ "gamemodeLoadout" ] = undefined;
    playerlogic::spawnpoint_setspawnpoint( self.origin, self.angles );
    self notify( #"faux_spawn" );
    self.faux_spawn_stance = self getstance();
    thread playerlogic::spawnplayer( 1 );
}

/#

    // Namespace bigctf
    // Params 0
    // Checksum 0x96a495b2, Offset: 0x28c7
    // Size: 0x297, Type: dev
    function removeflag()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x24>" ) != "<dev string:x24>" )
            {
                goallabel = getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x24>" );
                
                if ( goallabel == "<dev string:x25>" )
                {
                    team = "<dev string:x28>";
                }
                else
                {
                    team = "<dev string:x2f>";
                }
                
                if ( team == "<dev string:x28>" )
                {
                    if ( game[ "<dev string:x34>" ] )
                    {
                        team = game[ "<dev string:x42>" ];
                    }
                    else
                    {
                        team = game[ "<dev string:x4c>" ];
                    }
                }
                else if ( game[ "<dev string:x34>" ] )
                {
                    team = game[ "<dev string:x4c>" ];
                }
                else
                {
                    team = game[ "<dev string:x42>" ];
                }
                
                level.teamflags[ team ].trigger notify( #"move_gameobject" );
                level.teamflags[ team ] gameobjects::allowuse( "<dev string:x56>" );
                level.teamflags[ team ].trigger = undefined;
                level.teamflags[ team ] notify( #"deleted" );
                level.teamflags[ team ].visuals[ 0 ] delete();
                level.teamflagbases[ team ] delete();
                level.capzones[ team ] gameobjects::allowuse( "<dev string:x56>" );
                level.capzones[ team ].trigger = undefined;
                level.capzones[ team ] notify( #"deleted" );
                
                foreach ( player in level.players )
                {
                    player player_delete_flag_goal_fx( team );
                }
                
                level.teamflags[ team ].visibleteam = "<dev string:x56>";
                level.teamflags[ team ] gameobjects::setobjectivestatusicons( undefined, undefined );
                level.capzones[ team ].visibleteam = "<dev string:x56>";
                level.capzones[ team ] gameobjects::setobjectivestatusicons( undefined, undefined );
                level.teamflags[ team ] = undefined;
                setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x24>" );
            }
            
            wait 1;
        }
    }

#/

// Namespace bigctf
// Params 1
// Checksum 0x16e094cc, Offset: 0x2b66
// Size: 0xc
function oncantuse( player )
{
    
}

// Namespace bigctf
// Params 1
// Checksum 0x6d25aea, Offset: 0x2b7a
// Size: 0x88
function player_delete_flag_goal_fx( flagteam )
{
    if ( flagteam == self.team )
    {
        if ( isdefined( self._flageffect[ self.team ] ) )
        {
            self._flageffect[ self.team ] delete();
        }
        
        return;
    }
    
    if ( isdefined( self._flageffect[ team_utility::getotherteam( self.team ) ] ) )
    {
        self._flageffect[ team_utility::getotherteam( self.team ) ] delete();
    }
}

/#

    // Namespace bigctf
    // Params 0
    // Checksum 0x8fbb198a, Offset: 0x2c0a
    // Size: 0x610, Type: dev
    function placeflag()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x24>" ) != "<dev string:x24>" )
            {
                goallabel = getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x24>" );
                
                if ( goallabel == "<dev string:x25>" )
                {
                    team = "<dev string:x28>";
                }
                else
                {
                    team = "<dev string:x2f>";
                }
                
                if ( team == "<dev string:x28>" )
                {
                    if ( game[ "<dev string:x34>" ] )
                    {
                        team = game[ "<dev string:x42>" ];
                    }
                    else
                    {
                        team = game[ "<dev string:x4c>" ];
                    }
                }
                else if ( game[ "<dev string:x34>" ] )
                {
                    team = game[ "<dev string:x4c>" ];
                }
                else
                {
                    team = game[ "<dev string:x42>" ];
                }
                
                goal = undefined;
                goal = spawnstruct();
                goal dev_flag_find_ground();
                goal.origin = goal.ground_origin;
                goal.radius = 30;
                goal.team = team;
                trigger = spawn( "<dev string:x5b>", goal.origin, 0, 30, 80 );
                visuals[ 0 ] = spawn( "<dev string:x6a>", goal.origin );
                visuals[ 0 ] setmodel( level.flagmodel[ team ] );
                newteamflag = gameobjects::createcarryobject( team, trigger, visuals, ( 0, 0, 85 ) );
                newteamflag gameobjects::setteamusetext( "<dev string:x77>", &"mp/grabbing_flag" );
                newteamflag gameobjects::setteamusetext( "<dev string:x7d>", &"mp/returning_flag" );
                newteamflag gameobjects::allowcarry( "<dev string:x77>" );
                newteamflag gameobjects::setvisibleteam( "<dev string:x56>" );
                newteamflag gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
                newteamflag.objidpingfriendly = 1;
                newteamflag.allowweapons = 1;
                newteamflag.onpickup = &onpickup;
                newteamflag.onpickupfailed = &onpickupfailed;
                newteamflag.ondrop = &ondrop;
                newteamflag.onreset = &onreset;
                newteamflag.oldradius = trigger.radius;
                newteamflag.origin = goal.origin;
                newteamflag.label = team;
                newteamflag.var_31f608cbd370a8f0 = [];
                tracestart = trigger.origin + ( 0, 0, 32 );
                traceend = trigger.origin + ( 0, 0, -32 );
                contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
                ignoreents = [];
                trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                newteamflag.baseeffectpos = trace[ "<dev string:x86>" ];
                upangles = vectortoangles( trace[ "<dev string:x8f>" ] );
                newteamflag.baseeffectforward = anglestoforward( upangles );
                level.teamflagbases[ team ] = createteamflagbase( team, newteamflag );
                
                if ( team == "<dev string:x28>" )
                {
                    if ( game[ "<dev string:x34>" ] )
                    {
                        level.teamflags[ game[ "<dev string:x42>" ] ] = newteamflag;
                    }
                    else
                    {
                        level.teamflags[ game[ "<dev string:x4c>" ] ] = newteamflag;
                    }
                }
                else if ( game[ "<dev string:x34>" ] )
                {
                    level.teamflags[ game[ "<dev string:x4c>" ] ] = newteamflag;
                }
                else
                {
                    level.teamflags[ game[ "<dev string:x42>" ] ] = newteamflag;
                }
                
                visuals = [];
                trigger = spawn( "<dev string:x5b>", goal.origin - ( 0, 0, goal.radius / 2 ), 0, goal.radius, 80 );
                trigger.no_moving_platfrom_unlink = 1;
                trigger.linktoenabledflag = 1;
                trigger.baseorigin = trigger.origin;
                capzone = gameobjects::createuseobject( team, trigger, visuals, ( 0, 0, 115 ) );
                capzone gameobjects::allowuse( "<dev string:x7d>" );
                capzone gameobjects::setvisibleteam( "<dev string:x96>" );
                capzone gameobjects::setobjectivestatusallicons( level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag );
                capzone gameobjects::setusetime( 0 );
                capzone gameobjects::setkeyobject( level.teamflags[ team_utility::getotherteam( team ) ] );
                level.capzones[ team_utility::getotherteam( team ) ] gameobjects::setkeyobject( newteamflag );
                capzone.onuse = &onuse;
                capzone.oncantuse = &oncantuse;
                tracestart = trigger.origin + ( 0, 0, 32 );
                traceend = trigger.origin + ( 0, 0, -32 );
                contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
                ignoreents = [];
                trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                upangles = vectortoangles( trace[ "<dev string:x8f>" ] );
                
                if ( team == "<dev string:x28>" )
                {
                    if ( game[ "<dev string:x34>" ] )
                    {
                        level.capzones[ game[ "<dev string:x42>" ] ] = capzone;
                    }
                    else
                    {
                        level.capzones[ game[ "<dev string:x4c>" ] ] = capzone;
                    }
                }
                else if ( game[ "<dev string:x34>" ] )
                {
                    level.capzones[ game[ "<dev string:x4c>" ] ] = capzone;
                }
                else
                {
                    level.capzones[ game[ "<dev string:x42>" ] ] = capzone;
                }
                
                setdynamicdvar( @"hash_29d45d6822a1cf6d", "<dev string:x24>" );
            }
            
            wait 1;
        }
    }

#/

// Namespace bigctf
// Params 0
// Checksum 0x4bd8f328, Offset: 0x3222
// Size: 0x9d
function function_4d8d019b34c9df45()
{
    self endon( #"picked_up" );
    self endon( #"reset" );
    level endon( #"disconnect" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.curprogress > 0 && self.numtouching[ self.ownerteam ] == 0 && !self.stalemate )
        {
            progress = self.curprogress / 1000;
            progress /= level.returntime;
            objidpoolmanager::objective_set_progress( self.objidnum, progress );
        }
    }
}

// Namespace bigctf
// Params 1
// Checksum 0xad44c1f6, Offset: 0x32c7
// Size: 0x35b
function ondrop( player )
{
    if ( isdefined( player.leaving_team ) )
    {
        self.droppedteam = player.leaving_team;
        player.leaving_team = undefined;
    }
    else if ( !isdefined( player ) )
    {
        self.droppedteam = self.originalownerteam;
    }
    else
    {
        self.droppedteam = player.team;
    }
    
    if ( isdefined( player ) )
    {
        player updatematchstatushintonnoflag();
    }
    
    gameobjects::setownerteam( team_utility::getotherteam( self.droppedteam ) );
    otherteam = team_utility::getotherteam( self.droppedteam );
    self.cancontestclaim = 1;
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "any" );
    objective_state( self.pingobjidnum, "done" );
    
    if ( level.returntime >= 0 )
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconcaptureflag, level.mlgiconfullflag );
    }
    else
    {
        gameobjects::setobjectivestatusallicons( level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag );
        objidpoolmanager::function_4b37488488e7d007( self.objidnum, 1 );
    }
    
    if ( self.originalownerteam == "allies" )
    {
        setomnvar( "ui_ctf_flag_axis", -1 );
    }
    else
    {
        setomnvar( "ui_ctf_flag_allies", -1 );
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
    }
    
    if ( isdefined( player ) )
    {
        if ( !player::isreallyalive( player ) )
        {
            player.carryobject.var_31f608cbd370a8f0 = [];
        }
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        player playsoundtoteam( "uin_mp_flag_enemy_returned", otherteam, undefined, player );
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
    }
    else
    {
        sound::playsoundonplayers( "uin_mp_flag_enemy_returned", otherteam );
    }
    
    gameobjects::setteamusetime( "friendly", level.returntime );
    gameobjects::setteamusetime( "enemy", level.pickuptime );
    dialog::leaderdialog( "enemy_flag_dropped", self.originalownerteam, "status" );
    dialog::leaderdialog( "flag_dropped", team_utility::getotherteam( self.originalownerteam ), "status" );
    thread function_4d8d019b34c9df45();
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( ispointinvolume( player.origin, trigger ) )
            {
                if ( trigger.script_team != player.team )
                {
                    break;
                }
                
                returnflag();
                return;
            }
        }
    }
    
    if ( level.idleresettime > 0 )
    {
        thread returnaftertime();
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xd9df6ea4, Offset: 0x362a
// Size: 0x12b
function onreset()
{
    self notify( #"manual_drop_cleanup" );
    self notify( #"dropped" );
    
    if ( isdefined( self.droppedteam ) )
    {
        gameobjects::setownerteam( self.droppedteam );
    }
    
    team = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    self.droppedteam = undefined;
    gameobjects::allowcarry( "friendly" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::setobjectivestatusicons( level.iconescort, level.iconkill );
    
    if ( self.originalownerteam == "allies" )
    {
        setomnvar( "ui_ctf_flag_axis", -2 );
    }
    else
    {
        setomnvar( "ui_ctf_flag_allies", -2 );
    }
    
    level.capzones[ otherteam ] gameobjects::allowuse( "friendly" );
    level.capzones[ otherteam ] gameobjects::setvisibleteam( "any" );
    level.capzones[ otherteam ] gameobjects::setobjectivestatusallicons( level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag );
    self.var_31f608cbd370a8f0 = [];
}

// Namespace bigctf
// Params 1
// Checksum 0xe9bde2c1, Offset: 0x375d
// Size: 0x6c
function onbeginuse( player )
{
    team = player.pers[ "team" ];
    
    if ( team == gameobjects::getownerteam() )
    {
        self.trigger.radius = 1024;
        return;
    }
    
    self.trigger.radius = self.oldradius;
}

// Namespace bigctf
// Params 3
// Checksum 0x25d2098c, Offset: 0x37d1
// Size: 0x3b
function onenduse( player, team, success )
{
    self.trigger.radius = self.oldradius;
}

// Namespace bigctf
// Params 3
// Checksum 0x1d2f9e15, Offset: 0x3814
// Size: 0x7a2
function onpickup( player, playervo, defused )
{
    self notify( #"picked_up" );
    player notify( #"obj_picked_up" );
    ownerteam = gameobjects::getownerteam();
    
    if ( isdefined( self.droppedteam ) )
    {
        if ( self.droppedteam == player.team )
        {
            gameobjects::setownerteam( self.droppedteam );
            ownerteam = self.droppedteam;
        }
        else
        {
            gameobjects::setownerteam( team_utility::getotherteam( player.team ) );
            ownerteam = self.droppedteam;
        }
        
        self.droppedteam = undefined;
    }
    
    self.var_f3381beb625b4a = undefined;
    team = player.pers[ "team" ];
    
    if ( team == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    if ( self.originalownerteam != "axis" )
    {
        setomnvar( "ui_ctf_flag_axis_return", 0 );
    }
    else
    {
        setomnvar( "ui_ctf_flag_allies_return", 0 );
    }
    
    if ( team != ownerteam )
    {
        thread hud_util::teamplayercardsplash( "callout_flagreturn", player );
        
        if ( level.closecapturekiller[ player.team ] == player )
        {
            player thread points::doscoreevent( #"mode_ctf_nope" );
        }
        
        level.closecapturekiller[ player.team ] = undefined;
        player thread points::doscoreevent( #"flag_return" );
        
        if ( level.codcasterenabled )
        {
            level.capzones[ player.team ] gameobjects::resetmlgobjectivestatusicon();
        }
        
        thread returnflag();
        self.var_f3381beb625b4a = 1;
        telemetry_data = spawnstruct();
        telemetry_data.player = player;
        telemetry_data.eventname = "obj_return";
        telemetry_data.position = player.origin;
        player playsoundtoteam( "uin_mp_flag_ally_returned", team );
        player playsoundtoteam( "uin_mp_flag_enemy_returned", team_utility::getotherteam( team ) );
        dialog::leaderdialog( "enemy_returned", otherteam, "status" );
        dialog::leaderdialog( "ally_returned", team, "status" );
        codcaster_utils::function_3038b6eafc46c037( 18, player.team, player getentitynumber() );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "returns" ] ) )
            {
                player.leaderboarddata[ "returns" ] = player.leaderboarddata[ "returns" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "returns" ] ) )
            {
                [[ level.leaderboardfunc[ "returns" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x9a>" );
            
            if ( isdefined( player.pers[ "returns" ] ) )
            {
                player.pers[ "returns" ] = player.pers[ "returns" ] + 1;
            }
        }
        
        player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
        player persistence::statsetchild( "round", "returns", player.pers[ "returns" ] );
        
        if ( isplayer( player ) )
        {
            player stats::setextrascore1( player.pers[ "returns" ] );
        }
        
        if ( self.originalownerteam == "allies" )
        {
            setomnvar( "ui_ctf_flag_axis", -2 );
        }
        else
        {
            setomnvar( "ui_ctf_flag_allies", -2 );
        }
        
        return;
    }
    
    if ( isdefined( level.ctf_loadouts[ team ] ) )
    {
        player thread applyflagcarrierclass();
    }
    else
    {
        player attachflag();
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "pickups" ] ) )
        {
            player.leaderboarddata[ "pickups" ] = player.leaderboarddata[ "pickups" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "pickups" ] ) )
        {
            [[ level.leaderboardfunc[ "pickups" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x9a>" );
        
        if ( isdefined( player.pers[ "pickups" ] ) )
        {
            player.pers[ "pickups" ] = player.pers[ "pickups" ] + 1;
        }
    }
    
    level.closecapturekiller[ otherteam ] = undefined;
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    self.teamprogress[ self.claimteam ] = 0;
    self.curprogress = 0;
    
    if ( self.originalownerteam == "allies" )
    {
        setomnvar( "ui_ctf_flag_axis", player getentitynumber() );
    }
    else
    {
        setomnvar( "ui_ctf_flag_allies", player getentitynumber() );
    }
    
    player setclientomnvar( "ui_flag_player_hud_icon", 1 );
    
    if ( isdefined( level.showenemycarrier ) )
    {
        if ( level.showenemycarrier == 0 )
        {
            gameobjects::setvisibleteam( "none" );
        }
        else
        {
            gameobjects::setvisibleteam( "friendly" );
            objective_state( self.pingobjidnum, "current" );
            gameobjects::updatecompassicon( "enemy", self.pingobjidnum );
            objective_icon( self.pingobjidnum, "icon_waypoint_flag_carry" );
            objidpoolmanager::function_4b37488488e7d007( self.pingobjidnum, 1 );
        }
    }
    
    gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    
    if ( getdvarint( @"hash_83fcaa8032225364", 1 ) == 0 )
    {
        level.capzones[ otherteam ] gameobjects::allowuse( "none" );
    }
    
    level.capzones[ otherteam ] gameobjects::setvisibleteam( "any" );
    level.capzones[ otherteam ] gameobjects::setobjectivestatusallicons( level.var_6c2d7b0dc3115b36, level.var_870f2a627098e1a0, level.mlgiconfullflag );
    player playsoundtoteam( "uin_mp_flag_ally_pickup", team );
    player playsoundtoteam( "uin_mp_flag_enemy_pickup", team_utility::getotherteam( team ) );
    dialog::leaderdialog( "enemy_taken", team );
    dialog::leaderdialog( "ally_taken", otherteam );
    thread hud_util::teamplayercardsplash( "callout_flagpickup", player );
    
    if ( !isdefined( self.var_31f608cbd370a8f0 ) )
    {
        self.var_31f608cbd370a8f0 = [];
    }
    
    if ( !isdefined( self.var_31f608cbd370a8f0[ player.name ] ) || self.var_31f608cbd370a8f0[ player.name ] <= gettime() )
    {
        player thread points::doscoreevent( #"flag_grab" );
        self.var_31f608cbd370a8f0[ player.name ] = gettime() + 10000;
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = player;
    telemetry_data.eventname = "pickup";
    telemetry_data.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xc5cf3bdd, Offset: 0x3fbe
// Size: 0xd9
function applyflagcarrierclass()
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
    
    self.pers[ "gamemodeLoadout" ] = level.ctf_loadouts[ self.team ];
    playerlogic::spawnpoint_setspawnpoint( self.origin, self.angles );
    self.gamemode_chosenclass = self.class;
    class::function_e84a99f0f4904c66();
    self notify( #"faux_spawn" );
    self.gameobject_fauxspawn = 1;
    self.faux_spawn_stance = self getstance();
    thread playerlogic::spawnplayer( 1 );
    thread waitattachflag();
}

// Namespace bigctf
// Params 0
// Checksum 0xb87bb71c, Offset: 0x409f
// Size: 0x97
function returnaftertime()
{
    self endon( #"picked_up" );
    team = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    currentwaittime = 0;
    
    while ( currentwaittime < level.idleresettime )
    {
        waitframe();
        
        if ( self.claimteam == "none" )
        {
            currentwaittime += level.framedurationseconds;
        }
    }
    
    sound::playsoundonplayers( "uin_mp_flag_ally_returned", team );
    sound::playsoundonplayers( "uin_mp_flag_enemy_returned", otherteam );
    returnflag();
}

// Namespace bigctf
// Params 0
// Checksum 0x26941481, Offset: 0x413e
// Size: 0xa3
function returnflag()
{
    self notify( #"returned_already" );
    self endon( #"returned_already" );
    
    if ( self.originalownerteam != "axis" )
    {
        setomnvar( "ui_ctf_flag_axis_return", 0 );
    }
    else
    {
        setomnvar( "ui_ctf_flag_allies_return", 0 );
    }
    
    self.teamprogress[ self.claimteam ] = 0;
    self.curprogress = 0;
    self.cancontestclaim = 0;
    gameobjects::setteamusetime( "friendly", level.pickuptime );
    gameobjects::setteamusetime( "enemy", level.returntime );
    gameobjects::returnhome();
}

// Namespace bigctf
// Params 0
// Checksum 0xbe97a2e8, Offset: 0x41e9
// Size: 0x2e
function waitattachflag()
{
    level endon( #"game_ende" );
    self endon( #"death_or_disconnect" );
    self waittill( #"spawned_player" );
    attachflag();
}

// Namespace bigctf
// Params 0
// Checksum 0xb7356285, Offset: 0x421f
// Size: 0x58
function attachflag()
{
    updatematchstatushintonhasflag();
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    self attach( level.carryflag[ otherteam ], "tag_stowed_back3", 1 );
    self.carryflag = level.carryflag[ otherteam ];
}

// Namespace bigctf
// Params 0
// Checksum 0x36d2c6e2, Offset: 0x427f
// Size: 0x12
function updatematchstatushintonnoflag()
{
    hud_message::function_ef4318a0090caa0f( #"flag_capture" );
}

// Namespace bigctf
// Params 0
// Checksum 0xdb59d02b, Offset: 0x4299
// Size: 0x12
function updatematchstatushintonhasflag()
{
    hud_message::function_ef4318a0090caa0f( #"flag_return" );
}

// Namespace bigctf
// Params 1
// Checksum 0xbd25ecc8, Offset: 0x42b3
// Size: 0xc
function onpickupfailed( player )
{
    
}

// Namespace bigctf
// Params 0
// Checksum 0x7788ee43, Offset: 0x42c8
// Size: 0xc3, Type: bool
function dev_flag_find_ground()
{
    tracestart = level.players[ 0 ].origin + ( 0, 0, 32 );
    traceend = level.players[ 0 ].origin + ( 0, 0, -1000 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    self.ground_origin = trace[ "position" ];
    return trace[ "fraction" ] != 0 && trace[ "fraction" ] != 1;
}

// Namespace bigctf
// Params 0
// Checksum 0x8be9917b, Offset: 0x4394
// Size: 0x1e9
function createflagsandhud()
{
    level.flagmodel[ "allies" ] = "ctf_game_flag_west";
    level.flagbase[ "allies" ] = "ctf_game_flag_base";
    level.carryflag[ "allies" ] = "prop_ctf_game_flag_west";
    level.flagmodel[ "axis" ] = "ctf_game_flag_east";
    level.flagbase[ "axis" ] = "ctf_game_flag_base";
    level.carryflag[ "axis" ] = "prop_ctf_game_flag_east";
    level.closecapturekiller = [];
    level.closecapturekiller[ "allies" ] = undefined;
    level.closecapturekiller[ "axis" ] = undefined;
    level.iconescort = "waypoint_escort_flag";
    level.iconkill = "waypoint_ctf_kill";
    level.iconcaptureflag = "waypoint_take_flag";
    level.icondefendflag = "waypoint_defend_flag";
    level.iconreturnflag = "waypoint_recover_flag";
    level.var_6c2d7b0dc3115b36 = "waypoint_home_flag";
    level.var_870f2a627098e1a0 = "waypoint_enemy_home_flag";
    setupwaypointicons();
    level.teamflags[ game[ "defenders" ] ] = createteamflag( game[ "defenders" ], "axis" );
    level.teamflags[ game[ "attackers" ] ] = createteamflag( game[ "attackers" ], "allies" );
    level.capzones[ game[ "defenders" ] ] = createcapzone( game[ "defenders" ], "axis" );
    level.capzones[ game[ "attackers" ] ] = createcapzone( game[ "attackers" ], "allies" );
    objidpoolmanager::function_1f589e274283d14a( level.capzones[ game[ "defenders" ] ].objidnum, 1 );
    objidpoolmanager::function_1f589e274283d14a( level.capzones[ game[ "attackers" ] ].objidnum, 1 );
}

// Namespace bigctf
// Params 2
// Checksum 0x88f9601a, Offset: 0x4585
// Size: 0x6e6
function createteamflag( team, entityteam )
{
    var_ef5a1de456a59530 = 0;
    trigger = getent( "ctf_zone_" + entityteam, #targetname );
    
    if ( !isdefined( trigger ) )
    {
        flaggoal = flag_create_team_goal( team );
        trigger = spawn( "trigger_radius", flaggoal.origin - ( 0, 0, flaggoal.radius / 2 ), 0, flaggoal.radius, 65 );
        trigger.targetname = "OutOfBounds";
        trigger.no_moving_platfrom_unlink = 1;
        trigger.linktoenabledflag = 1;
        trigger.baseorigin = trigger.origin;
        var_ef5a1de456a59530 = 1;
        visuals[ 0 ] = spawn( "script_model", flaggoal.origin );
        visuals[ 0 ] setasgametypeobjective();
        visuals[ 0 ] setteaminhuddatafromteamname( entityteam );
    }
    else
    {
        visuals[ 0 ] = getent( "ctf_flag_" + entityteam, #targetname );
    }
    
    if ( !isdefined( visuals[ 0 ] ) )
    {
    }
    
    if ( !var_ef5a1de456a59530 )
    {
        radius = 15;
        
        if ( level.pickuptime > 0 || level.returntime > 0 )
        {
            radius *= 2;
        }
        
        clonetrigger = spawn( "trigger_radius", trigger.origin, 0, radius, trigger.height );
        trigger = clonetrigger;
    }
    
    if ( level.mapname == "mp_m_speedball" )
    {
        trigger flag_find_ground();
        trigger.origin = trigger.ground_origin;
        visuals[ 0 ].origin = trigger.ground_origin - ( 0, 0, 0.5 );
    }
    
    visuals[ 0 ] setmodel( level.flagmodel[ team ] );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 0 ] setteaminhuddatafromteamname( entityteam );
    carryteam = team_utility::getotherteam( team );
    teamflag = gameobjects::createcarryobject( carryteam, trigger, visuals, ( 0, 0, 85 ) );
    teamflag gameobjects::allowcarry( "friendly" );
    teamflag.ui_ctf_securing = 0;
    teamflag gameobjects::setteamusetime( "friendly", level.pickuptime );
    teamflag gameobjects::setteamusetime( "enemy", level.returntime );
    teamflag gameobjects::setvisibleteam( "none" );
    teamflag gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, undefined );
    teamflag objidpoolmanager::objective_set_play_intro( teamflag.objidnum, 0 );
    teamflag objidpoolmanager::objective_set_play_outro( teamflag.objidnum, 0 );
    teamflag gameobjects::registercarryobjectpickupcheck( &flagpickupchecks );
    teamflag.allowweapons = 1;
    teamflag.originalownerteam = carryteam;
    teamflag.onpickup = &onpickup;
    teamflag.onpickupfailed = &onpickupfailed;
    teamflag.ondrop = &ondrop;
    teamflag.onreset = &onreset;
    teamflag.pinobj = 1;
    teamflag.cancontestclaim = 0;
    teamflag.majoritycapprogress = 0;
    teamflag.alwaysstalemate = 1;
    
    if ( teamflag.originalownerteam == "allies" )
    {
        setomnvar( "ui_ctf_flag_axis", -2 );
    }
    else
    {
        setomnvar( "ui_ctf_flag_allies", -2 );
    }
    
    if ( getdvarint( @"hash_5299a4635ae94475", 1 ) != 0 )
    {
        teamflag gameobjects::function_a8c99f0b8d97b750( [ visuals[ 0 ] ], trigger, 1, 80, 0 );
    }
    
    if ( isdefined( level.showenemycarrier ) )
    {
        switch ( level.showenemycarrier )
        {
            case 0:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 60;
                break;
            case 1:
                teamflag.objidpingfriendly = 0;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 0.05;
                break;
            case 2:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 1;
                break;
            case 3:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 1.5;
                break;
            case 4:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 2;
                break;
            case 5:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 3;
                break;
            case 6:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 4;
                break;
        }
        
        pingobjid = objidpoolmanager::requestobjectiveid( 99 );
        teamflag.pingobjidnum = pingobjid;
        objidpoolmanager::objective_add_objective( pingobjid, "done", teamflag.origin );
        objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        teamflag gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, team );
        teamflag gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag, pingobjid );
    }
    else
    {
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 3;
    }
    
    teamflag.oldradius = trigger.radius;
    teamflag.baseeffectpos = teamflag.visuals[ 0 ].origin;
    upangles = anglestoup( teamflag.visuals[ 0 ].angles );
    teamflag.baseeffectforward = anglestoforward( upangles );
    level.teamflagbases[ team ] = createteamflagbase( team, teamflag );
    return teamflag;
}

// Namespace bigctf
// Params 1
// Checksum 0x587a7751, Offset: 0x4c74
// Size: 0xc1, Type: bool
function flagpickupchecks( player )
{
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( isdefined( trigger.script_team ) )
            {
                return ( !ispointinvolume( player.origin, trigger ) && !player vehicle::is_in_vehicle() );
            }
        }
    }
    
    return !player vehicle::is_in_vehicle();
}

// Namespace bigctf
// Params 2
// Checksum 0xaa92043a, Offset: 0x4d3e
// Size: 0xc6
function createteamflagbase( team, teamflag )
{
    flagbaseorigin = teamflag.visuals[ 0 ].origin;
    teamflagbase = spawn( "script_model", flagbaseorigin );
    teamflagbase setmodel( level.flagbase[ team ] );
    teamflagbase.ownerteam = team;
    teamflagbase setasgametypeobjective();
    teamflagbase setteaminhuddatafromteamname( team );
    teamflagbase.baseeffectpos = flagbaseorigin;
    upangles = anglestoup( teamflag.visuals[ 0 ].angles );
    teamflagbase.baseeffectforward = anglestoforward( upangles );
    return teamflagbase;
}

// Namespace bigctf
// Params 2
// Checksum 0x566eea85, Offset: 0x4e0d
// Size: 0x1c6
function createcapzone( team, entityteam )
{
    flaggoal = flag_create_team_goal( team );
    trigger = getent( "ctf_zone_" + entityteam, #targetname );
    
    if ( !isdefined( trigger ) )
    {
        trigger = spawn( "trigger_radius", flaggoal.origin - ( 0, 0, flaggoal.radius / 2 ), 0, flaggoal.radius, 80 );
        trigger.no_moving_platfrom_unlink = 1;
        trigger.linktoenabledflag = 1;
        trigger.baseorigin = trigger.origin;
        trigger.height = flaggoal.radius;
    }
    
    clonetrigger = spawn( "trigger_radius", trigger.origin, 0, flaggoal.radius, trigger.height );
    trigger = clonetrigger;
    visuals = [];
    capzone = gameobjects::createuseobject( team, trigger, visuals, ( 0, 0, 85 ) );
    capzone gameobjects::allowuse( "friendly" );
    capzone gameobjects::setvisibleteam( "none" );
    capzone thread function_6a27cf3d8e470580();
    capzone gameobjects::setobjectivestatusallicons( level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag );
    capzone gameobjects::setusetime( 0 );
    capzone gameobjects::setkeyobject( level.teamflags[ team_utility::getotherteam( team ) ] );
    capzone.onuse = &onuse;
    capzone.oncantuse = &oncantuse;
    return capzone;
}

// Namespace bigctf
// Params 0
// Checksum 0x4690225e, Offset: 0x4fdc
// Size: 0x1b
function function_6a27cf3d8e470580()
{
    level waittill( #"prematch_done" );
    gameobjects::setvisibleteam( "any" );
}

// Namespace bigctf
// Params 1
// Checksum 0x8e6f75ad, Offset: 0x4fff
// Size: 0xb5, Type: bool
function flag_find_ground( z_offset )
{
    tracestart = self.origin + ( 0, 0, 32 );
    traceend = self.origin + ( 0, 0, -1000 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    self.ground_origin = trace[ "position" ];
    return trace[ "fraction" ] != 0 && trace[ "fraction" ] != 1;
}

// Namespace bigctf
// Params 1
// Checksum 0xb3542a53, Offset: 0x50bd
// Size: 0x3f
function setteaminhuddatafromteamname( teamname )
{
    if ( teamname == "axis" )
    {
        self setteaminhuddata( 1 );
        return;
    }
    
    if ( teamname == "allies" )
    {
        self setteaminhuddata( 2 );
        return;
    }
    
    self setteaminhuddata( 0 );
}

// Namespace bigctf
// Params 0
// Checksum 0xb08280dc, Offset: 0x5104
// Size: 0x187
function flag_default_origins()
{
    level.default_goal_origins = [];
    level.flags = getentarray( "flag_primary", #targetname );
    
    if ( !isdefined( game[ "attackers" ] ) )
    {
        game[ "attackers" ] = "allies";
    }
    
    if ( !isdefined( game[ "defenders" ] ) )
    {
        game[ "defenders" ] = "axis";
    }
    
    if ( !isdefined( level.var_478e56a6fdfa0c9d ) )
    {
        alliespos = getdvar( @"hash_99ad48d73b20dccd" );
        
        if ( !isdefined( alliespos ) )
        {
            level.default_flag_origins[ game[ "attackers" ] ] = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ "allies" ] ).origin;
        }
        else
        {
            level.default_flag_origins[ game[ "attackers" ] ] = utility::stringtovec3( alliespos );
        }
    }
    else
    {
        level.default_flag_origins[ game[ "attackers" ] ] = level.var_478e56a6fdfa0c9d;
    }
    
    if ( !isdefined( level.var_dd633391df736dfc ) )
    {
        axispos = getdvar( @"hash_99ad48d73b20dccd" );
        
        if ( !isdefined( axispos ) )
        {
            level.default_flag_origins[ game[ "defenders" ] ] = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ "axis" ] ).origin;
        }
        else
        {
            level.default_flag_origins[ game[ "defenders" ] ] = utility::stringtovec3( axispos );
        }
        
        return;
    }
    
    level.default_flag_origins[ game[ "defenders" ] ] = level.var_dd633391df736dfc;
}

// Namespace bigctf
// Params 0
// Checksum 0x8032e107, Offset: 0x5293
// Size: 0x9c
function function_be9d6614d7c4dc94()
{
    var_71e2bc76ee5a1298 = "ctf_flag_axis_CS";
    var_b51cd7ec9a197393 = "ctf_flag_allies_CS";
    var_5f74abc47d13467a = utility::getstructarray( var_71e2bc76ee5a1298, "script_noteworthy" );
    var_c0b701e75dfcadcd = utility::getstructarray( var_b51cd7ec9a197393, "script_noteworthy" );
    
    if ( isdefined( var_5f74abc47d13467a ) )
    {
        level.var_dd633391df736dfc = utility::drop_to_ground( var_5f74abc47d13467a[ 0 ].origin, 10, -100 );
    }
    
    if ( isdefined( var_c0b701e75dfcadcd ) )
    {
        level.var_478e56a6fdfa0c9d = utility::drop_to_ground( var_c0b701e75dfcadcd[ 0 ].origin, 10, -100 );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xf7d0bef1, Offset: 0x5337
// Size: 0x218
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.pausescoring = dvars::dvarintvalue( "pauseTime", 1, 0, 1 );
    level.delayplayer = dvars::dvarintvalue( "delayPlayer", 1, 0, 1 );
    level.spawndelay = dvars::dvarfloatvalue( "spawnDelay", 5, 0, 30 );
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 30, 0, 30 );
    level.flagsrequiredtoscore = dvars::dvarintvalue( "flagsRequiredToScore", 1, 1, 3 );
    level.pointsperflag = dvars::dvarintvalue( "pointsPerFlag", 1, 1, 300 );
    level.flagneutralization = dvars::dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.precappoints = dvars::dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.capturedecay = dvars::dvarintvalue( "captureDecay", 1, 0, 1 );
    level.capturetype = dvars::dvarintvalue( "captureType", 1, 0, 3 );
    level.numflagsscoreonkill = dvars::dvarintvalue( "snumFlagsScoreOnKill", 0, 0, 3 );
    level.objectivescaler = dvars::dvarfloatvalue( "objScalar", 4, 1, 10 );
    level.winrule = dvars::dvarintvalue( "winRule", 0, 0, 1 );
    level.showenemycarrier = dvars::dvarintvalue( "showEnemyCarrier", 5, 0, 6 );
    level.idleresettime = dvars::dvarfloatvalue( "idleResetTime", 60, 0, 300 );
    level.capturecondition = dvars::dvarintvalue( "captureCondition", 0, 0, 1 );
    level.pickuptime = dvars::dvarfloatvalue( "pickupTime", 0, 0, 10 );
    level.returntime = dvars::dvarfloatvalue( "returnTime", 20, -1, 60 );
    level.watchdvars[ @"hash_f1e3320c1fdd7c60" ].value = 1;
    game_utility_mp::setovertimelimitdvar( dvars::dvarfloatvalue( "overTimeLimit", 300, 0, 1200 ) );
    
    if ( game_utility_mp::inovertime() )
    {
        level.scorelimit = 1;
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xa818236b, Offset: 0x5557
// Size: 0x340
function emergency_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bykey( "vehicle_volume", "script_noteworthy" );
    game_utility::removematchingents_bykey( "vehicle_volume_simplified", "script_noteworthy" );
    game_utility::removematchingents_bykey( "super", "script_noteworthy" );
    game_utility::removematchingents_bykey( "militarybase", "script_noteworthy" );
    game_utility::removematchingents_bykey( "location_volume", "targetname" );
    game_utility::removematchingents_bykey( "locale_area_trigger", "targetname" );
    game_utility::removematchingents_bykey( "bank_entry_detector", "targetname" );
    game_utility::removematchingents_bykey( "shadow_blocker", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "veh8_mil_air_acharlie130", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
    game_utility::removematchingents_bycodeclassname( "light" );
    game_utility::removematchingents_bycodeclassname( "trigger_use_touch" );
    
    if ( level.localeid == "locale_6" )
    {
        game_utility::removematchingents_bykey( "locale_8", "script_noteworthy" );
    }
    
    var_8d16bd8ef76edfb3 = [];
    var_8d16bd8ef76edfb3[ 0 ] = ( -22592, 27367, 1000 );
    var_8d16bd8ef76edfb3[ 1 ] = ( -22592, 27303, -448 );
    var_8d16bd8ef76edfb3[ 2 ] = ( 7837, -9674, 1154 );
    var_8d16bd8ef76edfb3[ 3 ] = ( 7637, -9674, 1154 );
    var_8d16bd8ef76edfb3[ 4 ] = ( 7901, -9674, -270 );
    var_8d16bd8ef76edfb3[ 5 ] = ( 7701, -9674, -270 );
    var_8d16bd8ef76edfb3[ 6 ] = ( 10366, -11606, 66 );
    var_8d16bd8ef76edfb3[ 7 ] = ( 10366, -11813, 66 );
    var_8d16bd8ef76edfb3[ 6 ] = ( 10366, -11670, -270 );
    var_8d16bd8ef76edfb3[ 7 ] = ( 10366, -11877, -270 );
    var_8d16bd8ef76edfb3[ 8 ] = ( 7498, -11716, 66 );
    var_8d16bd8ef76edfb3[ 9 ] = ( 7498, -11652, -270 );
    var_8d16bd8ef76edfb3[ 10 ] = ( -1200, -18954, -242 );
    var_8d16bd8ef76edfb3[ 11 ] = ( -1215, -19016, 774 );
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.model == "tag_origin" )
        {
            var_3b3ac614c0ebfb81 = 0;
            
            foreach ( badtagorigin in var_8d16bd8ef76edfb3 )
            {
                if ( var_3b3ac614c0ebfb81 )
                {
                    break;
                }
                
                if ( distancesquared( ent.origin, badtagorigin ) < 144 )
                {
                    var_3b3ac614c0ebfb81 = 1;
                }
            }
            
            if ( var_3b3ac614c0ebfb81 )
            {
                ent delete();
            }
        }
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xbf9e3933, Offset: 0x589f
// Size: 0x158
function removepatchablecollision_delayed()
{
    wait 5;
    var_c9dd889ed0e5fc94 = [];
    var_c9dd889ed0e5fc94[ 0 ] = "tactical_cover_col";
    var_c9dd889ed0e5fc94[ 1 ] = "tactical_ladder_col";
    var_c9dd889ed0e5fc94[ 2 ] = "clip8x8x256";
    var_c9dd889ed0e5fc94[ 3 ] = "player8x8x256";
    var_c9dd889ed0e5fc94[ 4 ] = "ladderMetal264";
    var_c9dd889ed0e5fc94[ 5 ] = "ladderWood192";
    var_c9dd889ed0e5fc94[ 6 ] = "ladderMetal192";
    var_c9dd889ed0e5fc94[ 7 ] = "mount128";
    var_c9dd889ed0e5fc94[ 8 ] = "mount64";
    var_c9dd889ed0e5fc94[ 9 ] = "mount32";
    var_c9dd889ed0e5fc94[ 10 ] = "mount256";
    var_c9dd889ed0e5fc94[ 11 ] = "ladderWood264";
    var_c9dd889ed0e5fc94[ 12 ] = "nosight256x256x8";
    var_c9dd889ed0e5fc94[ 13 ] = "nosight128x128x8";
    var_c9dd889ed0e5fc94[ 14 ] = "mountCorner128";
    var_c9dd889ed0e5fc94[ 15 ] = "mantle256";
    var_c9dd889ed0e5fc94[ 16 ] = "mantle128";
    var_c9dd889ed0e5fc94[ 17 ] = "mantle64";
    var_c9dd889ed0e5fc94[ 18 ] = "mantle32";
    var_c9dd889ed0e5fc94[ 19 ] = "stairsHalfFlight128";
    var_c9dd889ed0e5fc94[ 20 ] = "stairsFullFlight128";
    
    foreach ( name in var_c9dd889ed0e5fc94 )
    {
        game_utility::removematchingents_bykey( name, "targetname" );
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x6ef162bb, Offset: 0x59ff
// Size: 0x15
function onjoinedteam( player )
{
    player arm_upgrades::function_c7d2f4bdf8ac4c13();
}

// Namespace bigctf
// Params 0
// Checksum 0x6bff0287, Offset: 0x5a1c
// Size: 0xdd
function debug_setupmatchdata()
{
    level.var_76c4dc73f6b30344 = [];
    level.var_76c4dc73f6b30344[ "axis" ] = "gw_fob_axisHQ";
    level.var_76c4dc73f6b30344[ "allies" ] = "gw_fob_alliesHQ";
    level.startingfobnames_allies = [];
    level.startingfobnames_axis = [];
    level.startingfobnames_neutral = [ "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_06", "gw_fob_07", "gw_fob_08", "gw_fob_09" ];
    level.defaultaxisspawn = "gw_fob_axishq";
    level.defaultaxisspawncamera = "gw_fob_axishq";
    level.defaultalliesspawn = "gw_fob_allieshq";
    level.defaultalliesspawncamera = "gw_fob_allieshq";
}

// Namespace bigctf
// Params 0
// Checksum 0xc5598532, Offset: 0x5b01
// Size: 0x2ae
function setupwaypointicons()
{
    while ( !( isdefined( level.streakglobals ) && isdefined( level.streakglobals.streakbundles ) ) )
    {
        waitframe();
    }
    
    foreach ( var_990d1998908bd83c, bundle in level.streakglobals.streakbundles )
    {
        level.waypointcolors[ var_990d1998908bd83c + "_incoming" ] = "neutral";
        level.waypointbgtype[ var_990d1998908bd83c + "_incoming" ] = 1;
        level.waypointstring[ var_990d1998908bd83c + "_incoming" ] = "";
        level.waypointshader[ var_990d1998908bd83c + "_incoming" ] = bundle.hudicon ?? "";
        level.waypointpulses[ var_990d1998908bd83c + "_incoming" ] = 0;
        level.waypointcolors[ var_990d1998908bd83c ] = "neutral";
        level.waypointbgtype[ var_990d1998908bd83c ] = 1;
        level.waypointstring[ var_990d1998908bd83c ] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
        level.waypointshader[ var_990d1998908bd83c ] = bundle.hudicon ?? "";
        gamelogic_mp::setwaypointiconinfo( level.iconkill, 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_flag_carry", 0, undefined );
        gamelogic_mp::setwaypointiconinfo( level.iconreturnflag, 2, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag_base_away", 0, 12 );
        gamelogic_mp::setwaypointiconinfo( level.iconescort, 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag_carry", 0, 12 );
        gamelogic_mp::setwaypointiconinfo( level.iconcaptureflag, 2, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag_base", 0, 13 );
        gamelogic_mp::setwaypointiconinfo( level.icondefendflag, 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag_base", 0, 13 );
        gamelogic_mp::setwaypointiconinfo( level.var_6c2d7b0dc3115b36, 2, "friendly", "OBJECTIVES/FLAG_HOME", "icon_waypoint_flag_base_gone", 0, 13 );
        gamelogic_mp::setwaypointiconinfo( level.var_870f2a627098e1a0, 2, "enemy", "OBJECTIVES/FLAG_AWAY", "icon_waypoint_flag_base_gone", 0, 13 );
        gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined );
        gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x7dd3314c, Offset: 0x5db7
// Size: 0xf1
function setuphqs()
{
    level.gw_objstruct = spawnstruct();
    level.gw_objstruct.axishqloc = spawnstruct();
    level.gw_objstruct.axishqloc.trigger = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ "axis" ] );
    
    if ( !isdefined( level.gw_objstruct.axishqloc ) )
    {
        assert( 0, "<dev string:xc0>" );
    }
    
    level.gw_objstruct.allieshqloc = spawnstruct();
    level.gw_objstruct.allieshqloc.trigger = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ "allies" ] );
    
    if ( !isdefined( level.gw_objstruct.allieshqloc ) )
    {
        assert( 0, "<dev string:xe1>" );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xd5bb1dd7, Offset: 0x5eb0
// Size: 0x251
function setupobjectives()
{
    level.gw_objstruct.startingfobs_allies = [];
    level.gw_objstruct.startingfobs_axis = [];
    var_6e96ef3a633c62f3 = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i" ];
    var_f79a818f3ccf1a46 = 0;
    
    foreach ( fobname in level.startingfobnames_allies )
    {
        fob = spawnstruct();
        fob.name = fobname;
        fob.trigger = game_utility::getlocaleent( fobname );
        fob.trigger.objkey = var_6e96ef3a633c62f3[ var_f79a818f3ccf1a46 ];
        var_f79a818f3ccf1a46++;
        level.gw_objstruct.startingfobs_allies[ level.gw_objstruct.startingfobs_allies.size ] = fob;
    }
    
    foreach ( fobname in level.startingfobnames_axis )
    {
        fob = spawnstruct();
        fob.name = fobname;
        fob.trigger = game_utility::getlocaleent( fobname );
        fob.trigger.objkey = var_6e96ef3a633c62f3[ var_f79a818f3ccf1a46 ];
        var_f79a818f3ccf1a46++;
        level.gw_objstruct.startingfobs_axis[ level.gw_objstruct.startingfobs_axis.size ] = fob;
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x75060bb2, Offset: 0x6109
// Size: 0x240
function updatedomscores()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    level thread spawnselection::updatefobindanger();
    
    while ( !level.gameended )
    {
        wait 10;
        hostmigration::waittillhostmigrationdone();
        domflags = arm_upgrades::getowneddomflags();
        
        if ( !isdefined( level.scoretick ) )
        {
            level.scoretick = [];
        }
        
        foreach ( entry in level.teamnamelist )
        {
            level.scoretick[ entry ] = 0;
        }
        
        if ( domflags.size )
        {
            for ( i = 1; i < domflags.size ; i++ )
            {
                domflag = domflags[ i ];
                flagscore = gettime() - domflag.capturetime;
                
                for ( j = i - 1; j >= 0 && flagscore > gettime() - domflags[ j ].capturetime ; j-- )
                {
                    domflags[ j + 1 ] = domflags[ j ];
                }
                
                domflags[ j + 1 ] = domflag;
            }
            
            foreach ( domflag in domflags )
            {
                team = domflag gameobjects::getownerteam();
                assert( team_utility::isgameplayteam( team ) );
                var_d9425977785add8f = obj_dom::getteamflagcount( team );
                
                if ( var_d9425977785add8f >= level.flagsrequiredtoscore )
                {
                    level.scoretick[ team ] += level.pointsperflag;
                }
            }
        }
        
        updatescores();
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xcc3ea553, Offset: 0x6351
// Size: 0x1a5
function updatescores()
{
    teamshitscorelimit = [];
    
    foreach ( entry in level.teamnamelist )
    {
        targetscore = game[ "teamScores" ][ entry ] + level.scoretick[ entry ];
        
        if ( targetscore >= level.roundscorelimit )
        {
            teamshitscorelimit[ teamshitscorelimit.size ] = entry;
        }
    }
    
    if ( teamshitscorelimit.size == 1 )
    {
        level.scoretick[ teamshitscorelimit[ 0 ] ] = level.roundscorelimit - game[ "teamScores" ][ teamshitscorelimit[ 0 ] ];
    }
    
    var_5bd83029350992ed = gamescore::calculatewinningteam();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.scoretick[ entry ] > 0 )
        {
            gamescore::giveteamscoreforobjective( entry, level.scoretick[ entry ], 1, undefined, 1 );
        }
    }
    
    var_b68dc93240b77466 = gamescore::calculatewinningteam();
    
    if ( var_5bd83029350992ed != var_b68dc93240b77466 )
    {
        gamescore::playscorestatusdialog( var_b68dc93240b77466, 1, var_5bd83029350992ed );
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x81812a87, Offset: 0x64fe
// Size: 0x603
function runobjectives( numobjs )
{
    level.spawnareas = [];
    level.var_3297f3d0b4e2f8da = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnareas[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
        level.var_3297f3d0b4e2f8da[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
    }
    
    level.allfobs = [];
    
    if ( level.useobjectives )
    {
        foreach ( fob in level.gw_objstruct.startingfobs_axis )
        {
            activefob = runobjflag( fob.trigger, "axis" );
            level.allfobs[ level.allfobs.size ] = fob;
            level.spawnareas[ "axis" ][ level.spawnareas[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
        }
        
        foreach ( fob in level.gw_objstruct.startingfobs_allies )
        {
            activefob = runobjflag( fob.trigger, "allies" );
            level.allfobs[ level.allfobs.size ] = fob;
            level.spawnareas[ "allies" ][ level.spawnareas[ "allies" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
        }
    }
    
    if ( level.usespawnselection )
    {
        if ( level.var_3416583522672ad3 )
        {
            spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "axis" ], "axis" );
            spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "allies" ], "allies" );
        }
        else
        {
            spawnselection::setspawnlocations( level.spawnareas[ "axis" ], "axis" );
            spawnselection::setspawnlocations( level.spawnareas[ "allies" ], "allies" );
        }
        
        sethqmarkerobjective();
        
        while ( !isdefined( level.spawnselectionlocations ) )
        {
            waitframe();
        }
        
        waitframe();
        
        if ( isdefined( level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "axis" ] ][ "axis" ].anchorentity ) )
        {
            level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "axis" ] ][ "axis" ].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;
        }
        
        if ( isdefined( level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "allies" ] ][ "allies" ].anchorentity ) )
        {
            level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "allies" ] ][ "allies" ].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;
        }
    }
    
    level thread objective_manageobjectivesintrovisibility();
    hackfixcameras();
    level thread allowobjectiveuseaftermatchstart();
    level.var_aed2551dbad09889 = 1;
}

// Namespace bigctf
// Params 0
// Checksum 0x39443b84, Offset: 0x6b09
// Size: 0x9f
function allowobjectiveuseaftermatchstart()
{
    flags::gameflagwait( "prematch_done" );
    
    foreach ( fob in level.allfobs )
    {
        fob.trigger.gameobject gameobjects::allowuse( "enemy" );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xfd0f865a, Offset: 0x6bb0
// Size: 0x329
function objective_manageobjectivesintrovisibility()
{
    wait 1;
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.enemymarker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.enemymarker.objidnum );
    
    foreach ( fob in level.allfobs )
    {
        objidpoolmanager::objective_playermask_hidefromall( fob.trigger.gameobject.objidnum );
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( rallypoint in level.rallypointvehicles )
        {
            objidpoolmanager::objective_playermask_hidefromall( rallypoint.marker.objidnum );
        }
    }
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    foreach ( fob in level.allfobs )
    {
        objidpoolmanager::objective_playermask_showtoall( fob.trigger.gameobject.objidnum );
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( rallypoint in level.rallypointvehicles )
        {
            if ( isdefined( rallypoint ) )
            {
                objidpoolmanager::objective_teammask_addtomask( rallypoint.marker.objidnum, rallypoint.team );
            }
        }
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x448ff0ba, Offset: 0x6ee1
// Size: 0x1f4
function hackfixcameras()
{
    if ( level.usestaticspawnselectioncamera )
    {
        return;
    }
    
    while ( !level.var_aeb6f04033bb30b0 )
    {
        waitframe();
    }
    
    team = "allies";
    forward = level.spawnselectionteamforward[ team ];
    keys = [ "gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05" ];
    spawncamera::createOrientedCameras( keys, team, forward, -8500, 7000 );
    team = "axis";
    forward = level.spawnselectionteamforward[ team ];
    keys = [ "gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05" ];
    spawncamera::createOrientedCameras( keys, team, forward, -8500, 7000 );
    level.spawncameras[ "default" ][ "allies" ].origin = level.spawncameras[ "gw_fob_alliesHQ" ][ "allies" ].origin;
    level.spawncameras[ "default" ][ "allies" ].angles = level.spawncameras[ "gw_fob_alliesHQ" ][ "allies" ].angles;
    level.spawncameras[ "default" ][ "axis" ].origin = level.spawncameras[ "gw_fob_axisHQ" ][ "axis" ].origin;
    level.spawncameras[ "default" ][ "axis" ].angles = level.spawncameras[ "gw_fob_axisHQ" ][ "axis" ].angles;
}

// Namespace bigctf
// Params 0
// Checksum 0x8c65f154, Offset: 0x70dd
// Size: 0x31d
function updatefobspawnselection()
{
    level.spawnareas = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnareas[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
    }
    
    foreach ( fob in level.allfobs )
    {
        gameobject = fob.trigger.gameobject;
        
        if ( gameobject.ownerteam == "axis" )
        {
            level.spawnareas[ "axis" ][ level.spawnareas[ "axis" ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
            
            continue;
        }
        
        if ( gameobject.ownerteam == "allies" )
        {
            level.spawnareas[ "allies" ][ level.spawnareas[ "allies" ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
        }
    }
    
    if ( level.var_3416583522672ad3 )
    {
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "axis" ], "axis" );
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "allies" ], "allies" );
        return;
    }
    
    spawnselection::setspawnlocations( level.spawnareas[ "axis" ], "axis" );
    spawnselection::setspawnlocations( level.spawnareas[ "allies" ], "allies" );
}

// Namespace bigctf
// Params 0
// Checksum 0x3842a68f, Offset: 0x7402
// Size: 0x509
function sethqmarkerobjective()
{
    visibility = "any";
    origin = level.gw_objstruct.axishqloc.trigger.origin;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "axis" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "axis" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_friendly" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 6 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.axishqloc.marker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "axis" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "allies" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_enemy" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 7 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.axishqloc.enemymarker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    origin = level.gw_objstruct.allieshqloc.trigger.origin;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "allies" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "allies" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_friendly" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 6 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.allieshqloc.marker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "allies" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "axis" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_enemy" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 7 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.allieshqloc.enemymarker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    level.spawnselectionteamforward = [];
    level.spawnselectionteamforward[ "allies" ] = vectornormalize( level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin );
    level.spawnselectionteamforward[ "axis" ] = vectornormalize( level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin );
}

// Namespace bigctf
// Params 0
// Checksum 0xce978e85, Offset: 0x7913
// Size: 0x28
function objective_oncontested()
{
    obj_dom::dompoint_oncontested();
    
    if ( !self.updatedoncontestedspawnselection )
    {
        updatefobspawnselection();
        self.updatedoncontestedspawnselection = 1;
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x3522ed68, Offset: 0x7943
// Size: 0x32
function objective_onuncontested( lastclaimteam )
{
    obj_dom::dompoint_onuncontested( lastclaimteam );
    
    if ( self.updatedoncontestedspawnselection )
    {
        updatefobspawnselection();
        self.updatedoncontestedspawnselection = 0;
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x80f8d0ad, Offset: 0x797d
// Size: 0x1c
function objective_onusebegin( player )
{
    obj_dom::dompoint_onusebegin( player );
    updatefobspawnselection();
}

// Namespace bigctf
// Params 3
// Checksum 0x3cd51425, Offset: 0x79a1
// Size: 0x30
function objective_onuseend( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    updatefobspawnselection();
}

// Namespace bigctf
// Params 1
// Checksum 0xb835b9c8, Offset: 0x79d9
// Size: 0x9c
function objective_onuse( claim_player )
{
    obj_dom::dompoint_onuse( claim_player );
    updatefobspawnselection();
    
    if ( level.var_65526c5c4e8f9d90 )
    {
        level thread namespace_14ab7f658b8ad5e4::function_cac6dbdf1966b849( self.objectivekey, self.ownerteam );
    }
    
    otherteam = team_utility::getotherteam( claim_player.team );
    arm_upgrades::function_db60687d3222dcb4( otherteam, self.objectivekey );
    arm_upgrades::function_da6d0f03ca3101ad( self.objectivekey, otherteam );
    arm_upgrades::function_6a2e5bbf85fdef54( self.objectivekey, self.ownerteam );
}

// Namespace bigctf
// Params 1
// Checksum 0x6a7e62e, Offset: 0x7a7d
// Size: 0x1c
function objective_onpinnedstate( player )
{
    updatefobspawnselection();
    obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace bigctf
// Params 1
// Checksum 0x429415f7, Offset: 0x7aa1
// Size: 0x1c
function objective_onunpinnedstate( player )
{
    updatefobspawnselection();
    obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace bigctf
// Params 2
// Checksum 0xb6330f8a, Offset: 0x7ac5
// Size: 0xe7
function runobjflag( objective, startingteam )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    objective.script_label = objective.objkey;
    domflag = obj_dom::setupobjective( objective, undefined, undefined, undefined, 0 );
    domflag.origin = objective.origin;
    domflag gameobjects::allowuse( "none" );
    domflag.didstatusnotify = 0;
    domflag gameobjects::setownerteam( startingteam );
    visibility = "any";
    
    if ( startingteam != "neutral" )
    {
        if ( level.hideenemyfobs )
        {
            visibility = "friendly";
        }
        
        domflag.capturetime = gettime();
    }
    
    domflag gameobjects::setvisibleteam( visibility );
    return domflag;
}

// Namespace bigctf
// Params 3
// Checksum 0x3e4aeba, Offset: 0x7bb5
// Size: 0x4b
function dropcrate( killstreakname, droplocation, team )
{
    crate = airdrop::droparmcratefromscriptedheli( team, killstreakname, droplocation.origin, ( 0, randomint( 360 ), 0 ), undefined );
    return crate;
}

// Namespace bigctf
// Params 3
// Checksum 0xe1020c9f, Offset: 0x7c09
// Size: 0x134
function docratedropsmoke( crate, droplocation, duration )
{
    var_281ff1613bb07988 = droplocation.origin + ( 0, 0, 2000 );
    spawnpos = utility::groundpos( var_281ff1613bb07988, ( 0, 0, 1 ) );
    droplocation.vfxent = spawn( "script_model", spawnpos );
    droplocation.vfxent setmodel( "tag_origin" );
    droplocation.vfxent.angles = ( 0, 0, 0 );
    droplocation.vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    wait 1;
    playfxontag( utility::getfx( "vfx_smk_signal_gr" ), droplocation.vfxent, "tag_origin" );
    
    if ( isdefined( crate ) )
    {
        crate utility::waittill_any_timeout( duration, "crate_dropped" );
    }
    else
    {
        wait duration;
    }
    
    stopfxontag( utility::getfx( "vfx_smk_signal_gr" ), droplocation.vfxent, "tag_origin" );
    droplocation.vfxent delete();
}

// Namespace bigctf
// Params 0
// Checksum 0x9020ef6e, Offset: 0x7d45
// Size: 0x1ab
function registervaliddroplocations()
{
    airdrop::initplundercratedata();
    level.validdroplocationstruct = spawnstruct();
    level.validdroplocationstruct.clusters = utility::getstructarray( "dropBagClusterNode", "script_noteworthy" );
    potentialdroplocations = utility::getstructarray( "dropBagLocation", "script_noteworthy" );
    
    foreach ( location in potentialdroplocations )
    {
        location.inuse = 0;
        
        foreach ( cluster in level.validdroplocationstruct.clusters )
        {
            if ( location.target == cluster.targetname )
            {
                if ( !isdefined( cluster.droplocations ) )
                {
                    cluster.droplocations = [];
                }
                
                cluster.droplocations[ cluster.droplocations.size ] = location;
            }
        }
    }
    
    level.nextkillstreakgoal = 100;
    
    if ( false )
    {
        thread debug_testcratedroplocationpicker();
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x99092bfc, Offset: 0x7ef8
// Size: 0x14
function debug_testcratedroplocationpicker()
{
    while ( true )
    {
        choosecratelocation();
        wait 1;
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x3797eb9f, Offset: 0x7f14
// Size: 0x41
function checkkillstreakcratedrop( team )
{
    if ( game[ "teamScores" ][ team ] >= level.nextkillstreakgoal )
    {
        level.nextkillstreakgoal += 100;
        dropkillstreakcrates( 2 );
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x3fca6316, Offset: 0x7f5d
// Size: 0xd1
function dropkillstreakcrates( var_c214785f2fc4e656 )
{
    owningplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            owningplayer = player;
            break;
        }
    }
    
    for ( i = 0; i < var_c214785f2fc4e656 ; i++ )
    {
        location = choosecratelocation();
        thread runkillstreakreward( location, owningplayer, getkillstreak( 1 ) );
        wait 5;
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x226016eb, Offset: 0x8036
// Size: 0x175
function choosecratelocation()
{
    randfrac = randomfloatrange( 0, 1 );
    var_3d28facc2e2d628a = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, randfrac );
    var_3d28f9cc2e2d6057 = vectorlerp( level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, randfrac );
    var_940651cc6f36caac = vectorlerp( var_3d28facc2e2d628a, var_3d28f9cc2e2d6057, 0.5 );
    trace = trace::ray_trace( var_940651cc6f36caac, var_940651cc6f36caac - ( 0, 0, 100000 ) );
    var_940651cc6f36caac = trace[ "position" ];
    var_ef72f25a3bc4b7f8 = findclosestdroplocation( var_940651cc6f36caac );
    
    if ( false )
    {
        thread debug::drawsphere( var_3d28facc2e2d628a, 1000, 100, ( 0, 0, 1 ) );
        thread debug::drawsphere( var_3d28f9cc2e2d6057, 1000, 100, ( 0, 0, 1 ) );
        thread debug::drawsphere( var_940651cc6f36caac, 1000, 100, ( 1, 0, 0 ) );
        thread debug::drawsphere( var_ef72f25a3bc4b7f8.origin, 1000, 100, ( 0, 1, 0 ) );
        thread debug::drawline( var_940651cc6f36caac, var_ef72f25a3bc4b7f8.origin, 3, ( 0, 1, 0 ) );
    }
    
    return var_ef72f25a3bc4b7f8;
}

// Namespace bigctf
// Params 1
// Checksum 0x502b3997, Offset: 0x81b4
// Size: 0x143
function findclosestdroplocation( origin )
{
    var_a81d35a55404701b = sortbydistance( level.validdroplocationstruct.clusters, origin );
    
    foreach ( cluster in var_a81d35a55404701b )
    {
        var_fa99ddd29deeab6f = arrayrandomize( cluster.droplocations );
        
        if ( false )
        {
            return var_fa99ddd29deeab6f[ 0 ];
        }
        
        foreach ( location in var_fa99ddd29deeab6f )
        {
            if ( !location.inuse )
            {
                location.inuse = 1;
                return location;
            }
        }
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x92ea23ea, Offset: 0x8300
// Size: 0x107
function choosenukecratelocation()
{
    randx = randomfloatrange( level.mapsafecorners[ 1 ][ 0 ], level.mapsafecorners[ 0 ][ 0 ] );
    randy = randomfloatrange( level.mapsafecorners[ 1 ][ 1 ], level.mapsafecorners[ 0 ][ 1 ] );
    var_940651cc6f36caac = ( randx, randy, 100000 );
    trace = trace::ray_trace( var_940651cc6f36caac, var_940651cc6f36caac - ( 0, 0, 100000 ) );
    var_940651cc6f36caac = trace[ "position" ];
    var_ef72f25a3bc4b7f8 = findclosestdroplocation( var_940651cc6f36caac );
    
    if ( false )
    {
        thread debug::drawsphere( var_940651cc6f36caac, 1000, 100, ( 1, 0, 0 ) );
        thread debug::drawsphere( var_ef72f25a3bc4b7f8, 1000, 100, ( 0, 1, 0 ) );
        thread debug::drawline( var_940651cc6f36caac, var_ef72f25a3bc4b7f8.origin, 3, ( 0, 1, 0 ) );
    }
    
    return var_ef72f25a3bc4b7f8;
}

// Namespace bigctf
// Params 3
// Checksum 0xf62a2205, Offset: 0x8410
// Size: 0x246
function runkillstreakreward( location, creditplayer, streakname )
{
    level endon( #"game_ended" );
    crate = undefined;
    object = gameobjects::createobjidobject( location.origin, "neutral", ( 0, 0, 72 ), undefined, "any" );
    object.origin = location.origin;
    object.angles = location.angles;
    thread docratedropsmoke( undefined, location, 16 );
    object.iconname = "_incoming";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( streakname );
    object.lockupdatingicons = 1;
    wait 4;
    crate = airdrop::droparmcratefromscriptedheli( creditplayer.team, streakname, location.origin, ( 0, randomint( 360 ), 0 ), undefined );
    crate.skipminimapicon = 1;
    crate.nevertimeout = 0;
    crate.waitforobjectiveactivate = 1;
    crate.killminimapicon = 0;
    crate.disallowheadiconid = 1;
    crate.isarmcrate = 1;
    crate waittill( #"crate_dropped" );
    object.useobj = crate;
    object.origin = crate.origin;
    wait 1;
    crate notify( #"objective_activate" );
    objidpoolmanager::update_objective_onentity( object.objidnum, crate );
    objidpoolmanager::update_objective_setzoffset( object.objidnum, 72 );
    object.iconname = "";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( streakname );
    object.lockupdatingicons = 1;
    objective_setlabel( object.objidnum, "" );
    crate waittill( #"death" );
    object gameobjects::setvisibleteam( "none" );
    object gameobjects::releaseid();
    object.visibleteam = "none";
}

// Namespace bigctf
// Params 1
// Checksum 0x13d41c1a, Offset: 0x865e
// Size: 0x4c
function getkillstreak( tier )
{
    if ( !isdefined( level.killstreaktierlist ) )
    {
        processkillstreaksintotiers();
    }
    
    level.killstreaktierlist[ tier ] = arrayrandomize( level.killstreaktierlist[ tier ] );
    return level.killstreaktierlist[ tier ][ 0 ];
}

// Namespace bigctf
// Params 0
// Checksum 0xf6b598f7, Offset: 0x86b3
// Size: 0xa6
function processkillstreaksintotiers()
{
    level.killstreaktierlist = [];
    level.killstreaktierlist[ 3 ] = [ "cruise_predator", "scrambler_drone_guard", "uav" ];
    level.killstreaktierlist[ 2 ] = [ "precision_airstrike", "multi_airstrike", "bradley" ];
    level.killstreaktierlist[ 1 ] = [ "toma_strike", "uav", "pac_sentry", "white_phosphorus" ];
    level.killstreaktierlist[ 0 ] = [ "uav" ];
}

// Namespace bigctf
// Params 1
// Checksum 0x507c4214, Offset: 0x8761
// Size: 0x54
function br_getrewardicon( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( isdefined( bundle ) && isdefined( bundle.hudicon ) )
    {
        return bundle.hudicon;
    }
    
    return "";
}

// Namespace bigctf
// Params 0
// Checksum 0x29a89f55, Offset: 0x87be
// Size: 0x22
function nuke_mercyending_init()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( level.useobjectives )
    {
        level thread nuke_mercyending_think();
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x74223d9, Offset: 0x87e8
// Size: 0x72
function nuke_mercyending_think()
{
    level endon( #"game_ended" );
    level endon( #"hash_f820681d2ed0d10f" );
    
    while ( true )
    {
        if ( calculateobjectivesheld( "axis" ) == level.objectives.size )
        {
            level thread nuke_startmercycountdown( "axis" );
        }
        else if ( calculateobjectivesheld( "allies" ) == level.objectives.size )
        {
            level thread nuke_startmercycountdown( "allies" );
        }
        
        waitframe();
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x96affe63, Offset: 0x8862
// Size: 0xfb
function nuke_startmercycountdown( team )
{
    level notify( #"hash_f820681d2ed0d10f" );
    level endon( #"hash_71fa673dc344f809" );
    setomnvar( "ui_nuke_timer_type", 1 );
    setomnvar( "ui_arm_dominatingTeam", team == "axis" ? 1 : 2 );
    setomnvar( "ui_nuke_timer_time", level.mercymatchending_time );
    setomnvar( "ui_nuke_countdown_active", 1 );
    starttime = gettime();
    endtime = level.mercymatchending_time * 1000 + starttime;
    setomnvar( "ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime );
    
    while ( calculateobjectivesheld( team ) == level.objectives.size )
    {
        waitframe();
        
        if ( gettime() > endtime )
        {
            nuke_triggermercywin( team );
            level notify( #"hash_71fa673dc344f809" );
        }
    }
    
    setomnvar( "ui_nuke_countdown_active", 0 );
    level thread nuke_mercyending_think();
}

// Namespace bigctf
// Params 1
// Checksum 0x3977561a, Offset: 0x8965
// Size: 0x20f
function nuke_triggermercywin( team )
{
    level endon( #"game_ended" );
    level.mercywintriggered = 1;
    level.blocknukekills = 1;
    
    foreach ( objective in level.objectives )
    {
        objective gameobjects::allowuse( "none" );
    }
    
    setomnvar( "ui_nuke_countdown_active", 0 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !isbot( player ) && player.inspawnselection )
        {
            if ( isdefined( player.operatorsfx ) )
            {
                player clearsoundsubmix( "iw8_mp_spawn_camera" );
                player.operatorsfx stoploopsound( player.operatorsfxalias );
                player.operatorsfx delete();
                player.operatorsfx = undefined;
                player.operatorsfxalias = undefined;
            }
        }
    }
    
    if ( isdefined( level.teamdata[ team ][ "alivePlayers" ][ 0 ] ) )
    {
        var_78e28e74ac1a8348 = level.teamdata[ team ][ "alivePlayers" ][ 0 ];
        var_78e28e74ac1a8348 nuke::tryusenuke( "nuke_multi" );
        return;
    }
    
    level thread gamelogic_mp::endgame( team, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 0, 1 );
}

// Namespace bigctf
// Params 1
// Checksum 0x8731dbb8, Offset: 0x8b7c
// Size: 0x8c
function nukeselectgimmewatcher( killer )
{
    if ( !killer.hasnukeselectks )
    {
        remainder = killer.killcountthislife % level.killstoearnnukeselect;
        
        if ( remainder >= 0 && killer.killcountthislife >= level.killstoearnnukeselect )
        {
            killer.hasnukeselectks = 1;
            killer thread killstreaks::givekillstreak( "nuke_select_location", 0, killer );
            killer hud_message::showkillstreaksplash( "nuke_select_location", undefined, 1 );
        }
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x3a26242, Offset: 0x8c10
// Size: 0x1c0
function initspawns( var_ac03d2bf36c55e04 )
{
    level.gamemodestartspawnpointnames = [];
    var_8e0b555d6a1fce7c = "mp_gw_spawn_allies_start";
    var_ce31d0f10d5f8fab = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames[ "allies" ] = var_8e0b555d6a1fce7c;
    level.gamemodestartspawnpointnames[ "axis" ] = var_ce31d0f10d5f8fab;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames[ "allies" ] = "mp_tdm_spawn";
    level.gamemodespawnpointnames[ "axis" ] = "mp_tdm_spawn";
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( var_8e0b555d6a1fce7c );
    spawnlogic::addstartspawnpoints( var_ce31d0f10d5f8fab );
    spawnlogic::addspawnpointslegacy( game[ "attackers" ], var_8e0b555d6a1fce7c );
    spawnlogic::addspawnpointslegacy( game[ "defenders" ], var_ce31d0f10d5f8fab );
    attackers = spawnlogic::getspawnpointarray( var_8e0b555d6a1fce7c );
    defenders = spawnlogic::getspawnpointarray( var_ce31d0f10d5f8fab );
    spawnlogic::registerspawnset( #"start_attackers", attackers );
    spawnlogic::registerspawnset( #"start_defenders", defenders );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
}

// Namespace bigctf
// Params 1
// Checksum 0xc2b1aaff, Offset: 0x8dd8
// Size: 0x41c
function onuse( player )
{
    if ( !level.gameended )
    {
        if ( player vehicle::is_in_vehicle() )
        {
            return;
        }
        
        team = player.pers[ "team" ];
        
        if ( team == "allies" )
        {
            otherteam = "axis";
        }
        else
        {
            otherteam = "allies";
        }
        
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
        codcaster_utils::function_3038b6eafc46c037( 17, player.team, player getentitynumber() );
        objective_state( level.teamflags[ otherteam ].pingobjidnum, "done" );
        player updatematchstatushintonnoflag();
        thread hud_util::teamplayercardsplash( "callout_flagcapture", player );
        player thread rank::scoreeventpopup( #"flag_capture" );
        player thread points::doscoreevent( #"mode_ctf_cap" );
        player notify( #"objective", "captured" );
        telemetry_data = spawnstruct();
        telemetry_data.player = player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "captures" ] ) )
            {
                player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
            {
                [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x9a>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        
        if ( isplayer( player ) )
        {
            player stats::setextrascore0( player.pers[ "captures" ] );
        }
        
        player playsoundtoteam( "uin_mp_flag_ally_captured", team );
        player playsoundtoteam( "uin_mp_flag_enemy_captured", otherteam );
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        if ( isdefined( level.ctf_loadouts[ team ] ) )
        {
            player thread removeflagcarrierclass();
        }
        
        level.closecapturekiller[ team ] = undefined;
        level.closecapturekiller[ otherteam ] = undefined;
        
        if ( level.codcasterenabled )
        {
            level.capzones[ otherteam ] gameobjects::resetmlgobjectivestatusicon();
        }
        
        level.teamflags[ otherteam ] returnflag();
        level gamescore::giveteamscoreforobjective( team, 1, 0 );
        teamscore = int( game[ "teamScores" ][ team ] );
        otherteamscore = int( game[ "teamScores" ][ otherteam ] );
        
        if ( teamscore == otherteamscore && teamscore == level.roundscorelimit - 1 && otherteamscore == level.roundscorelimit - 1 )
        {
            dialog::leaderdialog( "one_cap_tied", team, "status" );
            dialog::leaderdialog( "one_cap_tied", otherteam, "status" );
        }
        
        if ( teamscore == level.roundscorelimit - 1 )
        {
            dialog::leaderdialog( "enemy_one_cap_left", team, "status" );
            dialog::leaderdialog( "ally_one_cap_left", otherteam, "status" );
            return;
        }
        
        dialog::leaderdialog( "enemy_captured", team, "status" );
        dialog::leaderdialog( "ally_captured", otherteam, "status" );
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x49d7651c, Offset: 0x91fc
// Size: 0x121
function calculatespawndisttozones( spawnpoint )
{
    spawnpoint.scriptdata.distsqtokothzones = [];
    
    foreach ( zone in level.objectives )
    {
        dist = distance( spawnpoint.origin, zone.origin );
        
        if ( dist < 0 )
        {
            dist = distance2dsquared( spawnpoint.origin, zone.origin );
        }
        else
        {
            dist *= dist;
        }
        
        spawnpoint.scriptdata.distsqtokothzones[ zone getentitynumber() ] = dist;
        
        if ( dist > zone.furthestspawndistsq )
        {
            zone.furthestspawndistsq = dist;
        }
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xfc2b7f74, Offset: 0x9325
// Size: 0x122
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            spawnlogic::activatespawnset( #"start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
        }
        else
        {
            spawnlogic::activatespawnset( #"start_defenders", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
        }
    }
    else
    {
        spawnlogic::activatespawnset( #"primary", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"fallback" );
    }
    
    if ( level.usesquadspawn && self.squadspawnconfirmed )
    {
        spectatingteammate = self getspectatingplayer();
        
        if ( isdefined( spectatingteammate ) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid )
        {
            spawnpoint = spawnscoring::findteammatebuddyspawn( spectatingteammate );
        }
    }
    
    return spawnpoint;
}

// Namespace bigctf
// Params 1
// Checksum 0xb503dea4, Offset: 0x9450
// Size: 0x3d
function onspawnplayer( revivespawn )
{
    self.forcespawnnearteammates = undefined;
    thread updatematchstatushintonspawn();
    cash::function_3909082084ad6974();
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
}

// Namespace bigctf
// Params 0
// Checksum 0xdfd30ee2, Offset: 0x9495
// Size: 0x3e
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.nukeprogress ) )
    {
        hud_message::function_ef4318a0090caa0f( #"nuke_capture" );
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"dom_cap_defend" );
}

// Namespace bigctf
// Params 1
// Checksum 0x9628af7f, Offset: 0x94db
// Size: 0x227
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
    victim squads::updatesquadomnvars( victim.team, victim.sessionsquadid );
    victim obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( level.dropbrloot )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = 14;
        victim br_plunder::playerdropplunderondeath( dropstruct, attacker, 1 );
    }
    
    if ( level.nukeselectactive && isplayer( attacker ) && smeansofdeath != "MOD_SUICIDE" )
    {
        if ( !attacker.hasnukeselectks )
        {
            if ( !isdefined( attacker.killcountthislife ) )
            {
                attacker.killcountthislife = 0;
            }
            
            attacker.killcountthislife++;
        }
        
        nukeselectgimmewatcher( attacker );
    }
    
    if ( !isdefined( level.c130pathkilltracker ) || level.c130movementmethod != 1 )
    {
        return;
    }
    
    if ( isdefined( victim.carryflag ) )
    {
        victim detachflag();
    }
    
    level.c130pathkilltracker[ victim.team ] += 1;
}

// Namespace bigctf
// Params 0
// Checksum 0x3b504b9f, Offset: 0x970a
// Size: 0x2f
function detachflag()
{
    if ( !isdefined( self.carryflag ) )
    {
        return;
    }
    
    self detach( self.carryflag, "tag_stowed_back3" );
    self.carryflag = undefined;
}

// Namespace bigctf
// Params 1
// Checksum 0x4194efec, Offset: 0x9741
// Size: 0x238
function managedroppedents( droppedents )
{
    if ( !isdefined( level.br_droppedloot ) )
    {
        level.br_droppedloot = [];
    }
    
    if ( level.br_droppedloot.size > 64 )
    {
        for ( i = 0; i < 16 ; i++ )
        {
            if ( isdefined( level.br_droppedloot[ i ] ) )
            {
                level.br_droppedloot[ i ] delete();
                level.br_droppedloot[ i ] = undefined;
            }
        }
        
        temparray = [];
        
        for ( i = 16; i < level.br_droppedloot.size ; i++ )
        {
            temparray[ i - 16 ] = level.br_droppedloot[ i ];
        }
        
        level.br_droppedloot = temparray;
    }
    
    foreach ( ent in droppedents )
    {
        level.br_droppedloot[ level.br_droppedloot.size ] = ent;
    }
    
    if ( !isdefined( level.br_pickups.droppeditems ) )
    {
        level.br_pickups.droppeditems = [];
    }
    
    if ( level.br_pickups.droppeditems.size > 64 )
    {
        for ( i = 0; i < 16 ; i++ )
        {
            if ( isdefined( level.br_pickups.droppeditems[ i ] ) )
            {
                level.br_pickups.droppeditems[ i ] delete();
                level.br_pickups.droppeditems[ i ] = undefined;
            }
        }
        
        temparray = [];
        
        for ( i = 16; i < level.br_pickups.droppeditems.size ; i++ )
        {
            temparray[ i - 16 ] = level.br_pickups.droppeditems[ i ];
        }
        
        level.br_pickups.droppeditems = temparray;
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x9d2b88b1, Offset: 0x9981
// Size: 0x74
function onplayerconnect( player )
{
    player stats::setextrascore0( player.pers[ "captures" ] ?? 0, "captures" );
    player stats::setextrascore1( player.pers[ "returns" ] ?? 0, "returns" );
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        thread rally_point::rallypoint_showtoplayer( player );
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace bigctf
// Params 1
// Checksum 0x8ce6827b, Offset: 0x99fd
// Size: 0xc
function onplayerdisconnect( player )
{
    
}

// Namespace bigctf
// Params 0
// Checksum 0x64e156fe, Offset: 0x9a11
// Size: 0x7b
function updategamemodespawncamera()
{
    activezonename = "lane02_4";
    
    if ( isdefined( level.activezone ) )
    {
        activezonename = level.activezone.zonetrigger.script_label;
    }
    
    spawncamera::setgamemodecamera( "allies", level.spawncameras[ activezonename ][ "allies" ] );
    spawncamera::setgamemodecamera( "axis", level.spawncameras[ activezonename ][ "axis" ] );
}

// Namespace bigctf
// Params 0
// Checksum 0xde3b363f, Offset: 0x9a94
// Size: 0x162
function debugdrawtocameras()
{
    while ( true )
    {
        wait 0.25;
        
        if ( !isdefined( level.players[ 0 ] ) )
        {
            continue;
        }
        
        foreach ( teamarray in level.spawncameras )
        {
            foreach ( team, camera in teamarray )
            {
                thread debug::drawangles( camera.origin, camera.angles, 0.25, 50 );
                thread debug::drawsphere( camera.origin, 50, 0.25, team == "allies" ? ( 0, 0, 1 ) : ( 1, 0, 0 ) );
            }
        }
    }
}

// Namespace bigctf
// Params 1
// Checksum 0xd9b4ccc7, Offset: 0x9bfe
// Size: 0x22
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( #"spawned" );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0x617cfff9, Offset: 0x9c28
// Size: 0xc
function getrespawndelay()
{
    self.spawncameraskipthermal = 0;
}

// Namespace bigctf
// Params 6
// Checksum 0xba19bf2a, Offset: 0x9c3d
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace bigctf
// Params 0
// Checksum 0x8b533c4c, Offset: 0x9c8d
// Size: 0x18a
function initspecatatorcameras()
{
    level.spectatorcameras = [];
    level.currentspectatorcamref = "cop_2";
    configstructs = utility::getstructarray( "tac_ops_map_config", "targetname" );
    
    foreach ( configstruct in configstructs )
    {
        configref = configstruct.script_noteworthy;
        childstructs = utility::getstructarray( configstruct.target, "targetname" );
        
        foreach ( childstruct in childstructs )
        {
            switch ( childstruct.script_label )
            {
                case #"hash_11e1630c6c429f23":
                    setteammapposition( configref, "allies", childstruct );
                    break;
                case #"hash_e66f1db565904926":
                    setteammapposition( configref, "axis", childstruct );
                    break;
            }
        }
    }
}

// Namespace bigctf
// Params 3
// Checksum 0xcf92ced4, Offset: 0x9e1f
// Size: 0x4b
function setteammapposition( configref, team, posinfo )
{
    if ( !isdefined( level.spectatorcameras[ configref ] ) )
    {
        level.spectatorcameras[ configref ] = [];
    }
    
    level.spectatorcameras[ configref ][ team ] = posinfo;
}

// Namespace bigctf
// Params 0
// Checksum 0xe8f05953, Offset: 0x9e72
// Size: 0x13
function applythermal()
{
    self visionsetthermalforplayer( "proto_apache_flir_mp" );
    self thermalvisionon();
}

// Namespace bigctf
// Params 0
// Checksum 0x8a2a9ff6, Offset: 0x9e8d
// Size: 0x8
function removethermal()
{
    self thermalvisionoff();
}

// Namespace bigctf
// Params 0
// Checksum 0x4b866451, Offset: 0x9e9d
// Size: 0x105
function startspectatorview()
{
    if ( game_utility_mp::isteamreviveenabled() )
    {
        return;
    }
    
    waitframe();
    player::updatesessionstate( "spectator" );
    spectating::setdisabled();
    
    if ( isdefined( self.lastdeathangles ) )
    {
        self setplayerangles( self.lastdeathangles );
    }
    
    wait 0.1;
    player::setdof_default();
    zoffset = 1000;
    var_b371bf092c77fda3 = self.origin + ( 0, 0, zoffset );
    var_9149918291092f13 = self.angles;
    self.deathspectatepos = var_b371bf092c77fda3;
    self.deathspectateangles = var_9149918291092f13;
    cameraent = spawn( "script_model", self getvieworigin() );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = var_9149918291092f13;
    self.spectatorcament = cameraent;
    self.isusingtacopsmapcamera = 1;
    self cameralinkto( cameraent, "tag_origin", 1 );
    thread dohalfwayflash();
    cameraent movecameratomappos( self, var_b371bf092c77fda3, var_9149918291092f13 );
}

// Namespace bigctf
// Params 0
// Checksum 0x14f30a69, Offset: 0x9faa
// Size: 0x16
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace bigctf
// Params 0
// Checksum 0xb94e3396, Offset: 0x9fc8
// Size: 0x1f
function endspectatorview()
{
    if ( !isdefined( self.spectatorcament ) )
    {
        return;
    }
    
    removethermal();
    thread runslamzoomonspawn();
}

// Namespace bigctf
// Params 3
// Checksum 0xdca1992, Offset: 0x9fef
// Size: 0xef
function movecameratomappos( player, var_9956298e86821c5a, finalangles )
{
    player endon( #"spawned_player" );
    self moveto( var_9956298e86821c5a, 2, 1, 1 );
    player playlocalsound( "mp_cmd_camera_zoom_out" );
    player setclienttriggeraudiozonepartialwithfade( "spawn_cam", 0.5, "mix" );
    self rotateto( finalangles, 2, 1, 1 );
    wait 1.1;
    driftoffset = anglestoforward( finalangles ) * 300;
    driftoffset *= ( 1, 1, 0 );
    
    if ( isdefined( player ) && isdefined( player.spectatorcament ) )
    {
        self moveto( var_9956298e86821c5a + driftoffset, 15, 1, 1 );
        player earthquakeforplayer( 0.03, 15, var_9956298e86821c5a + driftoffset, 1000 );
    }
}

// Namespace bigctf
// Params 0
// Checksum 0xe44d7d50, Offset: 0xa0e6
// Size: 0xea
function runslamzoomonspawn()
{
    self waittill( #"spawned_player" );
    targetpos = self geteye();
    targetangles = self.angles;
    player::updatesessionstate( "spectator" );
    self cameralinkto( self.spectatorcament, "tag_origin", 1 );
    self visionsetnakedforplayer( "tac_ops_slamzoom", 0.2 );
    self.spectatorcament moveto( targetpos, 0.5 );
    self playlocalsound( "mp_cmd_camera_zoom_in" );
    self clearclienttriggeraudiozone( 0.5 );
    self.spectatorcament rotateto( targetangles, 0.5, 0.5 );
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", 0 );
    thread playslamzoomflash();
    player::updatesessionstate( "playing" );
    self cameraunlink();
    self.spectatorcament delete();
}

// Namespace bigctf
// Params 0
// Checksum 0xb237607c, Offset: 0xa1d8
// Size: 0xd7
function playslamzoomflash()
{
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 1;
    overlay.foreground = 1;
    overlay setshader( "white", 640, 480 );
    overlay fadeovertime( 0.4 );
    overlay.alpha = 0;
    wait 0.4;
    overlay destroy();
}

// Namespace bigctf
// Params 0
// Checksum 0xe370b23b, Offset: 0xa2b7
// Size: 0x157
function arm_initoutofbounds()
{
    level.outofboundstriggers = [];
    potentialoobtriggers = getentarray( "OutOfBounds", #targetname );
    
    foreach ( trigger in potentialoobtriggers )
    {
        if ( isdefined( game_utility::getlocaleid() ) && isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == level.localeid && game_utility_mp::modeusesgroundwarteamoobtriggers( trigger ) )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        if ( level.mapname == "mp_nogales_gw2" && ispointinvolume( ( 20500, 31700, 2500 ), trigger ) && distancesquared( ( 14038, 35144, 4608 ), trigger.origin ) < 100 )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        trigger delete();
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x247b95a0, Offset: 0xa416
// Size: 0x1a
function debugprint( text )
{
    if ( false )
    {
        println( text );
    }
}

// Namespace bigctf
// Params 1
// Checksum 0xd83518a8, Offset: 0xa438
// Size: 0x5f
function isobjectivecontested( gameobject )
{
    if ( gameobject.ownerteam == "axis" )
    {
        return ( gameobject.numtouching[ "allies" ] > 0 );
    }
    
    if ( gameobject.ownerteam == "allies" )
    {
        return ( gameobject.numtouching[ "axis" ] > 0 );
    }
}

// Namespace bigctf
// Params 1
// Checksum 0x82f5cce9, Offset: 0xa49f
// Size: 0x9d
function calculateobjectivesheld( team )
{
    var_e75a27fd127b284f = 0;
    
    foreach ( objective in level.objectives )
    {
        if ( objective.ownerteam == team )
        {
            var_e75a27fd127b284f++;
        }
    }
    
    return var_e75a27fd127b284f;
}

// Namespace bigctf
// Params 12
// Checksum 0xd84ebc64, Offset: 0xa545
// Size: 0x1c2
function createhintobject( org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent )
{
    hintobj = undefined;
    
    if ( isdefined( useent ) )
    {
        hintobj = useent;
    }
    else
    {
        hintobj = spawn( "script_model", org );
    }
    
    hintobj makeusable();
    
    if ( isdefined( useent ) && isdefined( org ) )
    {
        assert( isstring( org ), "<dev string:x104>" );
        hintobj sethinttag( org );
    }
    
    if ( isdefined( type ) )
    {
        hintobj setcursorhint( type );
    }
    else
    {
        hintobj setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( icon ) )
    {
        hintobj sethinticon( icon );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintobj sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        hintobj setusepriority( priority );
    }
    else
    {
        hintobj setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        hintobj setuseholdduration( duration );
    }
    else
    {
        hintobj setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        hintobj sethintonobstruction( onobstruction );
    }
    else
    {
        hintobj sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        hintobj sethintdisplayrange( hintdist );
    }
    else
    {
        hintobj sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        hintobj sethintdisplayfov( hintfov );
    }
    else
    {
        hintobj sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        hintobj setuserange( usedist );
    }
    else
    {
        hintobj setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        hintobj setusefov( usefov );
    }
    else
    {
        hintobj setusefov( 120 );
    }
    
    if ( !isdefined( useent ) )
    {
        return hintobj;
    }
}

/#

    // Namespace bigctf
    // Params 0
    // Checksum 0x99dff1e1, Offset: 0xa70f
    // Size: 0x541, Type: dev
    function function_662cf4c1bdb0bdc3()
    {
        setdevdvar( @"hash_24d9f7f9324e9c61", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_24d9f7f9324e9c61" ) != 0 )
            {
                if ( isdefined( level.lane_1_obj_struct ) )
                {
                    foreach ( cluster in level.lane_1_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.lane_2_obj_struct ) )
                {
                    foreach ( cluster in level.lane_2_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.lane_3_obj_struct ) )
                {
                    foreach ( cluster in level.lane_3_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:x25>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:x25>" ] )
                    {
                        thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:x161>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:x161>" ] )
                    {
                        thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:x164>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:x164>" ] )
                    {
                        thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace bigctf
    // Params 1
    // Checksum 0x3180e3cc, Offset: 0xac58
    // Size: 0x71d, Type: dev
    function function_c7f22dd7cb861f3( var_b93b834d7024dd99 )
    {
        if ( var_b93b834d7024dd99 <= 5 )
        {
            key = "<dev string:x167>" + var_b93b834d7024dd99;
            spawns_axis = level.spawnselectionlocations[ key ][ "<dev string:x2f>" ].spawnpoints;
            spawns_allies = level.spawnselectionlocations[ key ][ "<dev string:x28>" ].spawnpoints;
            
            foreach ( spawnpos in spawns_axis )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 1000 ), 60, ( 1, 0, 0 ) );
            }
            
            foreach ( spawnpos in spawns_allies )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 0, 0, 1 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 1000 ), 60, ( 0, 0, 1 ) );
            }
            
            safekey = "<dev string:x167>" + var_b93b834d7024dd99 + "<dev string:x170>";
            var_7515b299e5fb9abe = undefined;
            var_243741269fbac141 = undefined;
            
            if ( isdefined( level.spawnselectionlocations[ safekey ][ "<dev string:x2f>" ] ) )
            {
                var_7515b299e5fb9abe = level.spawnselectionlocations[ safekey ][ "<dev string:x2f>" ].spawnpoints;
            }
            
            if ( isdefined( level.spawnselectionlocations[ safekey ][ "<dev string:x28>" ] ) )
            {
                var_243741269fbac141 = level.spawnselectionlocations[ safekey ][ "<dev string:x28>" ].spawnpoints;
            }
            
            if ( !isdefined( var_7515b299e5fb9abe ) )
            {
                var_7515b299e5fb9abe = spawns_axis;
            }
            
            if ( !isdefined( var_243741269fbac141 ) )
            {
                var_243741269fbac141 = spawns_allies;
            }
            
            foreach ( spawnpos in var_7515b299e5fb9abe )
            {
                thread debug::drawsphere( spawnpos.origin, 15, 60, ( 0.5, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 500 ), 60, ( 0.5, 0, 0 ) );
            }
            
            foreach ( spawnpos in var_243741269fbac141 )
            {
                thread debug::drawsphere( spawnpos.origin, 15, 60, ( 0, 0, 0.5 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 500 ), 60, ( 0, 0, 0.5 ) );
            }
            
            return;
        }
        
        if ( var_b93b834d7024dd99 == 6 )
        {
            key = "<dev string:x176>";
            spawns = level.spawnselectionlocations[ key ][ "<dev string:x2f>" ].spawnpoints;
            
            foreach ( spawnpos in spawns )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
            }
            
            return;
        }
        
        if ( var_b93b834d7024dd99 == 7 )
        {
            key = "<dev string:x184>";
            spawns = level.spawnselectionlocations[ key ][ "<dev string:x28>" ].spawnpoints;
            
            foreach ( spawnpos in spawns )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
            }
        }
    }

#/

// Namespace bigctf
// Params 3
// Checksum 0xd7e66166, Offset: 0xb37d
// Size: 0x213
function calculatedroplocationnearlocation( location, mindist, maxdist )
{
    pos = location.origin;
    x = undefined;
    y = undefined;
    diceroll = randomint( 2 );
    direction = diceroll ? -1 : 1;
    
    if ( direction > 0 )
    {
        x = randomfloatrange( pos[ 0 ] + mindist * direction, pos[ 0 ] + maxdist * direction );
        
        if ( x >= level.br_level.br_corners[ 0 ][ 0 ] )
        {
            x = level.br_level.br_corners[ 0 ][ 0 ] - 250;
        }
    }
    else
    {
        x = randomfloatrange( pos[ 0 ] + maxdist * direction, pos[ 0 ] + mindist * direction );
        
        if ( x <= level.br_level.br_corners[ 1 ][ 0 ] )
        {
            x = level.br_level.br_corners[ 1 ][ 0 ] + 250;
        }
    }
    
    diceroll = randomint( 2 );
    direction = diceroll ? -1 : 1;
    
    if ( direction > 0 )
    {
        y = randomfloatrange( pos[ 1 ] + mindist * direction, pos[ 1 ] + maxdist * direction );
        
        if ( y >= level.br_level.br_corners[ 0 ][ 1 ] )
        {
            y = level.br_level.br_corners[ 0 ][ 1 ] - 250;
        }
    }
    else
    {
        y = randomfloatrange( pos[ 1 ] + maxdist * direction, pos[ 1 ] + mindist * direction );
        
        if ( y >= level.br_level.br_corners[ 1 ][ 1 ] )
        {
            y = level.br_level.br_corners[ 1 ][ 1 ] + 250;
        }
    }
    
    droplocation = spawnstruct();
    droplocation.origin = ( x, y, pos[ 2 ] );
    return droplocation;
}

// Namespace bigctf
// Params 1
// Checksum 0xd9416e7a, Offset: 0xb599
// Size: 0xc5d
function getmissedinfilcamerapositions( team )
{
    assert( isdefined( game_utility::getlocaleid() ), "<dev string:x194>" );
    var_4d57251d6a098bb9 = spawnstruct();
    var_4d57251d6a098bb9.startorigin = undefined;
    var_4d57251d6a098bb9.endpos = undefined;
    
    if ( level.mapname == "mp_locale_test" )
    {
        switch ( level.localeid )
        {
            case #"hash_369d88655b32bac0":
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 2094, -1804, 2763 );
                    var_4d57251d6a098bb9.startangles = ( 54, 40, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 2094, -1804, 2763 );
                    var_4d57251d6a098bb9.endangles = ( 54, 40, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 2315, 1956, 2763 );
                    var_4d57251d6a098bb9.startangles = ( 54, 296, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 2094, -1804, 2763 );
                    var_4d57251d6a098bb9.endangles = ( 54, 40, 0 );
                }
                
                break;
            default:
                var_4d57251d6a098bb9.startorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.startangles = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endangles = ( 0, 0, 0 );
                break;
        }
    }
    else
    {
        switch ( level.localeid )
        {
            case #"hash_369d93655b32cc11":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 38864, -14018, -396 );
                    var_4d57251d6a098bb9.startangles = ( 3, 250, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 38473, -14077, 401 );
                    var_4d57251d6a098bb9.endangles = ( 15, 252, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 30526, -38262, -483 );
                    var_4d57251d6a098bb9.startangles = ( 0, 72, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 30024, -38403, 560 );
                    var_4d57251d6a098bb9.endangles = ( 19, 67, 0 );
                }
                
                break;
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 16977, -23256, 169 );
                    var_4d57251d6a098bb9.startangles = ( 9, 69, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 16899, -23467, 683 );
                    var_4d57251d6a098bb9.endangles = ( 15, 68, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 18607, 1423, -355 );
                    var_4d57251d6a098bb9.startangles = ( 8, 289, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 18100, 1083, 503 );
                    var_4d57251d6a098bb9.endangles = ( 22, 302, 0 );
                }
                
                break;
            case #"hash_369d88655b32bac0":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 18672, -26836, -129 );
                    var_4d57251d6a098bb9.startangles = ( 359, 76, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 18518, -26909, 314 );
                    var_4d57251d6a098bb9.endangles = ( 14, 69, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 18607, 1423, -355 );
                    var_4d57251d6a098bb9.startangles = ( 8, 289, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 18100, 1083, 503 );
                    var_4d57251d6a098bb9.endangles = ( 22, 302, 0 );
                }
                
                break;
            case #"hash_2cd4bf8e90f233e7":
            case #"hash_369d95655b32cf37":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 24893, 28349, 1408 );
                    var_4d57251d6a098bb9.startangles = ( 15, 54, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 25613, 29274, 1255 );
                    var_4d57251d6a098bb9.endangles = ( 19, 53, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 39490, 48919, 2302 );
                    var_4d57251d6a098bb9.startangles = ( 17, 235, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 39254, 48584, 1542 );
                    var_4d57251d6a098bb9.endangles = ( 18, 245, 0 );
                }
                
                break;
            case #"hash_369d89655b32bc53":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 48331, -24822, 514 );
                    var_4d57251d6a098bb9.startangles = ( 12, 77, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 48424, -24421, -240 );
                    var_4d57251d6a098bb9.endangles = ( 2, 77, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 46188, 2520, 49 );
                    var_4d57251d6a098bb9.startangles = ( 7, 295, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 46571, 2664, 526 );
                    var_4d57251d6a098bb9.endangles = ( 16, 276, 0 );
                }
                
                break;
            case #"hash_2cd4bd8e90f230c1":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( -11083, 22197, 381 );
                    var_4d57251d6a098bb9.startangles = ( 10, 181, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -12112, 23761, 381 );
                    var_4d57251d6a098bb9.endangles = ( 11, 201, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( -31134, 11924, -116 );
                    var_4d57251d6a098bb9.startangles = ( 0, 36, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -31134, 11924, 434 );
                    var_4d57251d6a098bb9.endangles = ( 11, 36, 0 );
                }
                
                break;
            case #"hash_2cd4be8e90f23254":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 9215, 984, 325 );
                    var_4d57251d6a098bb9.startangles = ( 357, 186, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 9107, 628, 1144 );
                    var_4d57251d6a098bb9.endangles = ( 19, 182, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( -5351, 641, 408 );
                    var_4d57251d6a098bb9.startangles = ( 2, 352, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -5282, 996, 1103 );
                    var_4d57251d6a098bb9.endangles = ( 11, 347, 0 );
                }
                
                break;
            case #"hash_2cd4b58e90f22429":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( -22847, -28632, 34 );
                    var_4d57251d6a098bb9.startangles = ( 12, 42, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -22694, -28429, 356 );
                    var_4d57251d6a098bb9.endangles = ( 12, 40, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( -8084, -20649, 72 );
                    var_4d57251d6a098bb9.startangles = ( 10, 185, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -9092, -20635, 224 );
                    var_4d57251d6a098bb9.endangles = ( 12, 184, 0 );
                }
                
                break;
            case #"hash_2cd7bb8e90f46c32":
            case #"hash_2cdb2a8e90f75986":
            case #"hash_2cdb2d8e90f75e3f":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( -8111.37, -50208.9, 1201.16 );
                    var_4d57251d6a098bb9.startangles = ( 15, 176, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -13177.5, -45326.2, 2957.64 );
                    var_4d57251d6a098bb9.endangles = ( 41, 267, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 7966.23, -35390.7, 1891.99 );
                    var_4d57251d6a098bb9.startangles = ( 19, 352, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 11447.2, -40764, 2908.09 );
                    var_4d57251d6a098bb9.endangles = ( 29, 76, 0 );
                }
                
                break;
            case #"hash_2ce1348e90fbe672":
            case #"hash_2ce1358e90fbe805":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( -37269.9, -27684.2, 1093.4 );
                    var_4d57251d6a098bb9.startangles = ( 13, 135, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -38918.5, -22218, 2139 );
                    var_4d57251d6a098bb9.endangles = ( 37, 240, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( -31446.2, -18677.9, 883.622 );
                    var_4d57251d6a098bb9.startangles = ( 10, 36, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -30766.5, -23149.7, 1726.86 );
                    var_4d57251d6a098bb9.endangles = ( 34, 42, 0 );
                }
                
                break;
            case #"hash_8c21d36e30da718e":
                if ( team == "allies" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 7124, 11776, 2556 );
                    var_4d57251d6a098bb9.startangles = ( 13.829, 335.3, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 9004, 10088, 1988 );
                    var_4d57251d6a098bb9.endangles = ( 24.9985, 220.001, -0.000213426 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( -15827.3, -133.42, 1550.86 );
                    var_4d57251d6a098bb9.startangles = ( 13.829, 335.3, 0 );
                    var_4d57251d6a098bb9.endorigin = ( -14335.3, -3621.42, 1550.86 );
                    var_4d57251d6a098bb9.endangles = ( 8.53518, 55.9275, 2.37782 );
                }
                
                break;
            default:
                var_4d57251d6a098bb9.startorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.startangles = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endangles = ( 0, 0, 0 );
                break;
        }
    }
    
    return var_4d57251d6a098bb9;
}

// Namespace bigctf
// Params 0
// Checksum 0x29dfecf5, Offset: 0xc1ff
// Size: 0xea
function calculatehqmidpoint()
{
    level.hqmidpoint = ( level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin ) * 0.5;
    level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
    level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
    level.hqdisttomid = length( level.hqvecttomid_axis );
}

// Namespace bigctf
// Params 2
// Checksum 0x629b6bbd, Offset: 0xc2f1
// Size: 0x256
function calculatecameraoffset( team, objectiveorigin )
{
    switch ( level.mapname )
    {
        case #"hash_7a28db3c5928c489":
            var_9aeeec533ac4cd45 = 0.25;
            var_f776d2686256c018 = 0.35;
            break;
        case #"hash_863773b8960b3944":
            var_9aeeec533ac4cd45 = 0.25;
            var_f776d2686256c018 = 0.8;
            break;
        case #"hash_a8b272dba33a4aed":
            var_9aeeec533ac4cd45 = 0.5;
            var_f776d2686256c018 = 0.3;
            break;
        default:
            var_9aeeec533ac4cd45 = 0;
            var_f776d2686256c018 = 0;
            break;
    }
    
    len = distance( objectiveorigin, level.hqmidpoint );
    
    if ( len < 2048 )
    {
        return ( 0, 0, 0 );
    }
    
    if ( team == "axis" )
    {
        var_367861ab2439dd31 = distance( level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin );
        fulloffset = level.hqvecttomid_axis;
    }
    else
    {
        var_367861ab2439dd31 = distance( level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin );
        fulloffset = level.hqvecttomid_allies;
    }
    
    if ( var_367861ab2439dd31 < 2048 )
    {
        return ( fulloffset * var_9aeeec533ac4cd45 );
    }
    
    if ( var_367861ab2439dd31 > level.hqdisttomid )
    {
        if ( team == "axis" )
        {
            var_367861ab2439dd31 = distance( level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin );
        }
        else
        {
            var_367861ab2439dd31 = distance( level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin );
        }
        
        percentage = 100 - var_367861ab2439dd31 * 100 / level.hqdisttomid;
        offset = fulloffset * var_f776d2686256c018 * -1 * percentage / 100;
        return offset;
    }
    
    percentage = 100 - var_367861ab2439dd31 * 100 / level.hqdisttomid;
    offset = fulloffset * var_9aeeec533ac4cd45 * percentage / 100;
    return offset;
}

// Namespace bigctf
// Params 0
// Checksum 0xfb0178c8, Offset: 0xc54f
// Size: 0x29, Type: bool
function spawnprotectionexception()
{
    if ( isdefined( self.selectedspawnarea ) && issubstr( self.selectedspawnarea, "HQ" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bigctf
// Params 0
// Checksum 0xcb26bd68, Offset: 0xc581
// Size: 0x11
function function_e42623be2d62d389()
{
    wait 5;
    audio_utility::snd_transient_load( "mp_gamemode_gw" );
}

