// scripts\mp\gametypes\ko.gsc  (hash_12ccf3c0663c2738.gscc) (size: 42449 Bytes / 0xa5d1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae2c9093 (2922156179)
// size ...... 42449 (0xa5d1)
// includes .. 44  (offset: 0x9759)
// strings ... 154 (offset: 0x98b9)
// dev strs .. 8   (offset: 0xa551)
// exports ... 65  (offset: 0x6d65)
// cseg ...... 0xcda + 0x608b (0x6d65)
// imports ... 251 (offset: 0x778d)
// animtree1 . 0   (offset: 0xa5d1)
// animtree2 . 0   (offset: 0xa5d1)
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\teamrevive;

#namespace ko;

// Namespace ko
// Params 0
// Checksum 0xb0fd0c8c, Offset: 0xcf8
// Size: 0x75d
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    level.var_bbafbc222fd80343 = 0;
    matchmakingmatch = getdvarint( @"onlinegame" ) && !getdvarint( @"xblive_privatematch" );
    
    if ( matchmakingmatch )
    {
        level.var_bbafbc222fd80343 = getdvarint( @"hash_2c1108728124dd3", 0 );
    }
    
    /#
        level.var_bbafbc222fd80343 = getdvarint( @"hash_2c1108728124dd3", 0 );
    #/
    
    level.allowmodestructs = [];
    
    if ( level.var_bbafbc222fd80343 )
    {
        level.allowmodestructs[ level.allowmodestructs.size ] = "arm";
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    
    if ( level.var_bbafbc222fd80343 )
    {
        allowed[ allowed.size ] = "arm";
    }
    
    level.koflag_starts = [];
    
    if ( level.var_bbafbc222fd80343 )
    {
        possibleents = getentarray( "gw_fob_03", #targetname );
        level.koflag_starts = possibleents[ 0 ].origin;
    }
    else
    {
        cyberemptriggers = getentarray( "cyber_emp_pickup_trig", #targetname );
        
        foreach ( trig in cyberemptriggers )
        {
            level.koflag_starts[ level.koflag_starts.size ] = trig.origin;
        }
        
        if ( level.koflag_starts.size == 0 )
        {
            level.koflag_starts[ 0 ] = ( 0, 0, 0 );
            primaryflags = getentarray( "flag_primary", #targetname );
            
            foreach ( flag in primaryflags )
            {
                if ( flag.script_label == "_b" )
                {
                    level.koflag_starts[ 0 ] = flag.origin;
                    break;
                }
            }
        }
    }
    
    for ( i = 0; i < level.koflag_starts.size ; i++ )
    {
        level.koflag_starts[ i ] = function_5cf40bcccfb2134a( level.koflag_starts[ i ] );
    }
    
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.objectivebased = 1;
    level.teambased = 1;
    println( "<dev string:x24>" + gettime() );
    level callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.nobuddyspawns = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerconnect = &onplayerconnect;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.onnormaldeath = &onnormaldeath;
    level.onobjectivecomplete = &function_a44d2590e4f6115a;
    level.onmaprestart = &function_82b1f7f5bbaa2f51;
    level.var_59abd25eeb5b2fed = &function_9e3ba7e27aef8223;
    level.allowlatecomers = 0;
    game[ "canScoreOnTie" ] = 0;
    
    if ( level.var_bbafbc222fd80343 )
    {
        level.requiredplayercountoveride = 1;
        level.requiredplayercount[ "allies" ] = 12;
        level.requiredplayercount[ "axis" ] = 12;
        level.modecontrolledvehiclespawningonly = 1;
        level.maxhqtanks = 0;
        level.numnonrallyvehicles = getdvarint( @"scr_ko_numnonrallyvehicles", 25 );
        level.skipplaybodycountsound = 1;
        mapname = game_utility::getmapname();
        
        switch ( mapname )
        {
            case #"hash_12f3765ef24b4037":
            case #"hash_1bc93b88575e82eb":
            case #"hash_32eaa112f8caa7e4":
            case #"hash_3a8b050ff58578ad":
            case #"hash_50de71be6e7469ff":
            case #"hash_7a28db3c5928c489":
            case #"hash_863773b8960b3944":
            case #"hash_924a3fbe9fbe15c6":
            case #"hash_e4ca6b73b5022b26":
                parachute::initparachutedvars();
                break;
            default:
                break;
        }
        
        if ( !isdefined( game_utility::getlocaleid() ) )
        {
            switch ( mapname )
            {
                case #"hash_32eaa112f8caa7e4":
                    game_utility::setlocaleid( 6 );
                    break;
                case #"hash_7a28db3c5928c489":
                    game_utility::setlocaleid( 5 );
                    break;
                case #"hash_50de71be6e7469ff":
                case #"hash_863773b8960b3944":
                    game_utility::setlocaleid( 9 );
                    break;
                case #"hash_12f3765ef24b4037":
                    game_utility::setlocaleid( 3 );
                    break;
                case #"hash_924a3fbe9fbe15c6":
                    game_utility::setlocaleid( 4 );
                    break;
                case #"hash_a8b272dba33a4aed":
                    game_utility::setlocaleid( 17 );
                    break;
                case #"hash_1bc93b88575e82eb":
                    game_utility::setlocaleid( 18 );
                    break;
                case #"hash_e4ca6b73b5022b26":
                    game_utility::setlocaleid( 10 );
                    break;
                case #"hash_3a8b050ff58578ad":
                    game_utility::setlocaleid( 19 );
                    break;
                default:
                    game_utility::setlocaleid( 0 );
                    break;
            }
        }
    }
    
    if ( getdvarint( @"hash_a317fbbcde464162", 1 ) == 1 )
    {
        if ( game_utility::function_d3f8957534dc62af() )
        {
            game[ "dialog" ][ "gametype" ] = "iw9_kout_mode_uktl_kot1";
        }
        else
        {
            game[ "dialog" ][ "gametype" ] = "iw9_kout_mode_uktl_name";
        }
        
        if ( !isdefined( game[ "roundsPlayed" ] ) )
        {
            boostvo = "iw9_kout_mode_uktl_bost";
        }
        else
        {
            boostvo = "iw9_kout_mode_uktl_bosh";
        }
        
        game[ "dialog" ][ "offense_obj" ] = boostvo;
        game[ "dialog" ][ "defense_obj" ] = boostvo;
    }
    
    game[ "dialog" ][ "ko_flag_returned" ] = "iw9_kout_mode_uktl_kffr";
    game[ "dialog" ][ "ko_flag_get_nag" ] = "iw9_kout_mode_uktl_kfgn";
    game[ "dialog" ][ "ko_we_got_flag" ] = "iw9_kout_mode_uktl_kfft";
    game[ "dialog" ][ "ko_we_dropped_flag" ] = "iw9_kout_mode_uktl_kffd";
    game[ "dialog" ][ "ko_you_got_flag" ] = "iw9_kout_mode_uktl_kffy";
    game[ "dialog" ][ "ko_enemy_got_flag" ] = "iw9_kout_mode_uktl_kfet";
    game[ "dialog" ][ "ko_enemy_dropped_flag" ] = "iw9_kout_mode_uktl_kfed";
    setomnvar( "ui_single_flag_loc", -3 );
    function_ff4e747081084eca();
}

// Namespace ko
// Params 0
// Checksum 0xd557695c, Offset: 0x145d
// Size: 0xdc
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_265155622cfa46da", getmatchrulesdata( "koData", "flagHoldTimer" ) );
    setdynamicdvar( @"hash_678896df033b3202", getmatchrulesdata( "koData", "flagHoldReward" ) );
    setdynamicdvar( @"hash_a3ff29a46a657a08", getmatchrulesdata( "koData", "flagForceTimer" ) );
    setdynamicdvar( @"hash_c37decc9e0687c6f", getmatchrulesdata( "koData", "flagActivationDelay" ) );
    setdynamicdvar( @"scr_ko_showenemycarrier", getmatchrulesdata( "carryData", "showEnemyCarrier" ) );
    setdynamicdvar( @"scr_ko_idleresettime", getmatchrulesdata( "carryData", "idleResetTime" ) );
    setdynamicdvar( @"hash_25905f240af754f6", getmatchrulesdata( "carryData", "manualDropEnabled" ) );
    setdynamicdvar( @"scr_ko_promode", 0 );
}

// Namespace ko
// Params 1, eflags: 0x4
// Checksum 0x3ce50def, Offset: 0x1541
// Size: 0xc4
function private function_5cf40bcccfb2134a( position )
{
    switch ( level.mapname )
    {
        case #"hash_d5e3eef5b3e1d004":
            if ( distance( position, ( -391, 6685, 310 ) ) < 10 )
            {
                position += ( 0, 36, 0 );
            }
            else if ( distance( position, ( -387, 4569, 373 ) ) < 10 )
            {
                position += ( -7, -77, 0 );
            }
            else if ( distance( position, ( -356, 5432, 375 ) ) < 10 )
            {
                position += ( 2, 65, 0 );
            }
            
            break;
        default:
            break;
    }
    
    return position;
}

// Namespace ko
// Params 0
// Checksum 0x707c31dd, Offset: 0x160e
// Size: 0x1af
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
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
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    setomnvar( "ui_obj_timer_stopped", 1 );
    setomnvar( "ui_obj_timer", 0 );
    setomnvar( "ui_obj_progress", 0 );
    
    if ( level.var_bbafbc222fd80343 )
    {
        thread adjustroundendtimer();
        thread arm_vehicles::init_groundwarvehicles();
        thread initvehicles();
        arm::emergency_cleanupents();
    }
    
    function_5530ce5674bba18f();
    bradley_spawner::inittankspawns();
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace ko
// Params 2
// Checksum 0xd5199dfd, Offset: 0x17c5
// Size: 0x5c
function function_7a85e4b06487710( objective, waittime )
{
    level endon( #"game_ended" );
    objective endon( #"death" );
    objective objidpoolmanager::objective_set_pulsate( objective.objidnum, 1 );
    wait waittime;
    objective objidpoolmanager::objective_set_pulsate( objective.objidnum, 0 );
}

// Namespace ko
// Params 0
// Checksum 0x6b24ea12, Offset: 0x1829
// Size: 0x13
function adjustroundendtimer()
{
    wait 1;
    level.roundenddelay = 8;
}

// Namespace ko
// Params 0
// Checksum 0x1bc0e2f7, Offset: 0x1844
// Size: 0x26
function waittooverridegraceperiod()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.var_bbafbc222fd80343 )
    {
        level.overrideingraceperiod = 1;
    }
}

// Namespace ko
// Params 0
// Checksum 0x57ebbdfd, Offset: 0x1872
// Size: 0xb5
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.flagholdtimer = dvars::dvarfloatvalue( "flagHoldTimer", 0, 0, 120 );
    level.flagholdreward = dvars::dvarfloatvalue( "flagHoldReward", 0, 0, 1 );
    level.flagforcetimer = dvars::dvarfloatvalue( "flagForceTimer", 0, 0, 120 );
    level.flagactivationdelay = dvars::dvarfloatvalue( "flagActivationDelay", 10, 0, 30 );
    level.showenemycarrier = dvars::dvarintvalue( "showEnemyCarrier", 5, 0, 6 );
    level.idleresettime = dvars::dvarfloatvalue( "idleResetTime", 15, 0, 60 );
    level.drawsuntilbothscore = dvars::dvarintvalue( "drawsUntilBothScore", 3, 0, 5 );
}

// Namespace ko
// Params 0
// Checksum 0x732eb740, Offset: 0x192f
// Size: 0x55
function function_ff4e747081084eca()
{
    delaytime = getdvarint( @"hash_6e2a3ed599309faa", 15 );
    
    if ( delaytime > 0 )
    {
        level.var_ff4e747081084eca = 1;
        level waittill( #"prematch_done" );
        level endon( #"game_ended" );
        wait delaytime;
        level.var_ff4e747081084eca = 0;
    }
}

// Namespace ko
// Params 0
// Checksum 0x87491401, Offset: 0x198c
// Size: 0x316
function initspawns()
{
    if ( game_utility::islargemap() )
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
        spawnlogic::addstartspawnpoints( "mp_gw_spawn_allies_start" );
        spawnlogic::addstartspawnpoints( "mp_gw_spawn_axis_start" );
        spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_gw_spawn_allies_start" );
        spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_gw_spawn_axis_start" );
        attackers = spawnlogic::getspawnpointarray( "mp_gw_spawn_allies_start" );
        defenders = spawnlogic::getspawnpointarray( "mp_gw_spawn_axis_start" );
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
    }
    else
    {
        level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
        level.spawnmaxs = ( -2.14748e+09, -2.14748e+09, -2.14748e+09 );
        spawnlogic::setactivespawnlogic( #"default" );
        spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
        spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
        spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
        spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
        attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
        defenders = spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
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
    }
    
    spawnlogic::finalizemap();
}

// Namespace ko
// Params 0
// Checksum 0x6b860c7e, Offset: 0x1caa
// Size: 0x254
function getspawnpoint()
{
    if ( level.var_bbafbc222fd80343 )
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
    
    spawnlogic::setactivespawnlogic( #"start" );
    spawnteam = self.pers[ "team" ];
    
    if ( game_utility_mp::getgametypenumlives() != 1 )
    {
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
    }
    else if ( spawnteam == game[ "attackers" ] )
    {
        spawnlogic::activatespawnset( #"start_attackers", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
    }
    else
    {
        spawnlogic::activatespawnset( #"start_defenders", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
    }
    
    return spawnpoint;
}

// Namespace ko
// Params 0
// Checksum 0xa536427c, Offset: 0x1f06
// Size: 0x125
function function_5530ce5674bba18f()
{
    level._effect[ "vfx_br_cashBag" ] = loadfxasset( "vfx_iw8_br_gameplay_money_vip_burst" );
    level.var_58ca4c57804f591b = "neutral";
    level.flagmodel[ "allies" ] = "parts_backpack_duffle_knockout_ground";
    level.flagbase[ "allies" ] = "ctf_game_flag_base";
    level.carryflag[ "allies" ] = "parts_backpack_duffle_knockout";
    level.flagmodel[ "axis" ] = "parts_backpack_duffle_knockout_ground";
    level.flagbase[ "axis" ] = "ctf_game_flag_base";
    level.carryflag[ "axis" ] = "parts_backpack_duffle_knockout";
    setupwaypointicons();
    level.iconescort = "waypoint_escort_flag";
    level.iconkill = "waypoint_ctf_kill";
    level.iconcaptureflag = "waypoint_take_flag";
    level.icondefendflag = "waypoint_defend_flag";
    level.iconreturnflag = "waypoint_recover_flag";
    level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
    level.mlgiconfullflag = "waypoint_mlg_full_flag";
    level.icontarget = "waypoint_target";
    createflagstart();
}

// Namespace ko
// Params 0
// Checksum 0xcae6e529, Offset: 0x2033
// Size: 0xf8
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_cash_bag", 0, 12 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_escort_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cash_bag", 0, 12 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_cash_bag", 0, 12 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cash_bag", 0, 12 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined );
}

// Namespace ko
// Params 0
// Checksum 0xf7748353, Offset: 0x2133
// Size: 0x21a
function createflagstart()
{
    if ( level.koflag_starts.size > 1 )
    {
        if ( !isdefined( game[ "koFlagOrigins" ] ) )
        {
            game[ "koFlagOrigins" ] = level.koflag_starts;
        }
        
        koflagspawnorigin = game[ "koFlagOrigins" ][ 0 ];
        
        if ( isdefined( game[ "koFlagSpawnOrigin" ] ) )
        {
            if ( game[ "koFlagOrigins" ].size > 1 )
            {
                game[ "koFlagOrigins" ] = arrayremove( game[ "koFlagOrigins" ], game[ "koFlagSpawnOrigin" ] );
                koflagspawnorigin = utility::array_random( game[ "koFlagOrigins" ] );
                game[ "koFlagSpawnOrigin" ] = koflagspawnorigin;
            }
            else
            {
                game[ "koFlagSpawnOrigin" ] = game[ "koFlagOrigins" ][ 0 ];
            }
        }
        else if ( isdefined( game[ "koFlagLastOrigin" ] ) )
        {
            game[ "koFlagOrigins" ] = arrayremove( game[ "koFlagOrigins" ], game[ "koFlagLastOrigin" ] );
            game[ "koFlagSpawnOrigin" ] = utility::array_random( game[ "koFlagOrigins" ] );
            game[ "koFlagOrigins" ][ game[ "koFlagOrigins" ].size ] = game[ "koFlagLastOrigin" ];
            game[ "koFlagLastOrigin" ] = undefined;
        }
        else
        {
            game[ "koFlagSpawnOrigin" ] = utility::array_random( game[ "koFlagOrigins" ] );
            game[ "koFlagOrigins" ] = arrayremove( game[ "koFlagOrigins" ], game[ "koFlagSpawnOrigin" ] );
        }
    }
    else
    {
        game[ "koFlagOrigins" ] = level.koflag_starts;
        game[ "koFlagSpawnOrigin" ] = game[ "koFlagOrigins" ][ 0 ];
    }
    
    level.var_fe71186909710250 = game[ "koFlagSpawnOrigin" ];
    tracestart = level.var_fe71186909710250 + ( 0, 0, 64 );
    traceend = level.var_fe71186909710250 + ( 0, 0, -64 );
    trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
    level.var_fe71186909710250 = trace[ "position" ];
    level.knockoutflag = function_4236471f3c2c517c( "allies" );
    level thread flaglockedtimer();
    
    if ( game[ "koFlagOrigins" ].size == 1 )
    {
        game[ "koFlagLastOrigin" ] = game[ "koFlagSpawnOrigin" ];
        game[ "koFlagOrigins" ] = undefined;
        game[ "koFlagSpawnOrigin" ] = undefined;
    }
}

// Namespace ko
// Params 0
// Checksum 0xe30523e9, Offset: 0x2355
// Size: 0x279
function flaglockedtimer()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level.var_3b5dbf721c6a48f.objectiveicon gameobjects::setvisibleteam( "none" );
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
        level.var_3b5dbf721c6a48f.objectiveicon gameobjects::setvisibleteam( "any" );
    }
    
    if ( level.flagactivationdelay )
    {
        flags::gameflagwait( "prematch_done" );
        var_9173c858f1ec5955 = int( gettime() + level.flagactivationdelay * 1000 );
        setomnvar( "ui_obj_timer", var_9173c858f1ec5955 );
        setomnvar( "ui_obj_progress", 1 );
        setomnvar( "ui_objective_timer_stopped", 0 );
        setomnvar( "ui_single_flag_loc", -2 );
        level.var_3b5dbf721c6a48f.objectiveicon thread gameobjects::function_d7321ef757ecefd7( level.flagactivationdelay );
        level.var_3b5dbf721c6a48f thread function_49d5e0c2c4c0890( level.flagactivationdelay );
        wait level.flagactivationdelay;
        setomnvar( "ui_obj_timer_stopped", 1 );
        setomnvar( "ui_obj_timer", 0 );
        setomnvar( "ui_obj_progress", 0 );
        setomnvar( "ui_objective_timer_stopped", 1 );
        setomnvar( "ui_single_flag_loc", -1 );
        level.var_3b5dbf721c6a48f.objectiveicon gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
        level.var_3b5dbf721c6a48f.objectiveicon objidpoolmanager::objective_show_progress( level.var_3b5dbf721c6a48f.objectiveicon.objidnum, 0 );
        thread function_7a85e4b06487710( level.var_3b5dbf721c6a48f.objectiveicon, getdvarfloat( @"hash_e23e7531523cd429", 3 ) );
        level.knockoutflag.trigger utility::trigger_on();
        
        foreach ( team in level.teamnamelist )
        {
            dialog::leaderdialog( "obj_generic_capture", team );
        }
    }
}

// Namespace ko
// Params 1
// Checksum 0xaf429e65, Offset: 0x25d6
// Size: 0x4b8
function function_4236471f3c2c517c( team )
{
    level.pickuptime = 0;
    level.returntime = 0;
    radius = 32;
    trigger = spawn( "trigger_radius", level.var_fe71186909710250, 0, radius, 128 );
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", level.var_fe71186909710250 + ( 0, 0, 1 ) );
    visuals[ 0 ] setmodel( level.flagmodel[ team ] );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 0 ] setteaminhuddatafromteamname( team );
    carryteam = "neutral";
    teamflag = gameobjects::createcarryobject( carryteam, trigger, visuals, ( 0, 0, 16 ) );
    teamflag gameobjects::allowcarry( "any" );
    teamflag gameobjects::setteamusetime( "friendly", level.pickuptime );
    teamflag gameobjects::setteamusetime( "enemy", level.returntime );
    teamflag gameobjects::setvisibleteam( "none" );
    teamflag gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    teamflag objidpoolmanager::objective_set_play_intro( teamflag.objidnum, 0 );
    teamflag objidpoolmanager::objective_set_play_outro( teamflag.objidnum, 0 );
    teamflag gameobjects::registercarryobjectpickupcheck( &flagpickupchecks );
    teamflag.allowweapons = 1;
    teamflag.requireslos = 1;
    teamflag.firstpickup = 1;
    teamflag.onpickup = &onpickup;
    teamflag.onpickupfailed = &onpickupfailed;
    teamflag.ondrop = &ondrop;
    teamflag.onreset = &onreset;
    teamflag.visualgroundoffset = ( 0, 0, 1 );
    
    if ( getdvarint( @"hash_25905f240af754f6" ) != 0 )
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
    
    level.var_3b5dbf721c6a48f = createteamdefenderflagbase( team, teamflag );
    return teamflag;
}

// Namespace ko
// Params 2
// Checksum 0x7f223e0f, Offset: 0x2a97
// Size: 0x130
function createteamdefenderflagbase( team, teamflag )
{
    flagbaseorigin = teamflag.visuals[ 0 ].origin;
    teamflagbase = spawn( "script_model", flagbaseorigin );
    teamflagbase.ownerteam = "neutral";
    teamflagbase setasgametypeobjective();
    teamflagbase setteaminhuddatafromteamname( team );
    teamflagbase.objectiveicon = gameobjects::createobjidobject( flagbaseorigin, "neutral", ( 0, 0, 16 ), undefined, "any", 0 );
    teamflagbase.objectiveicon gameobjects::setvisibleteam( "any" );
    
    if ( level.flagactivationdelay )
    {
        teamflag.trigger utility::trigger_off();
        teamflagbase.objectiveicon gameobjects::setobjectivestatusallicons( level.icontarget, level.icontarget, level.mlgiconfullflag );
    }
    else
    {
        teamflagbase.objectiveicon gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
    }
    
    return teamflagbase;
}

// Namespace ko
// Params 1
// Checksum 0x3f97641c, Offset: 0x2bd0
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

// Namespace ko
// Params 1
// Checksum 0x5bb7bde6, Offset: 0x2c17
// Size: 0x15, Type: bool
function flagpickupchecks( player )
{
    return !player vehicle::is_in_vehicle();
}

// Namespace ko
// Params 1
// Checksum 0x4805a64f, Offset: 0x2c35
// Size: 0xc
function onpickupfailed( player )
{
    
}

// Namespace ko
// Params 3
// Checksum 0x6ff7a273, Offset: 0x2c4a
// Size: 0x561
function onpickup( player, playervo, defused )
{
    self notify( #"picked_up" );
    player notify( #"obj_picked_up" );
    
    if ( getdvarint( @"hash_61e9133b2e499a6c" ) )
    {
        ko_carry_music = audio_utility::function_d4d265f3dcd0a13c( "ko_carry_music_classic" );
        player setplayermusicstate( ko_carry_music );
    }
    else
    {
        ko_carry_music = audio_utility::function_d4d265f3dcd0a13c( "ko_carry_music" );
        player setplayermusicstate( ko_carry_music );
    }
    
    self.offset3d = ( 0, 0, 85 );
    level.var_3b5dbf721c6a48f.objectiveicon gameobjects::setvisibleteam( "none" );
    level.knockoutflag.currentcarrier = player;
    player thread awardobjtimeforcarrier();
    ownerteam = gameobjects::getownerteam();
    gameobjects::setownerteam( player.team );
    team = player.pers[ "team" ];
    level.var_58ca4c57804f591b = team;
    
    if ( team == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    player attachflag();
    
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
        
        if ( isdefined( player.pers[ "pickups" ] ) )
        {
            player.pers[ "pickups" ] = player.pers[ "pickups" ] + 1;
        }
    }
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", player getentitynumber() );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", player getentitynumber() );
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
            objective_icon( self.pingobjidnum, "icon_waypoint_kill" );
            objective_setbackground( self.pingobjidnum, 2 );
            objidpoolmanager::function_4b37488488e7d007( self.pingobjidnum, 1 );
            objidpoolmanager::update_objective_setfriendlylabel( self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS" );
            objidpoolmanager::update_objective_setenemylabel( self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS" );
            objective_setownerteam( self.pingobjidnum, team );
            objidpoolmanager::objective_set_pulsate( self.pingobjidnum, 1 );
        }
    }
    
    gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    objidpoolmanager::objective_set_pulsate( self.objidnum, 1 );
    
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
        
        if ( isdefined( player.pers[ "captures" ] ) )
        {
            player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
        }
    }
    
    player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
    player stats::setextrascore0( player.pers[ "captures" ], "captures" );
    thread function_56124c4d4b643386( player );
    thread hud_util::function_ddf9cb7f151d8d96( player, "callout_ko_pickup_owner", "callout_ko_pickup_friendly", "callout_ko_pickup_enemy" );
    telemetry_data = spawnstruct();
    telemetry_data.player = player;
    telemetry_data.eventname = "pickup";
    telemetry_data.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    self.previouscarrier = player;
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
    
    thread function_ab8ce9ad38ec2979( team );
    
    if ( level.flagforcetimer > 0 )
    {
        level thread function_6b3b7619b30a01db( team );
    }
}

// Namespace ko
// Params 1, eflags: 0x4
// Checksum 0x7adfb0b6, Offset: 0x31b3
// Size: 0x118
function private function_56124c4d4b643386( player )
{
    self notify( #"hash_f609654f1045b491" );
    self endon( #"hash_f609654f1045b491" );
    self endon( #"hash_9628034c279c6bbc" );
    level endon( #"game_ended" );
    
    if ( isdefined( player ) )
    {
        team = player.pers[ "team" ];
        otherteam = team_utility::getotherteam( team );
        print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player );
        waittime = getdvarfloat( @"hash_c07d9c63c722352b", 0.5 );
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
        
        if ( !level.gameended )
        {
            excludelist = [];
            
            if ( isdefined( player ) )
            {
                excludelist = [ player ];
                player dialog::leaderdialogonplayer( "ko_you_got_flag", "status" );
            }
            
            if ( isdefined( team ) )
            {
                dialog::leaderdialog( "ko_we_got_flag", team, "status", excludelist );
            }
            
            if ( isdefined( otherteam ) )
            {
                dialog::leaderdialog( "ko_enemy_got_flag", otherteam );
            }
        }
    }
}

// Namespace ko
// Params 0
// Checksum 0xcf2af983, Offset: 0x32d3
// Size: 0x1f
function returnflag()
{
    self.offset3d = ( 0, 0, 16 );
    gameobjects::returnhome();
}

// Namespace ko
// Params 1
// Checksum 0x9b72cdbc, Offset: 0x32fa
// Size: 0x262
function ondrop( player )
{
    if ( isdefined( player ) && isdefined( player.leaving_team ) )
    {
        self.droppedteam = player.leaving_team;
        player.leaving_team = undefined;
    }
    else if ( !isdefined( player ) )
    {
        self.droppedteam = self.ownerteam;
    }
    else
    {
        self.droppedteam = player.team;
    }
    
    self.offset3d = ( 0, 0, 16 );
    level.knockoutflag.currentcarrier = undefined;
    level.var_58ca4c57804f591b = "neutral";
    level thread hud_message::updatematchstatushintforallplayers( undefined, #"ko_obj_capture", #"ko_obj_capture" );
    gameobjects::setownerteam( "neutral" );
    team = self.droppedteam;
    otherteam = team_utility::getotherteam( self.droppedteam );
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "any" );
    objective_state( self.pingobjidnum, "done" );
    
    if ( level.returntime >= 0 )
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
    }
    else
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
        objidpoolmanager::function_4b37488488e7d007( self.objidnum, 1 );
    }
    
    thread function_7a85e4b06487710( self, 2 );
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    
    if ( isdefined( player ) )
    {
        player setplayermusicstate( "" );
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
        
        if ( !player::isreallyalive( player ) )
        {
            player.carryobject.previouscarrier = undefined;
        }
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
    }
    
    thread function_b7b18a53fc798f65( player );
    setomnvar( "ui_obj_timer_stopped", 1 );
    setomnvar( "ui_obj_timer", 0 );
    setomnvar( "ui_obj_progress", 0 );
}

// Namespace ko
// Params 1, eflags: 0x4
// Checksum 0x275c00fc, Offset: 0x3564
// Size: 0xfb
function private function_b7b18a53fc798f65( player )
{
    self notify( #"hash_9628034c279c6bbc" );
    self endon( #"hash_9628034c279c6bbc" );
    self endon( #"hash_f609654f1045b491" );
    level endon( #"game_ended" );
    team = self.droppedteam;
    otherteam = team_utility::getotherteam( team );
    
    if ( isdefined( player ) )
    {
        print::printandsoundoneveryone( otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player );
    }
    else
    {
        sound::playsoundonplayers( "iw9_mp_ui_objective_lost", otherteam );
    }
    
    waittime = getdvarfloat( @"hash_c07d9c63c722352b", 0.5 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( !level.gameended )
    {
        if ( isdefined( team ) )
        {
            dialog::leaderdialog( "ko_we_dropped_flag", team, "status" );
        }
        
        if ( isdefined( otherteam ) )
        {
            dialog::leaderdialog( "ko_enemy_dropped_flag", otherteam, "status" );
        }
    }
}

// Namespace ko
// Params 0
// Checksum 0xa863c2d4, Offset: 0x3667
// Size: 0xd5
function returnaftertime()
{
    self endon( #"picked_up" );
    currentwaittime = 0;
    
    while ( currentwaittime < level.idleresettime )
    {
        waitframe();
        
        if ( self.claimteam == "none" )
        {
            currentwaittime += level.framedurationseconds;
        }
    }
    
    foreach ( team in level.teamnamelist )
    {
        sound::playsoundonplayers( "iw9_mp_ui_objective_lost", team );
    }
    
    gameobjects::returnhome();
}

// Namespace ko
// Params 0
// Checksum 0x6db61963, Offset: 0x3744
// Size: 0x1fc
function onreset()
{
    level.knockoutflag.currentcarrier = undefined;
    
    if ( isdefined( level.knockoutflag.portable_radar ) )
    {
        level.knockoutflag.portable_radar clearportableradar();
        level.knockoutflag.portable_radar delete();
    }
    
    gameobjects::setownerteam( "neutral" );
    team = self.droppedteam;
    otherteam = team_utility::getotherteam( self.droppedteam );
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "any" );
    objective_state( self.pingobjidnum, "done" );
    
    if ( level.returntime >= 0 )
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
    }
    else
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
        objidpoolmanager::function_4b37488488e7d007( self.objidnum, 1 );
    }
    
    thread function_7a85e4b06487710( self, 2 );
    
    if ( !level.gameended )
    {
        foreach ( team in level.teamnamelist )
        {
            dialog::leaderdialog( "ko_flag_returned", team, "status" );
        }
    }
    
    self.droppedteam = undefined;
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    
    self.previouscarrier = undefined;
}

// Namespace ko
// Params 0
// Checksum 0x4c6a8f02, Offset: 0x3948
// Size: 0xa5
function attachflag()
{
    level thread hud_message::updatematchstatushintforallplayers( self.team, #"hash_6632b1bae8bea20f", #"hash_c1cb91afba565792" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    
    if ( function_75ef3c8675e884d3( self ) )
    {
        self attach( level.carryflag[ otherteam ], "tag_stowed_back3", 1 );
    }
    
    self.carryflag = level.carryflag[ otherteam ];
    
    if ( self tagexists( "j_bag_left" ) )
    {
        playfxontag( level._effect[ "vfx_br_cashBag" ], self, "j_bag_left" );
    }
}

// Namespace ko
// Params 0
// Checksum 0x3bf6e833, Offset: 0x39f5
// Size: 0x51
function detachflag()
{
    if ( self tagexists( "j_bag_left" ) )
    {
        stopfxontag( level._effect[ "vfx_br_cashBag" ], self, "j_bag_left" );
    }
    
    if ( function_75ef3c8675e884d3( self ) )
    {
        self detach( self.carryflag, "tag_stowed_back3" );
    }
    
    self.carryflag = undefined;
}

// Namespace ko
// Params 1, eflags: 0x4
// Checksum 0x278ef56c, Offset: 0x3a4e
// Size: 0x2a
function private function_75ef3c8675e884d3( player )
{
    canattach = 1;
    
    if ( player killstreak::isjuggernaut() )
    {
        canattach = 0;
    }
    
    return canattach;
}

// Namespace ko
// Params 1
// Checksum 0x44456cbb, Offset: 0x3a81
// Size: 0xa4
function awardobjtimeforcarrier( team )
{
    level endon( #"game_ended" );
    level.knockoutflag endon( #"dropped" );
    level.knockoutflag endon( #"reset" );
    level notify( #"hash_3dd8bdadd0b92d2f" );
    level endon( #"hash_3dd8bdadd0b92d2f" );
    
    while ( !level.gameended )
    {
        wait 1;
        hostmigration::waittillhostmigrationdone();
        
        if ( !level.gameended )
        {
            level.knockoutflag.carrier gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
        }
    }
}

// Namespace ko
// Params 1
// Checksum 0x639938c2, Offset: 0x3b2d
// Size: 0x147
function function_ab8ce9ad38ec2979( team )
{
    level.var_bfd2ffffd667a084 = ( game_utility_mp::gettimelimit() * 1000 - game_utility::gettimepassed() ) / 1000;
    
    if ( level.flagholdtimer > 0 && level.flagholdtimer <= level.var_bfd2ffffd667a084 )
    {
        level.var_bfd2ffffd667a084 = level.flagholdtimer;
    }
    
    if ( game_utility_mp::gettimelimit() == 0 && level.var_bfd2ffffd667a084 <= 0 )
    {
        /#
            flagholdtimer = int( gettime() + 1000000 );
            setomnvar( "<dev string:x6f>", flagholdtimer );
            setomnvar( "<dev string:x7c>", 1 );
            setomnvar( "<dev string:x8c>", 0 );
        #/
        
        return;
    }
    
    flagholdtimer = int( gettime() + level.var_bfd2ffffd667a084 * 1000 );
    setomnvar( "ui_obj_timer", flagholdtimer );
    setomnvar( "ui_obj_progress", 1 );
    setomnvar( "ui_objective_timer_stopped", 0 );
    
    if ( function_e647dd328c59ae9a() )
    {
        level thread hud_message::notifyteam( "ko_force_hold_fr", "ko_force_hold_en", team );
    }
    
    thread function_49d5e0c2c4c0890( level.var_bfd2ffffd667a084 );
    
    if ( function_e647dd328c59ae9a() )
    {
        thread function_8e15013a54c45cbb();
        return;
    }
    
    if ( function_fdab34514c0cfbed() )
    {
        thread function_8a6e172c4b7e2963();
    }
}

// Namespace ko
// Params 1
// Checksum 0xbacb17d, Offset: 0x3c7c
// Size: 0x82
function function_49d5e0c2c4c0890( flagholdtimer )
{
    level.knockoutflag endon( #"dropped" );
    currentprogress = flagholdtimer;
    
    while ( !level.gameended && currentprogress > 0 )
    {
        setomnvar( "ui_obj_progress", currentprogress / flagholdtimer );
        currentprogress -= level.framedurationseconds;
        wait level.framedurationseconds;
    }
    
    setomnvar( "ui_obj_timer", 0 );
    setomnvar( "ui_obj_progress", 0 );
}

// Namespace ko
// Params 0
// Checksum 0x948f44d0, Offset: 0x3d06
// Size: 0x5b
function function_8e15013a54c45cbb()
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    hostmigration::waitlongdurationwithgameendtimeupdate( level.var_bfd2ffffd667a084 );
    level ko_endgame( level.knockoutflag gameobjects::getownerteam(), game[ "end_reason" ][ "ko_flag_hold_win" ], game[ "end_reason" ][ "ko_flag_hold_loss" ] );
}

// Namespace ko
// Params 0
// Checksum 0x838b49aa, Offset: 0x3d69
// Size: 0x53
function function_8a6e172c4b7e2963()
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    hostmigration::waitlongdurationwithgameendtimeupdate( level.var_bfd2ffffd667a084 );
    teamrespawn( level.knockoutflag gameobjects::getownerteam(), level.knockoutflag.currentcarrier );
}

// Namespace ko
// Params 0
// Checksum 0xb89c2c66, Offset: 0x3dc4
// Size: 0x1c, Type: bool
function function_e647dd328c59ae9a()
{
    return level.flagholdtimer != 0 && level.flagholdreward == 0;
}

// Namespace ko
// Params 0
// Checksum 0xb65a7664, Offset: 0x3de9
// Size: 0x1d, Type: bool
function function_fdab34514c0cfbed()
{
    return level.flagholdtimer != 0 && level.flagholdreward == 1;
}

// Namespace ko
// Params 2
// Checksum 0xf00f4e03, Offset: 0x3e0f
// Size: 0x213
function teamrespawn( team, credit_player )
{
    teamsize = teams::getteamdata( credit_player.team, "teamCount" );
    
    if ( !isdefined( credit_player.rescuedplayers ) )
    {
        credit_player.rescuedplayers = [];
    }
    
    foreach ( player in level.participants )
    {
        if ( isdefined( player ) && player.team == team && !player::isreallyalive( player ) && !arraycontains( teams::getfriendlyplayers( player.team, 1 ), player ) && !player.waitingtoselectclass )
        {
            if ( isdefined( player.siegelatecomer ) && player.siegelatecomer )
            {
                player.siegelatecomer = 0;
            }
            
            if ( !player.pers[ "teamKillPunish" ] )
            {
                if ( player.wasflagspawned )
                {
                    continue;
                }
                
                player.wasflagspawned = 1;
                
                if ( isdefined( level.revivetriggers[ player.guid ] ) )
                {
                    level.revivetriggers[ player.guid ] teamrevive::revivetriggerholdonuse( credit_player );
                }
                else
                {
                    player thread playerlogic::waittillcanspawnclient( 0 );
                    player thread rank::scoreeventpopup( #"revived" );
                    level notify( #"player_respawned", player );
                    player dialog::leaderdialogonplayer( "revived" );
                }
            }
            
            credit_player.rescuedplayers[ player.guid ] = 1;
        }
    }
    
    self.playersrevived = credit_player.rescuedplayers.size;
}

// Namespace ko
// Params 1
// Checksum 0xf6a82af1, Offset: 0x402a
// Size: 0x56
function function_6b3b7619b30a01db( team )
{
    level notify( #"flagforcetimer" );
    level endon( #"flagforcetimer" );
    level endon( #"game_ended" );
    level thread hud_message::notifyteam( "ko_force_timer", "ko_force_timer", team );
    level.timelimitoverride = 1;
    function_94a3a190508285d5();
}

// Namespace ko
// Params 0
// Checksum 0xd48876cc, Offset: 0x4088
// Size: 0x71
function function_94a3a190508285d5()
{
    level endon( #"flagforcetimer" );
    level endon( #"game_ended" );
    var_69f52ed27f6fb67d = int( gettime() + level.flagforcetimer * 1000 );
    setgameendtime( var_69f52ed27f6fb67d );
    hostmigration::waitlongdurationwithgameendtimeupdate( level.flagforcetimer );
    
    if ( isdefined( level.onobjectivecomplete ) )
    {
        [[ level.onobjectivecomplete ]]( "koFlag" );
    }
}

// Namespace ko
// Params 1
// Checksum 0x3fa4fd8d, Offset: 0x4101
// Size: 0x92
function function_a44d2590e4f6115a( objectivetype )
{
    if ( level.nukeinfo.incoming )
    {
        return;
    }
    
    setgameendtime( 0 );
    winner = level.var_58ca4c57804f591b;
    
    if ( winner != "neutral" )
    {
        ko_endgame( winner, game[ "end_reason" ][ "ko_flag_win" ], game[ "end_reason" ][ "ko_flag_loss" ] );
        return;
    }
    
    if ( !breaktie() )
    {
        ko_endgame( "tie", game[ "end_reason" ][ "tie" ] );
    }
}

// Namespace ko
// Params 1
// Checksum 0x903bfdd0, Offset: 0x419b
// Size: 0x7b
function onspawnplayer( revivespawn )
{
    thread updatematchstatushintonspawn();
    self setclientomnvar( "ui_flag_player_hud_icon", 0 );
    
    if ( isdefined( self.pers[ "captures" ] ) )
    {
        stats::setextrascore0( self.pers[ "captures" ], "captures" );
    }
    
    if ( isdefined( self.pers[ "rescues" ] ) )
    {
        stats::setextrascore1( self.pers[ "rescues" ], "rescues" );
    }
}

// Namespace ko
// Params 0
// Checksum 0xbe60ec38, Offset: 0x421e
// Size: 0x79
function updatematchstatushintonspawn()
{
    if ( isdefined( level.knockoutflag.currentcarrier ) )
    {
        if ( level.knockoutflag.currentcarrier.team == self.team )
        {
            hud_message::function_ef4318a0090caa0f( #"hash_6632b1bae8bea20f" );
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"hash_c1cb91afba565792" );
        }
        
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"ko_obj_capture" );
}

// Namespace ko
// Params 1
// Checksum 0x83b3cbc5, Offset: 0x429f
// Size: 0xc
function onplayerconnect( player )
{
    
}

// Namespace ko
// Params 1
// Checksum 0x2b2c65bc, Offset: 0x42b3
// Size: 0x7b
function ondeadevent( team )
{
    if ( team == "all" )
    {
        ko_endgame( "tie", game[ "end_reason" ][ "tie" ] );
        return;
    }
    
    if ( team == game[ "attackers" ] )
    {
        level ko_endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    level ko_endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
}

// Namespace ko
// Params 1
// Checksum 0x72a2963b, Offset: 0x4336
// Size: 0x3d
function ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    
    if ( isdefined( lastplayer ) )
    {
        lastplayer.laststanding = 1;
        lastplayer thread givelastonteamwarning();
    }
}

// Namespace ko
// Params 1
// Checksum 0xcc659e89, Offset: 0x437b
// Size: 0x758
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
    
    if ( !isplayer( attacker ) || attacker == victim )
    {
        if ( isdefined( victim.carryflag ) )
        {
            victim detachflag();
        }
        
        return;
    }
    
    if ( isdefined( level.knockoutflag ) && level.knockoutflag gameobjects::getownerteam() == attacker.pers[ "team" ] )
    {
    }
    
    gaveaward = 0;
    attackerpos = attacker.origin;
    attackerisinflictor = 0;
    
    if ( isdefined( einflictor ) )
    {
        attackerpos = einflictor.origin;
        attackerisinflictor = einflictor == attacker;
    }
    
    if ( isplayer( attacker ) && attacker.pers[ "team" ] != victim.pers[ "team" ] )
    {
        if ( isdefined( attacker.carryflag ) && attackerisinflictor )
        {
            attacker thread rank::scoreeventpopup( #"carrier_kill" );
            attacker thread points::doscoreevent( #"mode_ctf_kill_with_flag" );
            gaveaward = 1;
        }
        
        if ( isdefined( victim.carryflag ) )
        {
            attacker thread points::doscoreevent( #"mode_ctf_kill_carrier" );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ "carrierKills" ] ) )
                {
                    attacker.leaderboarddata[ "carrierKills" ] = attacker.leaderboarddata[ "carrierKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "carrierKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "carrierKills" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
                
                if ( isdefined( attacker.pers[ "carrierKills" ] ) )
                {
                    attacker.pers[ "carrierKills" ] = attacker.pers[ "carrierKills" ] + 1;
                }
            }
            
            attacker thread hud_message::showsplash( "ko_killed_carrier" );
            
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
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
                
                if ( isdefined( attacker.pers[ "defends" ] ) )
                {
                    attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                }
            }
            
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
            attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
            victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "carrying" );
            victim codcaster_utils::function_3038b6eafc46c037( 20, attacker.team, attacker getentitynumber() );
            gaveaward = 1;
        }
        
        if ( !gaveaward )
        {
            awardassault = 0;
            awarddefense = 0;
            flagcheck = distsquaredcheck( attackerpos, victim.origin, level.knockoutflag.curorigin );
            
            if ( flagcheck )
            {
                if ( level.knockoutflag.ownerteam == victim.team )
                {
                    awardassault = 1;
                }
                else
                {
                    awarddefense = 1;
                }
            }
            
            if ( awardassault )
            {
                attacker thread rank::function_d2aa8986c506e985( #"assault" );
                attacker events::function_58da673c1c3fc9f2();
                victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "assaults" ] ) )
                    {
                        attacker.leaderboarddata[ "assaults" ] = attacker.leaderboarddata[ "assaults" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "assaults" ] ) )
                    {
                        [[ level.leaderboardfunc[ "assaults" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
                    
                    if ( isdefined( attacker.pers[ "assaults" ] ) )
                    {
                        attacker.pers[ "assaults" ] = attacker.pers[ "assaults" ] + 1;
                    }
                }
            }
            else if ( awarddefense )
            {
                attacker thread rank::function_d2aa8986c506e985( #"defend" );
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
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
                    
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                    }
                }
                
                attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
                attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "assaulting" );
            }
        }
    }
    
    if ( isdefined( victim.carryflag ) )
    {
        victim detachflag();
    }
}

// Namespace ko
// Params 3
// Checksum 0x3b82f894, Offset: 0x4adb
// Size: 0x61
function distsquaredcheck( attackerpos, victimpos, checkpos )
{
    attackerdistsq = distancesquared( checkpos, attackerpos );
    victimdistsq = distancesquared( checkpos, victimpos );
    
    if ( attackerdistsq < 90000 || victimdistsq < 90000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace ko
// Params 6
// Checksum 0x4f39f5ad, Offset: 0x4b44
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace ko
// Params 0
// Checksum 0xfde7e74b, Offset: 0x4b94
// Size: 0x98
function givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
}

// Namespace ko
// Params 0
// Checksum 0xb1af19da, Offset: 0x4c34
// Size: 0x6b
function ontimelimit()
{
    winner = level.var_58ca4c57804f591b;
    
    if ( winner != "neutral" )
    {
        ko_endgame( winner, game[ "end_reason" ][ "ko_flag_win" ], game[ "end_reason" ][ "ko_flag_loss" ] );
        return;
    }
    
    if ( !breaktie() )
    {
        ko_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
    }
}

// Namespace ko
// Params 5, eflags: 0x4
// Checksum 0x41ca89da, Offset: 0x4ca7
// Size: 0x9b
function private ko_endgame( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    if ( winner == "tie" )
    {
        if ( !isdefined( game[ "roundsTied" ] ) )
        {
            game[ "roundsTied" ] = 0;
        }
        
        game[ "roundsTied" ]++;
        
        if ( game[ "roundsTied" ] > level.drawsuntilbothscore )
        {
            game[ "canScoreOnTie" ] = 1;
        }
        
        if ( game[ "canScoreOnTie" ] )
        {
            endreasontext = game[ "end_reason" ][ "ko_draw_award_point" ];
        }
    }
    
    thread gamelogic_mp::endgame( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
}

// Namespace ko
// Params 0
// Checksum 0x82c798db, Offset: 0x4d4a
// Size: 0x186, Type: bool
function breaktie()
{
    alliesalive = 0;
    axisalive = 0;
    
    foreach ( player in level.teamdata[ "allies" ][ "players" ] )
    {
        if ( player::isreallyalive( player ) )
        {
            alliesalive++;
        }
    }
    
    foreach ( player in level.teamdata[ "axis" ][ "players" ] )
    {
        if ( player::isreallyalive( player ) )
        {
            axisalive++;
        }
    }
    
    if ( alliesalive > axisalive )
    {
        ko_endgame( "allies", game[ "end_reason" ][ "ko_alive_count_win" ], game[ "end_reason" ][ "ko_alive_count_loss" ] );
        return true;
    }
    else if ( alliesalive < axisalive )
    {
        ko_endgame( "axis", game[ "end_reason" ][ "ko_alive_count_win" ], game[ "end_reason" ][ "ko_alive_count_loss" ] );
        return true;
    }
    
    return false;
}

/#

    // Namespace ko
    // Params 0
    // Checksum 0xbea2cd3c, Offset: 0x4ed9
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:xa7>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:xb2>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:xa7>", "<dev string:xc5>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:xb2>", "<dev string:xc5>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace ko
// Params 1
// Checksum 0x1a78e220, Offset: 0x5163
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

// Namespace ko
// Params 2
// Checksum 0xc5718927, Offset: 0x51d7
// Size: 0x82
function registervehicletype( refname, spawnvehiclecallback )
{
    assert( isdefined( refname ) );
    vehicleinfo = spawnstruct();
    vehicleinfo.refname = refname;
    vehicleinfo.spawncallback = spawnvehiclecallback;
    vehicleinfo.vehiclespawns = vehicle_spawn::get_spawn_structs( refname );
    assert( isdefined( vehicleinfo.vehiclespawns ) );
    level.vehicleinfo[ refname ] = vehicleinfo;
}

// Namespace ko
// Params 0
// Checksum 0xf7fbe32c, Offset: 0x5261
// Size: 0x3df
function initvehicles()
{
    level.numhqtanks_axis = 0;
    level.numhqtanks_allies = 0;
    
    if ( !isdefined( level.vehicleinfo ) )
    {
        level.vehicleinfo = [];
    }
    
    registervehicletype( %"hash_49602cb7beee6fba", &vehiclespawn_littlebird );
    registervehicletype( %"hash_21df6558fa3c728b", &vehiclespawn_atv );
    registervehicletype( %"hash_4725c8dee627919d", &vehiclespawn_tacrover );
    level.vehiclespawnlocs = [];
    
    foreach ( vehicleinfo in level.vehicleinfo )
    {
        switch ( vehicleinfo.refname )
        {
            case %"hash_49602cb7beee6fba":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_49602cb7beee6fba", "veh9_mil_air_heli_medium_physics_mp" );
                break;
            case %"hash_21df6558fa3c728b":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_21df6558fa3c728b", "veh9_mil_lnd_atv_physics_mp" );
                break;
            case %"hash_4725c8dee627919d":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_4725c8dee627919d", "tromeo_physics_mp" );
                break;
        }
        
        foreach ( spawnpoint in vehicleinfo.vehiclespawns )
        {
            index = level.vehiclespawnlocs.size;
            level.vehiclespawnlocs[ index ] = spawnpoint;
            level.vehiclespawnlocs[ index ].refname = vehicleinfo.refname;
        }
    }
    
    if ( false )
    {
        foreach ( loc in level.vehiclespawnlocs )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
        }
    }
    
    level.vehiclespawnlocs = arrayrandomize( level.vehiclespawnlocs );
    numtospawn = level.numnonrallyvehicles;
    
    if ( !isdefined( level.numnonrallyvehicles ) )
    {
        numtospawn = 25;
    }
    
    if ( false )
    {
        for ( i = 0; i < numtospawn ; i++ )
        {
            loc = level.vehiclespawnlocs[ i ];
            thread debug::drawline( loc.origin + ( 0, 0, 1500 ), loc.origin + ( 0, 0, 2500 ), 1000, ( 0, 1, 0 ) );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        loc = level.vehiclespawnlocs[ i ];
        
        if ( isdefined( loc ) )
        {
            vehicleinfo = level.vehicleinfo[ loc.refname ];
            [[ vehicleinfo.spawncallback ]]( loc );
        }
    }
}

// Namespace ko
// Params 2
// Checksum 0x2b7d2323, Offset: 0x5648
// Size: 0x1459
function getvehiclespawns( vehicleref, vehicletype )
{
    spawns = [];
    mapname = game_utility::getmapname();
    atvoriginsarray = [];
    atvanglesarray = [];
    var_b60e03df1c17ae46 = [];
    var_9e6d05dd2a832d1f = [];
    
    switch ( mapname )
    {
        case #"hash_32eaa112f8caa7e4":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 21843.8, -4640.11, -476.961 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 20375.9, -3612.78, -454 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 20728.8, -3309.36, -456 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 255, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 330, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 292, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 20937.2, -9029.28, -379.674 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 23097.1, -9966.89, -344 );
                atvanglesarray[ atvanglesarray.size ] = ( 356.825, 240, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 0, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 17471, -23211.4, -204 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 15960.1, -22768.1, -204 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 15821.3, -23568, -208.461 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 90, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 45, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 90, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 22994.3, -15304.5, -216 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 105, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 20120.2, -3287.71, -456 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 21339.9, -4787.55, -450.176 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 345, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 357.831, 255.032, -1.25312 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 17449, -22190.1, -208.116 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 16651.1, -22178.2, -207.908 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 60, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 60, 0 );
            }
            
            break;
        case #"hash_7a28db3c5928c489":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 26335.7, 30412.6, 655.471 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 27099.5, 30567.5, 639.236 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 27315.5, 30525.5, 639.236 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.0728273, 119, 0.843973 );
                atvanglesarray[ atvanglesarray.size ] = ( 2.67817, 77.0718, 1.59551 );
                atvanglesarray[ atvanglesarray.size ] = ( 2.67817, 77.0718, 1.59551 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 29610.4, 38228.5, 698.883 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 29465.5, 38973.6, 701 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 315, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 88.9989, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 39153, 46431.8, 932.749 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 38876.4, 46106.9, 925.771 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37923.7, 47136.4, 949.247 );
                atvanglesarray[ atvanglesarray.size ] = ( 1.88064, 180.047, 0.333796 );
                atvanglesarray[ atvanglesarray.size ] = ( 1.47639, 180.039, 1.17305 );
                atvanglesarray[ atvanglesarray.size ] = ( 359.077, 185.712, 7.76991 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 33628.2, 40971.6, 653.047 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 32104.4, 41719.8, 708.773 );
                atvanglesarray[ atvanglesarray.size ] = ( 349.991, 186.286, -2.23687 );
                atvanglesarray[ atvanglesarray.size ] = ( 3.95499, 211.371, 4.41818 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 26310.8, 30168.4, 659.426 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 26954, 29794.1, 651.013 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 358.195, 118.006, -2.71651 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 89.9998, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 38573.2, 47052.8, 950.28 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 39660.3, 45949.9, 952.362 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 359.669, 194.507, -0.439539 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 11.7511, 162.518, 0.102679 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 33138.2, 41498.6, 707.349 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 357.81, 284.768, 1.14713 );
            }
            
            break;
        case #"hash_50de71be6e7469ff":
        case #"hash_863773b8960b3944":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 49063.3, -22654.9, -385.662 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 47332.9, -23070.6, -374.497 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 48281.3, -22202.5, -371.375 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.0275984, 103.998, 0.280605 );
                atvanglesarray[ atvanglesarray.size ] = ( 357.226, 88.8435, 4.3294 );
                atvanglesarray[ atvanglesarray.size ] = ( 3.93534, 89.3527, 4.34541 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 49720, -18492, -387.562 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 48107.4, -18052.3, -312.859 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 73.9972, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 352.657, 118.56, -10.3306 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 46431.3, -92.3425, -52.4549 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 47471, -192.634, -43.7394 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 48085.6, -358.42, 9.73944 );
                atvanglesarray[ atvanglesarray.size ] = ( 359.802, 240.821, -3.32839 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.975088, 240.828, 0.322594 );
                atvanglesarray[ atvanglesarray.size ] = ( 6.15886, 241.028, 2.20885 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 44528.7, -5376.79, 283.824 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 43628, -5846.41, 346.636 );
                atvanglesarray[ atvanglesarray.size ] = ( 357.74, 256.16, -1.56165 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.506229, 241.181, 0.438595 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 47872.6, -22645.4, -385.49 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 48501.7, -22505, -382.243 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 1.68464, 109.9, -3.26246 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 359.897, 89.9842, 8.71393 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 46034.5, -59.925, -29.8834 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 47108.8, -498.535, -35.0573 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 2.33612, 243.444, -0.141863 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 355.135, 243.112, 2.65064 );
            }
            
            break;
        case #"hash_12f3765ef24b4037":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 31381.3, -35260.4, -566.754 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 31087.5, -35307.9, -566.206 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 106, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 91, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37273.8, -22647.6, -566 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 38224.6, -23864.4, -566 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 225, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 225, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37183.4, -15816, -558.929 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 36704.9, -15941.1, -558 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37630.9, -15950.5, -564 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 34323.3, -25831.8, -566 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 45, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 31412.5, -34658.3, -564.862 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 31042.3, -16171.6, -565.383 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 105, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 75, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 36937.6, -15836.1, -559.8 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 37369.7, -16171.6, -562 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270, 0 );
            }
            
            break;
        case #"hash_924a3fbe9fbe15c6":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( -28937.7, -17197.8, -246.637 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29175.8, -17121.9, -247.909 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -28096.5, -16918.8, -246.085 );
                atvanglesarray[ atvanglesarray.size ] = ( 1.203, 90, 0.12 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.597, 90, 0.15 );
                atvanglesarray[ atvanglesarray.size ] = ( 358.68, 90.0277, -0.8 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -25926, -12688.6, -89.5073 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -24872.9, -12661.3, -65.0808 );
                atvanglesarray[ atvanglesarray.size ] = ( 5.13576, 104.619, 0.240957 );
                atvanglesarray[ atvanglesarray.size ] = ( 358.169, 15, -3.49767 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -28315.5, -3152.67, -311.293 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -28107.5, -3152.67, -311.293 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -27778.8, -3591.73, -310.621 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.061, 270, 7.355 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.061, 270, 7.355 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -25666, -8411.14, -47.9997 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -26998.2, -9004.54, -40 );
                atvanglesarray[ atvanglesarray.size ] = ( 358.715, 15.233, -10.279 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 285, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -28683.3, -16741.2, -249.16 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -29128.7, -16577.6, -229.266 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 359.734, 90.0021, -0.454 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 353.195, 90.3463, -3.01942 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -27985.4, -3613.97, -315.978 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -28449.8, -3645.92, -312.247 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270.003, 5.684 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270.004, -3.208 );
            }
            
            break;
        case #"hash_a8b272dba33a4aed":
            break;
        case #"hash_1bc93b88575e82eb":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( -9606.95, -21527.2, -279.043 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -10288.2, -20891.9, -356.989 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -11011.4, -19877, -368.358 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 200, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 222, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 359.526, 210.007, -0.952 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -13835.9, -23127.9, -278.639 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -14327.9, -22160.8, -266.586 );
                atvanglesarray[ atvanglesarray.size ] = ( 2.373, 210, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.806, 194.929, 2.603 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -21725.2, -26511, -152 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -21577.7, -26755.1, -151.997 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -21065.3, -27199.1, -148.746 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 30, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 60, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 5.079, 0.128, 1.453 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -18873.3, -25796.5, -199.784 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 30, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -10912.6, -20079.6, -367 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -10108.5, -21861.4, -287.271 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 196.996, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 7.93172, 180.719, 4.15911 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -22036.5, -25881.6, -147.198 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -21144.5, -27447.1, -151.145 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 345, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 30, 0 );
            }
            
            break;
        case #"hash_e4ca6b73b5022b26":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( -3749, 16980, -262 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -2971.9, 18898, -262 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -2735.8, 16203, -262 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 218, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 174, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 208, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -11894, 16161, -266 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -11841, 15884, -266 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 162, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 248, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29137, 12868, -244 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29539, 12883, -252 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29040, 13706, -497 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 0, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 0, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 5, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -19181, 16384, -263 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -19650, 17253, 54 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -19937, 16123, -261 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 310, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 357, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 35, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -3520, 17805, -262 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -3892, 18566, -262 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 165, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 194, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -29131, 13010, -244 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -28676, 13724, -518 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 0, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 355, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -19622, 17422, 54 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 357, 0 );
            }
            
            break;
        case #"hash_3a8b050ff58578ad":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 4103, 26076, 57 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 4247, 25021, -38 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 3517, 25981, 47 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 143, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 189, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 103, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 4989, 29842, 253 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 1725, 28703, 51 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 162, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 141, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -6826, 33623, -46 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -7642, 32168, -188 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -6589, 32564, -82 );
                atvanglesarray[ atvanglesarray.size ] = ( 3, 337, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 357, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 320, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -3326, 32657, 238 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -2149, 33264, 253 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 325, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 287, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 4157, 26465, 65 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 4628, 26545, 63 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 143, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 63, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -7337, 32683, -77 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -6671, 32948, -67 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 320, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 36, 0 );
            }
            
            break;
        default:
            break;
    }
    
    level.atvoriginsarray = atvoriginsarray;
    level.atvanglesarray = atvanglesarray;
    
    if ( vehicleref == "atv" )
    {
        for ( i = 0; i < atvoriginsarray.size ; i++ )
        {
            if ( i <= atvoriginsarray.size - 1 )
            {
                atvorigin = atvoriginsarray[ i ];
                atvangles = atvanglesarray[ i ];
                vehicle = spawnstruct();
                vehicle.origin = atvorigin;
                vehicle.angles = atvangles;
                vehicle.vehicletype = vehicletype;
                spawns[ spawns.size ] = vehicle;
            }
        }
    }
    else if ( vehicleref == "tac_rover" )
    {
        for ( i = 0; i < var_b60e03df1c17ae46.size ; i++ )
        {
            if ( i <= var_b60e03df1c17ae46.size - 1 )
            {
                tacroverorigin = var_b60e03df1c17ae46[ i ];
                tacroverangles = var_9e6d05dd2a832d1f[ i ];
                vehicle = spawnstruct();
                vehicle.origin = tacroverorigin;
                vehicle.angles = tacroverangles;
                vehicle.vehicletype = vehicletype;
                spawns[ spawns.size ] = vehicle;
            }
        }
    }
    
    dvarstring = hashcat( @"hash_ad95d7262a11119e", vehicleref );
    
    for ( index = 0; true ; index++ )
    {
        origindvarstring = hashcat( dvarstring, "_origin_", index );
        angledvarstring = hashcat( dvarstring, "_angles_", index );
        defaultorigin = ( 0, 0, 0 );
        origin = getdvarvector( origindvarstring, defaultorigin );
        
        if ( origin == ( 0, 0, 0 ) )
        {
            break;
        }
        
        vehicle = spawnstruct();
        vehicle.origin = origin;
        defaultangles = ( 0, 0, 0 );
        vehicle.angles = getdvarvector( angledvarstring, defaultangles );
        vehicle.vehicletype = vehicletype;
        spawns[ spawns.size ] = vehicle;
    }
    
    return spawns;
}

// Namespace ko
// Params 2
// Checksum 0xd82a71ff, Offset: 0x6aaa
// Size: 0x5f
function vehiclespawn_littlebird( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_49602cb7beee6fba", spawndata, faildata );
}

// Namespace ko
// Params 2
// Checksum 0x3d3b11df, Offset: 0x6b12
// Size: 0x5f
function vehiclespawn_atv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_21df6558fa3c728b", spawndata, faildata );
}

// Namespace ko
// Params 2
// Checksum 0x9ba73566, Offset: 0x6b7a
// Size: 0x5f
function vehiclespawn_tacrover( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_4725c8dee627919d", spawndata, faildata );
}

// Namespace ko
// Params 1
// Checksum 0xfe2a8b40, Offset: 0x6be2
// Size: 0x105
function filtervehiclespawnstructs( structs )
{
    filtered = [];
    
    if ( getdvarint( @"scr_brtdm_disable_radiant_vehicles", level.brtdm_config.locale_defaults[ "scr_brtdm_disable_radiant_vehicles" ] ) == 1 )
    {
        return filtered;
    }
    
    foreach ( struct in structs )
    {
        if ( distance2dsquared( struct.origin, level.brtdm_config.circlecenter ) < level.brtdm_config.circleradius * level.brtdm_config.circleradius )
        {
            filtered[ filtered.size ] = struct;
        }
    }
    
    return filtered;
}

// Namespace ko
// Params 0
// Checksum 0x32b32b92, Offset: 0x6cf0
// Size: 0x9
function function_82b1f7f5bbaa2f51()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace ko
// Params 1
// Checksum 0x424c87d1, Offset: 0x6d01
// Size: 0x63, Type: bool
function function_9e3ba7e27aef8223( point )
{
    if ( isdefined( level.knockoutflag ) )
    {
        if ( isdefined( point ) )
        {
            if ( utility::ispointinsidecircle( point, level.knockoutflag.curorigin, 40 ) )
            {
                return false;
            }
        }
        else if ( self istouching( level.knockoutflag.trigger ) )
        {
            return false;
        }
    }
    
    return true;
}

