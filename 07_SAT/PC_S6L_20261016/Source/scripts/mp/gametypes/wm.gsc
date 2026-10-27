// scripts\mp\gametypes\wm.gsc  (hash_0e5db4163ddc9246.gscc) (size: 32836 Bytes / 0x8044 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45a86674 (1168664180)
// size ...... 32836 (0x8044)
// includes .. 36  (offset: 0x7588)
// strings ... 131 (offset: 0x76a8)
// dev strs .. 15  (offset: 0x7f78)
// exports ... 70  (offset: 0x512c)
// cseg ...... 0x9ed + 0x473f (0x512c)
// imports ... 205 (offset: 0x5c1c)
// animtree1 . 0   (offset: 0x8044)
// animtree2 . 0   (offset: 0x8044)
#using script_1aadb848a02a4cf5;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\wm_ending;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\parachute;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace wm;

// Namespace wm
// Params 0
// Checksum 0x373b8387, Offset: 0xa0b
// Size: 0x3c8
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    thread wm_ui::init();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    setdvar( @"scr_starsystem", 0 );
    level.teambased = 1;
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.ontimelimit = &ontimelimit;
    level.ontimelimitot = &ontimelimitot;
    level.onrespawndelay = &getrespawndelay;
    level.onplayerconnect = &onplayerconnect;
    level.var_7cb9fe30089f39e0 = &function_42d020cd11c48bf7;
    
    if ( game_utility::function_bfa35a7c6234a9ad() )
    {
        level.var_30952fa9dbaf1e04 = 1;
        setdvar( @"scr_game_graceperiod", 5 );
    }
    
    level.var_3e02e08d03cf84c6 = &wm_ui::update_objective_ui;
    level.endgame = &wm_endgame;
    level.respawndelaytype = dvars::function_13909a5327c395b9( "respawnType", 0 );
    level.attackersrespawndelay = dvars::function_80a5871795f1cd82( "attackersRespawnDelay", 0 );
    level.defendersrespawndelay = dvars::function_80a5871795f1cd82( "defendersRespawnDelay", 0 );
    level.ontimelimitgraceperiod = 5;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
    wm_ending::init();
    level.bombsplanted = 0;
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    level.multibomb = 1;
    level.var_9a5624a6b320a884 = 1;
    level.flagreinforcement = 0;
    level.pausemodetimer = 0;
    level.disablemajoritycapprogress = 1;
    level.var_71e380fabc40f094 = 1;
    level.var_697ba496dd069d1b = 1;
    level.objectiveorder = [ "zone_1", "zone_2", "zone_3" ];
    level.var_d787a7b192a1705a = "war_mode_oob";
    level.var_3752001530d4a6ba = "war_mode_oob";
    function_4c3a66465ed7504f();
    level.testtdmanywhere = getdvarint( @"scr_tdmanywhere", 0 );
    level.tdmanywhere_dropheight = getdvarfloat( @"scr_tdmanywhere_drop_height", 1000 );
    level.tdmanywhere_perpenoffset = getdvarfloat( @"hash_631c58033f43c2dc", 2048 );
    level.tdmanywhere_distoffset = getdvarfloat( @"scr_tdmanywhere_dist_offset", 4092 );
    level.var_d9d68aeaf1fa45a7 = 1;
    level.parachutecancutparachute = 1;
    
    if ( level.testtdmanywhere )
    {
        parachute::initparachutedvars();
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    level thread function_b976e6412203fca5();
    var_60e644609012cd3 = getentarray( "wm_toggle_visual_ent", #script_noteworthy );
    
    foreach ( ent in var_60e644609012cd3 )
    {
        ent notsolid();
    }
    
    /#
        level thread function_587282b8bfef524a();
    #/
}

// Namespace wm
// Params 0
// Checksum 0xaff1ca8d, Offset: 0xddb
// Size: 0x48c
function function_af03c89acdc3a3a7()
{
    function_810c9e27897ab161();
    level thread wm_ui::function_2584814c5c873ad5();
    level.defaulttimelimit = dvars::getwatcheddvar( "timelimit" );
    var_f9b82a3c525bd3f2 = dvars::function_13909a5327c395b9( "stopWatchEnabled", 0 );
    var_f9323042e910a86d = undefined;
    
    foreach ( i, objectivestr in level.objectiveorder )
    {
        level.zone = level.zones[ objectivestr ];
        
        if ( !isdefined( level.zone ) )
        {
            break;
        }
        
        if ( !isdefined( level.zone.objectives ) )
        {
            return;
        }
        
        level.zone.index = i;
        
        if ( var_f9b82a3c525bd3f2 && game[ "switchedsides" ] )
        {
            timetobeat = game[ "wm_objective_complete_time_round_" + 1 ][ level.zone.name ];
            
            if ( timetobeat == 0 )
            {
                break;
            }
        }
        
        if ( isdefined( var_f9323042e910a86d ) )
        {
            level thread wm_ui::function_8f6d4808684aff73( var_f9323042e910a86d, level.zone.objectivetype );
        }
        
        level thread function_e654a05ad6a4c693( level.zone );
        wm_ui::set_ui_objective( level.zone );
        function_ed62f38b2ece9c08( objectivestr );
        level thread run_wm_oob_logic( level.zone );
        function_178b3215a6e133f3( level.zone );
        function_1b2f25baf8df063b( level.zone );
        function_b5fe28a15ceeaa49( level.zone );
        level.ontimelimitot = &ontimelimitot;
        objcount = level.zone.objectives.size;
        
        /#
            if ( function_15cac5ed8ead9224( objectivestr ) )
            {
                level thread function_ab064cc697b85cc6( level.zone.objectives );
            }
        #/
        
        while ( objcount > 0 )
        {
            objcount = 0;
            
            foreach ( obj in level.zone.objectives )
            {
                if ( !level.objectives[ obj ].complete )
                {
                    objcount++;
                }
            }
            
            baseprogress = i / level.objectiveorder.size;
            objectiveprogress = ( level.zone.objectives.size - objcount ) / level.zone.objectives.size;
            
            if ( game_utility::getmapname() == "mp_jup_launchfacility" && level.zone.objective.objectivetype == 6 )
            {
                if ( isdefined( level.escortvehicles[ 0 ] ) )
                {
                    objectiveprogress = level.escortvehicles[ 0 ].progress;
                }
            }
            
            totalprogress = baseprogress + objectiveprogress * 1 / level.objectiveorder.size;
            setomnvar( "ui_wm_objective_progress_total", totalprogress );
            waitframe();
        }
        
        level callback::callback( #"music_event", { #team:game[ "attackers" ], #event_type:#"hash_25d3360569c20580" } );
        function_e938c1d858a50a00( level.zone );
        var_d5e5ace5586626d = level.objectiveorder[ i + 1 ];
        
        if ( isdefined( var_d5e5ace5586626d ) )
        {
            function_560842cbc0d11633( level.zones[ var_d5e5ace5586626d ] );
        }
        
        function_c44219d5bc0ea0b8( level.zone );
        function_7be446c06a37ae01( level.zone );
        function_db14c09247aa4f98( objectivestr );
        utility::delaythread( 23, &function_810c9e27897ab161 );
        thread print::printandsoundoneveryone( game[ "attackers" ], game[ "defenders" ], undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost" );
        var_f9323042e910a86d = level.zone.objectivetype;
        waitframe();
    }
    
    function_77f5dbb2603c259();
}

// Namespace wm
// Params 3
// Checksum 0x2dae9db, Offset: 0x126f
// Size: 0xb8
function wm_endgame( winner, endreasontext, nukedetonated )
{
    level.var_745e643a4920d7d8 = 1;
    
    foreach ( player in level.players )
    {
        namespace_4c5fce57fb970de0::function_58f3f8f7651deb2a( player );
        player.operatorcustomization = undefined;
    }
    
    gamelogic_mp::endgame_regularmp( winner, endreasontext, nukedetonated );
}

// Namespace wm
// Params 0
// Checksum 0xb93da889, Offset: 0x132f
// Size: 0x48
function ontimelimit()
{
    if ( level.var_745e643a4920d7d8 )
    {
        return;
    }
    
    function_c44219d5bc0ea0b8( level.zone );
    wm_objectives::function_c9d147f92994b0b3( level.zone.objectivetype );
    function_ce3bf7bf55d02545();
    wm_ui::end_ui_objective( 0 );
}

// Namespace wm
// Params 1
// Checksum 0xd7a66fad, Offset: 0x137f
// Size: 0x196
function function_e654a05ad6a4c693( zone )
{
    objectivestr = level.var_c33d86c8057ff0bb[ zone.objectivetype ];
    
    if ( !isdefined( objectivestr ) || level.defaulttimelimit == 0 )
    {
        return;
    }
    
    rulename = objectivestr + "TimeLimit";
    
    if ( isusingmatchrulesdata() )
    {
        if ( getmatchrulesdata( "wmData", rulename ) != 0 )
        {
            setdynamicdvar( hashcat( @"hash_b56dd6b9b6093824", rulename ), getmatchrulesdata( "wmData", rulename ) );
        }
    }
    
    timelimit = getdvarfloat( hashcat( @"hash_b56dd6b9b6093824", objectivestr, "TimeLimit" ), level.defaulttimelimit );
    
    if ( isdefined( zone.objective.params[ "timelimit" ] ) )
    {
        timelimit = zone.objective.params[ "timelimit" ];
    }
    
    if ( dvars::function_13909a5327c395b9( "stopWatchEnabled", 0 ) && game[ "switchedsides" ] )
    {
        timetobeat = game[ "wm_objective_complete_time_round_" + 1 ][ zone.name ];
        timelimit = timetobeat + level.var_f2e45432aa3b34db;
    }
    
    if ( timelimit != dvars::getwatcheddvar( "timelimit" ) )
    {
        setdvar( @"scr_wm_timelimit", timelimit );
    }
    
    if ( !game[ "switchedsides" ] )
    {
        game[ "wm_objective_time_limit" ][ zone.name ] = timelimit;
    }
    
    flags::gameflagwait( "prematch_done" );
    level.currentobjectivestarttime = gettime();
}

// Namespace wm
// Params 1
// Checksum 0xb81024b4, Offset: 0x151d
// Size: 0xea
function function_c44219d5bc0ea0b8( zone )
{
    objectivetimepassed = ( gettime() - level.currentobjectivestarttime ) / 1000;
    
    if ( !game[ "switchedsides" ] )
    {
        objtimelimit = game[ "wm_objective_time_limit" ][ zone.name ];
        
        if ( objectivetimepassed > objtimelimit )
        {
            objectivetimepassed = objtimelimit;
        }
    }
    else
    {
        timetobeat = game[ "wm_objective_complete_time_round_" + 1 ][ zone.name ];
        
        if ( objectivetimepassed < timetobeat )
        {
            level.var_f2e45432aa3b34db = timetobeat - objectivetimepassed;
        }
        else
        {
            level.var_f2e45432aa3b34db = 0;
            objectivetimepassed = timetobeat;
        }
    }
    
    game[ "wm_objective_complete_time_round_" + game[ "roundsPlayed" ] + 1 ][ zone.name ] = objectivetimepassed;
    setomnvar( "ui_wm_objective_complete_time_" + zone.index, int( floor( objectivetimepassed * 1000 ) ) );
}

// Namespace wm
// Params 0
// Checksum 0xa257ad6d, Offset: 0x160f
// Size: 0x16c
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    dvars::function_60bcfae5d310eb1f( "domData", "flagCaptureTime" );
    dvars::function_60bcfae5d310eb1f( "wmData", "respawnType" );
    dvars::function_60bcfae5d310eb1f( "wmData", "attackersRespawnDelay" );
    dvars::function_60bcfae5d310eb1f( "wmData", "defendersRespawnDelay" );
    dvars::function_60bcfae5d310eb1f( "wmData", "stopWatchEnabled" );
    dvars::function_60bcfae5d310eb1f( "wmData", "buildableEnabled" );
    dvars::function_60bcfae5d310eb1f( "wmData", "zoneReversible" );
    dvars::function_60bcfae5d310eb1f( "wmData", "tankTurretUsable" );
    dvars::function_60bcfae5d310eb1f( "wmData", "IEDBombEnabled" );
    dvars::function_60bcfae5d310eb1f( "wmData", "RPGAgentsEnabled" );
    dvars::function_60bcfae5d310eb1f( "wmData", "tankMaxHealth" );
    dvars::function_60bcfae5d310eb1f( "wmData", "tankSpeed" );
    dvars::function_60bcfae5d310eb1f( "wmData", "tankRepair" );
    dvars::function_60bcfae5d310eb1f( "wmData", "tankContestable" );
    dvars::function_60bcfae5d310eb1f( "wmData", "tankReversible" );
    dvars::function_60bcfae5d310eb1f( "wmData", "hackUseTime" );
    dvars::function_60bcfae5d310eb1f( "wmData", "hackRestoreTime" );
    dvars::function_60bcfae5d310eb1f( "wmData", "hackUploadTime" );
    
    if ( game_utility::getmapname() == "mp_jup_launchfacility" )
    {
        dvars::function_60bcfae5d310eb1f( "wmData", "lfEscortTimeLimit" );
        dvars::function_60bcfae5d310eb1f( "wmData", "lfFlagCaptureTime" );
    }
}

// Namespace wm
// Params 0
// Checksum 0xac6d63f8, Offset: 0x1783
// Size: 0x16a
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    wm_ui::update_ui_attacking_team( game[ "attackers" ] );
    
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
    
    seticonnames();
    function_30e6986515be13a4();
    level thread wm_objectives::init_wm_objectives();
    level thread wm_spawn_vehicles();
    parachute::initparachutedvars();
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
    
    function_bd05a59f237fd34();
    level thread function_af03c89acdc3a3a7();
    
    if ( getdvarint( @"hash_af6b97ac5aefbcab", 1 ) && game_utility_mp::matchmakinggame() && game_utility::function_bfa35a7c6234a9ad() )
    {
        level.forceteamassignmentoverride = &wmforceteamassignmentoverride;
    }
}

// Namespace wm
// Params 0
// Checksum 0xf73bc1f8, Offset: 0x18f5
// Size: 0xb1
function function_bd05a59f237fd34()
{
    level.var_f2e45432aa3b34db = 0;
    
    if ( !game[ "switchedsides" ] )
    {
        foreach ( objectivestr in level.objectiveorder )
        {
            game[ "wm_objective_complete_time_round_" + 1 ][ objectivestr ] = 0;
            game[ "wm_objective_complete_time_round_" + 2 ][ objectivestr ] = 0;
            game[ "wm_objective_time_limit" ][ objectivestr ] = 0;
        }
    }
}

// Namespace wm
// Params 0
// Checksum 0x40e59fd6, Offset: 0x19ae
// Size: 0x4a
function function_b976e6412203fca5()
{
    while ( !flags::gameflagexists( "infil_started" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "infil_started" );
    wait 1;
    dialog::leaderdialog( "offense_infil", game[ "attackers" ] );
    dialog::leaderdialog( "defense_infil", game[ "defenders" ] );
}

// Namespace wm
// Params 0
// Checksum 0x1cfced94, Offset: 0x1a00
// Size: 0x4b
function ontimelimitot()
{
    wm_objectives::function_176c17ff4882c71a();
    
    if ( level.mapname == "mp_jup_launchfacility" )
    {
        currentobjective = level.zone.objectivetype;
        level notify( "obj_type_" + currentobjective + "_overtime_launchfacility" );
    }
}

// Namespace wm
// Params 0
// Checksum 0x8e6e05d8, Offset: 0x1a53
// Size: 0x663
function function_30e6986515be13a4()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_wm_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_wm_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_wm_spawn_allies_start" );
    spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_wm_spawn_axis_start" );
    attackers = spawnlogic::getspawnpointarray( "mp_wm_spawn_allies_start" );
    defenders = spawnlogic::getspawnpointarray( "mp_wm_spawn_axis_start" );
    spawnlogic::registerspawnset( #"start_attackers", attackers );
    spawnlogic::registerspawnset( #"start_defenders", defenders );
    spawnlogic::addspawnpointslegacy( "allies", "WM_SPAWN_POINT_SUB_STRING" );
    spawnlogic::addspawnpointslegacy( "axis", "WM_SPAWN_POINT_SUB_STRING" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_wm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_wm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_wm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_wm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    level.zones = [];
    volumes = [];
    var_b45203fa056fcfcb = [];
    
    foreach ( i, objectivestr in level.objectiveorder )
    {
        zone = spawnstruct();
        zone.subzones = [];
        zone.subzones[ "attackers" ] = getent( objectivestr + "_attackers", #targetname );
        zone.subzones[ "defenders" ] = getent( objectivestr + "_defenders", #targetname );
        zone.subzones[ "attackers" ].side = "attackers";
        zone.subzones[ "defenders" ].side = "defenders";
        zone.name = objectivestr;
        level.zones[ objectivestr ] = zone;
        
        foreach ( k, volume in zone.subzones )
        {
            volume.spawnset = hashcat( #"spawn_set", "_" + i + "_" + k );
            volume.fallbackspawnset = hashcat( #"spawn_set_fallback_", "_" + i + "_" + k );
            volume.spawnpoints = [];
            volume.fallbackspawnpoints = [];
            
            if ( !isdefined( volumes[ volume.targetname ] ) )
            {
                volumes[ volume.targetname ] = [];
            }
            
            size = volumes[ volume.targetname ].size;
            volumes[ volume.targetname ][ size ] = volume;
            var_b45203fa056fcfcb[ volume.spawnset ] = [];
            var_b45203fa056fcfcb[ volume.fallbackspawnset ] = [];
        }
    }
    
    spawnpoints = arraycombine( getspawnarray( "mp_wm_spawn" ), getspawnarray( "mp_wm_spawn_secondary" ) );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( isdefined( spawnpoint.target ) && spawnpoint.target != "" )
        {
            if ( isdefined( volumes[ spawnpoint.target ] ) )
            {
                foreach ( volume in volumes[ spawnpoint.target ] )
                {
                    key = undefined;
                    
                    if ( spawnpoint.classname == "mp_wm_spawn" )
                    {
                        key = volume.spawnset;
                        size = volume.spawnpoints.size;
                        volume.spawnpoints[ size ] = spawnpoint;
                    }
                    else if ( spawnpoint.classname == "mp_wm_spawn_secondary" )
                    {
                        key = volume.fallbackspawnset;
                        size = volume.fallbackspawnset.size;
                        volume.fallbackspawnpoints[ size ] = spawnpoint;
                    }
                    
                    size = var_b45203fa056fcfcb[ key ].size;
                    var_b45203fa056fcfcb[ key ][ size ] = spawnpoint;
                }
            }
        }
        
        if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy != "" )
        {
            if ( !isdefined( var_b45203fa056fcfcb[ spawnpoint.script_noteworthy ] ) )
            {
                var_b45203fa056fcfcb[ spawnpoint.script_noteworthy ] = [];
            }
            
            size = var_b45203fa056fcfcb[ spawnpoint.script_noteworthy ].size;
            var_b45203fa056fcfcb[ spawnpoint.script_noteworthy ][ size ] = spawnpoint;
        }
    }
    
    foreach ( key, points in var_b45203fa056fcfcb )
    {
        spawnlogic::registerspawnset( key, points );
    }
}

// Namespace wm
// Params 2
// Checksum 0xb4b3269e, Offset: 0x20be
// Size: 0x73
function function_91c5d29bd04d412f( prefix, spawnsetkey )
{
    level.zone.subzones[ "attackers" ].spawnset = prefix + "_attackers_" + spawnsetkey;
    level.zone.subzones[ "defenders" ].spawnset = prefix + "_defenders_" + spawnsetkey;
}

// Namespace wm
// Params 0
// Checksum 0xa670ba29, Offset: 0x2139
// Size: 0x40
function getrespawndelay()
{
    if ( level.respawndelaytype == 0 )
    {
        if ( self.team == game[ "defenders" ] )
        {
            return level.defendersrespawndelay;
        }
        else
        {
            return level.attackersrespawndelay;
        }
        
        return;
    }
    
    return 0;
}

// Namespace wm
// Params 0
// Checksum 0x78ec10c1, Offset: 0x2181
// Size: 0x264
function wm_spawn_vehicles()
{
    canspawnvehicles = getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 0;
    
    if ( canspawnvehicles )
    {
        structarray = vehicle_spawn::get_spawn_structs( %"vehiclebundle:veh9_rhib_mp" );
        
        foreach ( struct in structarray )
        {
            spawndata = spawnstruct();
            spawndata.origin = struct.origin;
            spawndata.angles = struct.angles;
            vehicle = vehicle::spawn( %"vehiclebundle:veh9_rhib_mp", spawndata );
        }
        
        structarray = vehicle_spawn::get_spawn_structs( %"hash_4c7e54cca5ad7fd8" );
        
        foreach ( struct in structarray )
        {
            spawndata = spawnstruct();
            spawndata.origin = struct.origin;
            spawndata.angles = struct.angles;
            vehicle = vehicle::spawn( %"hash_4c7e54cca5ad7fd8", spawndata );
        }
        
        structarray = vehicle_spawn::get_spawn_structs( "veh_jup_atv" );
        
        foreach ( struct in structarray )
        {
            spawndata = spawnstruct();
            spawndata.origin = struct.origin;
            spawndata.angles = struct.angles;
            vehicle = vehicle::spawn( %"hash_21df6558fa3c728b", spawndata );
        }
    }
}

// Namespace wm
// Params 1
// Checksum 0xdda3a31d, Offset: 0x23ed
// Size: 0xbd
function function_7be446c06a37ae01( zone )
{
    if ( level.timelimit == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.extratime ) )
    {
        level.extratime = 0;
    }
    
    time = float( game_utility::gettimepassed() / 1000 );
    level.extratime = time;
    timeremaining = gamelogic_mp::gettimeremaining();
    
    if ( isdefined( zone.objective.params[ "extraTimeGap" ] ) )
    {
        pausetime = zone.objective.params[ "extraTimeGap" ];
        gamelogic_mp::pausetimer();
        wait pausetime;
    }
    
    gamelogic_mp::resumetimer( timeremaining );
}

// Namespace wm
// Params 1
// Checksum 0x96933bc3, Offset: 0x24b2
// Size: 0x102
function function_560842cbc0d11633( zone )
{
    objectivestr = zone.name;
    
    if ( objectivestr != "zone_1" )
    {
        var_b7ae9c2eb3773c0a = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.pers[ "team" ] == game[ "attackers" ] )
            {
                continue;
            }
            
            player thread set_player_retreating( 3, level.zone.objectives, objectivestr );
            var_b7ae9c2eb3773c0a = 1;
        }
        
        if ( var_b7ae9c2eb3773c0a )
        {
            level thread function_ee59345047ff7b68();
        }
    }
}

// Namespace wm
// Params 0
// Checksum 0x5edcddf9, Offset: 0x25bc
// Size: 0xe9
function function_ee59345047ff7b68()
{
    level endon( #"game_ended" );
    level.var_c1b2b25ae4535459 = 1;
    var_ebb7069d521aeae9 = 1;
    
    while ( var_ebb7069d521aeae9 )
    {
        wait 1;
        var_ebb7069d521aeae9 = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.pers[ "team" ] == game[ "attackers" ] )
            {
                continue;
            }
            
            if ( player.var_628b2b310720c69f )
            {
                var_ebb7069d521aeae9 = 1;
            }
        }
    }
    
    level.var_c1b2b25ae4535459 = 0;
}

// Namespace wm
// Params 1
// Checksum 0x814b6e01, Offset: 0x26ad
// Size: 0x128
function function_178b3215a6e133f3( zone )
{
    objectives = zone.objectives;
    
    /#
        var_23012ea6bed11d66 = [ "<dev string:x24>", "<dev string:x27>", "<dev string:x2a>", "<dev string:x2d>", "<dev string:x30>", "<dev string:x33>", "<dev string:x36>" ];
    #/
    
    foreach ( i, obj in objectives )
    {
        label = obj;
        
        /#
            if ( level.var_8534d45d29f17686 )
            {
                label = var_23012ea6bed11d66[ i ];
            }
        #/
        
        objectivetype = level.objectives[ obj ].objectivetype;
        [[ level.var_17249d5fa9da615b[ objectivetype ] ]]( label );
    }
}

// Namespace wm
// Params 1
// Checksum 0xd9ee38b1, Offset: 0x27dd
// Size: 0xc6
function function_b5fe28a15ceeaa49( zone )
{
    if ( isdefined( level.var_6a6acdc6985d1d87[ zone.objectivetype ] ) )
    {
        struct = level.var_6a6acdc6985d1d87[ zone.objectivetype ];
        level thread wm_objectives::function_bc5633dd87083184( 9, 8, struct.attackerline, "attackers" );
        level thread wm_objectives::function_bc5633dd87083184( 9, 8, struct.defenderline, "defenders" );
    }
    
    if ( isdefined( level.var_71378520253690c2[ zone.objectivetype ] ) )
    {
        level thread [[ level.var_71378520253690c2[ zone.objectivetype ] ]]( zone );
    }
    
    if ( level.var_89a304fc199d7919 )
    {
        level thread function_f1e7581784610aed();
    }
}

// Namespace wm
// Params 1
// Checksum 0x81e67ef1, Offset: 0x28ab
// Size: 0x15b
function function_1b2f25baf8df063b( zone )
{
    [[ level.var_c50b39c472783aa1[ zone.objectivetype ] ]]( zone );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player wm_ui::start_ui_objective();
        }
    }
    
    flags::gameflagset( zone.name + "_objective_start" );
    dlog_recordevent( "dlog_event_wm_server_objective_start", [ "match_guid", getonlinematchid(), "map_name", level.script, "objective_time", gettime() / 1000, "objective_type", string( zone.objectivetype ), "objective_id", zone.name, "round", "" + game[ "roundsPlayed" ] ] );
}

// Namespace wm
// Params 1
// Checksum 0x89655357, Offset: 0x2a0e
// Size: 0xde
function function_e938c1d858a50a00( zone )
{
    [[ level.var_63156b5d1bea415a[ zone.objectivetype ] ]]( zone );
    wm_ui::end_ui_objective( 1 );
    flags::gameflagset( zone.name + "_objective_end" );
    dlog_recordevent( "dlog_event_wm_server_objective_end", [ "match_guid", getonlinematchid(), "map_name", level.script, "objective_time", gettime() / 1000, "objective_type", string( zone.objectivetype ), "objective_id", zone.name, "round", "" + game[ "roundsPlayed" ] ] );
}

// Namespace wm
// Params 1
// Checksum 0xcceed6a6, Offset: 0x2af4
// Size: 0x106
function function_ed62f38b2ece9c08( zone )
{
    level.var_26b85f80693c6f95 = [];
    
    foreach ( side in [ "attackers", "defenders" ] )
    {
        level.var_26b85f80693c6f95[ side ] = getentarray( zone + "_oob_line_" + side, #targetname );
    }
    
    temp = level.var_26b85f80693c6f95[ "attackers" ];
    level.var_26b85f80693c6f95[ "attackers" ] = level.var_26b85f80693c6f95[ "defenders" ];
    level.var_26b85f80693c6f95[ "defenders" ] = temp;
    function_3c9eb33602d6f7ba();
}

// Namespace wm
// Params 1
// Checksum 0xae1ca096, Offset: 0x2c02
// Size: 0x35
function function_810c9e27897ab161( zone )
{
    level.wm_fallback_lines[ "attackers" ] = [];
    level.wm_fallback_lines[ "defenders" ] = [];
    function_3c9eb33602d6f7ba();
}

// Namespace wm
// Params 1
// Checksum 0x83be408d, Offset: 0x2c3f
// Size: 0xca
function function_db14c09247aa4f98( zone )
{
    level.wm_fallback_lines = [];
    
    foreach ( side in [ "attackers", "defenders" ] )
    {
        level.wm_fallback_lines[ side ] = getentarray( zone + "_fallback_lines", #targetname );
    }
    
    level.wm_fallback_lines[ "attackers" ] = [];
    function_3c9eb33602d6f7ba();
}

// Namespace wm
// Params 0
// Checksum 0x2afb98a2, Offset: 0x2d11
// Size: 0x7b
function function_3c9eb33602d6f7ba()
{
    foreach ( player in level.players )
    {
        function_2e000bd8537b1aac( player );
    }
}

// Namespace wm
// Params 1
// Checksum 0xd5e6c15c, Offset: 0x2d94
// Size: 0xf6
function function_2e000bd8537b1aac( player )
{
    allents = getentarray( "wm_toggle_visual_ent", #script_noteworthy );
    
    foreach ( ent in allents )
    {
        ent hidefromplayer( player );
    }
    
    if ( isdefined( level.wm_fallback_lines ) )
    {
        function_c4c41f7acfd7a437( player, level.wm_fallback_lines );
    }
    
    if ( isdefined( level.var_26b85f80693c6f95 ) )
    {
        function_c4c41f7acfd7a437( player, level.var_26b85f80693c6f95 );
    }
    
    if ( isdefined( level.var_c4398748358e41a5 ) )
    {
        function_c4c41f7acfd7a437( player, level.var_c4398748358e41a5 );
    }
}

// Namespace wm
// Params 2
// Checksum 0xeef16827, Offset: 0x2e92
// Size: 0x1a3
function function_c4c41f7acfd7a437( player, array )
{
    var_fcb018d681583214 = [];
    var_ded16c723a5c62a5 = [];
    
    foreach ( side in [ "attackers", "defenders" ] )
    {
        if ( player.pers[ "team" ] == game[ side ] )
        {
            var_fcb018d681583214 = array[ side ];
            continue;
        }
        
        var_ded16c723a5c62a5 = array[ side ];
    }
    
    foreach ( ent in var_fcb018d681583214 )
    {
        ent showtoplayer( player );
    }
    
    foreach ( ent in var_ded16c723a5c62a5 )
    {
        ent hidefromplayer( player );
    }
}

/#

    // Namespace wm
    // Params 1
    // Checksum 0x7780f6ae, Offset: 0x303d
    // Size: 0x58, Type: dev
    function function_15cac5ed8ead9224( zone )
    {
        if ( zone == "<dev string:x39>" && getdvarint( @"hash_562d6f609676f102", 0 ) )
        {
            return 0;
        }
        
        if ( getdvarint( @"hash_562d6f609676f102", 0 ) )
        {
            return 1;
        }
        
        if ( getdvarint( @"hash_2251ec03b35920c4", 0 ) )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace wm
    // Params 1
    // Checksum 0xd3ecb086, Offset: 0x309d
    // Size: 0x105, Type: dev
    function function_ab064cc697b85cc6( objectives )
    {
        flags::gameflagwait( "<dev string:x40>" );
        wait 5;
        
        foreach ( obj in objectives )
        {
            level.objectives[ obj ].complete = 1;
            
            if ( level.objectives[ obj ].id == "<dev string:x4e>" )
            {
                obj_dom::removeobjective( level.objectives[ obj ] );
                continue;
            }
            
            level.objectives[ obj ] gameobjects::setvisibleteam( "<dev string:x56>" );
            level.objectives[ obj ] gameobjects::allowuse( "<dev string:x56>" );
        }
    }

#/

// Namespace wm
// Params 3
// Checksum 0x1e7916e6, Offset: 0x31aa
// Size: 0xd0
function set_player_retreating( delaytime, objectives, zone_name )
{
    player = self;
    player endon( #"disconnect" );
    player notify( #"death_or_disconnect" );
    player.var_628b2b310720c69f = 1;
    player function_c4f18802d9b14b7a();
    oobtimelimit = 20;
    wait delaytime;
    
    if ( player::isreallyalive( player ) )
    {
        player wm_ui::function_e50496e135055296( oobtimelimit, 1 );
        player thread function_315ff38f6a67af0d( oobtimelimit );
        player function_dd5730065e8f9ec1( level.zones[ zone_name ] );
    }
    
    player notify( #"hash_54b93d3107b6df53" );
    player.var_628b2b310720c69f = undefined;
    player function_c4f18802d9b14b7a();
    player.oobtimelimit = 5;
}

// Namespace wm
// Params 1
// Checksum 0x6d80c11e, Offset: 0x3282
// Size: 0x9b
function function_dd5730065e8f9ec1( zone )
{
    player = self;
    player endon( #"death_or_disconnect" );
    trigger = getent( "fallback_destination_trigger_" + zone.name, #targetname );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    player thread function_ff22ecb8cb190256();
    
    while ( !player istouching( trigger ) || player istouching( zone.subzones[ "attackers" ] ) )
    {
        waitframe();
    }
    
    player points::doscoreevent( #"hash_3a01ed4e57a4faa2" );
}

// Namespace wm
// Params 0
// Checksum 0x7e1c92a6, Offset: 0x3325
// Size: 0x91
function function_ff22ecb8cb190256()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_54b93d3107b6df53" );
    retreatstarttime = gettime();
    
    while ( true )
    {
        if ( !isdefined( self.var_628b2b310720c69f ) )
        {
            return;
        }
        
        self waittill( #"hash_e318807b3bc1cae2" );
        retreattimepassed = gettime();
        timeleft = int( floor( 20 - ( retreattimepassed - retreatstarttime ) / 1000 ) );
        waitframe();
        wm_ui::function_e50496e135055296( timeleft, 1 );
    }
}

// Namespace wm
// Params 1
// Checksum 0x2ee18c2, Offset: 0x33be
// Size: 0x2c5
function run_wm_oob_logic( zone )
{
    level endon( #"game_ended" );
    level notify( #"run_wm_oob_logic" );
    level endon( #"run_wm_oob_logic" );
    volumes = zone.subzones;
    
    if ( !isdefined( volumes ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_9a49531827cbbaa5", 0 ) )
    {
        return;
    }
    
    /#
        level thread debug_oob_triggers( volumes );
    #/
    
    flags::gameflagwait( "prematch_done" );
    
    foreach ( player in level.players )
    {
        player.oobtimelimit = 5;
        player.var_e4cb0f341fec0c4e = 0;
        player.var_836dbdc898238650 = gettime();
    }
    
    while ( true )
    {
        if ( isdefined( level.var_a67a2b75a3f21bb5 ) )
        {
            volumes = level.var_a67a2b75a3f21bb5;
        }
        else
        {
            volumes = zone.subzones;
        }
        
        foreach ( player in level.players )
        {
            foreach ( volume in volumes )
            {
                if ( function_73f3bcee1eafccb2( player, volume ) )
                {
                    if ( player.var_e4cb0f341fec0c4e == 0 )
                    {
                        player.oobstarttime = gettime();
                        
                        if ( player.oobstarttime - player.var_836dbdc898238650 > 5000 )
                        {
                            player.oobtimelimit = 5;
                        }
                    }
                    
                    player.var_e4cb0f341fec0c4e = 1;
                    player function_9bfc55558d794540();
                    player wm_ui::function_e50496e135055296( player.oobtimelimit );
                    player thread function_5e301e7a571ade4c( volume );
                    
                    if ( player.var_e4cb0f341fec0c4e )
                    {
                        player thread function_315ff38f6a67af0d( player.oobtimelimit );
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace wm
// Params 1
// Checksum 0xe0a303f, Offset: 0x368b
// Size: 0xb7
function debug_oob_triggers( volumes )
{
    level endon( #"run_wm_oob_logic" );
    
    if ( !getdvarint( @"scr_debug_oob_triggers", 0 ) )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( volume in volumes )
        {
            botdebugdrawtrigger( 1, volume, ( 1, 0, 0 ), 1 );
        }
        
        wait 1;
    }
}

// Namespace wm
// Params 2
// Checksum 0xb03d7d5a, Offset: 0x374a
// Size: 0x77, Type: bool
function function_73f3bcee1eafccb2( player, volume )
{
    /#
        if ( getdvarint( @"hash_2251ec03b35920c4", 0 ) )
        {
            return false;
        }
    #/
    
    if ( player.var_e4cb0f341fec0c4e )
    {
        return false;
    }
    
    if ( player.var_628b2b310720c69f )
    {
        return false;
    }
    
    if ( !player istouching( volume ) )
    {
        return false;
    }
    
    if ( !player function_692b745dbca63c59( volume ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace wm
// Params 1
// Checksum 0x7807f830, Offset: 0x37ca
// Size: 0x42, Type: bool
function function_692b745dbca63c59( volume )
{
    volumeteam = game[ volume.side ];
    playerteam = self.pers[ "team" ];
    return volumeteam != playerteam;
}

// Namespace wm
// Params 1
// Checksum 0x6e3d8c3b, Offset: 0x3815
// Size: 0x42, Type: bool
function function_ce09e729d21e7354( volume )
{
    volumeteam = game[ volume.side ];
    playerteam = self.pers[ "team" ];
    return volumeteam == playerteam;
}

// Namespace wm
// Params 1
// Checksum 0x271fcae1, Offset: 0x3860
// Size: 0x6f
function function_315ff38f6a67af0d( time )
{
    player = self;
    player endon( #"hash_a2e51ad92cca329f" );
    player endon( #"death_or_disconnect" );
    
    if ( time > 0 )
    {
        wait time;
    }
    
    player.oobdeath = 1;
    player damage::_suicide( undefined, 1 );
    player.oobdeath = undefined;
    player.var_e4cb0f341fec0c4e = 0;
}

// Namespace wm
// Params 1
// Checksum 0x60e56fc9, Offset: 0x38d7
// Size: 0x58
function function_5e301e7a571ade4c( volume )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"start_retreat" );
    
    while ( player istouching( volume ) )
    {
        waitframe();
    }
    
    if ( player.var_e4cb0f341fec0c4e )
    {
        player function_c4f18802d9b14b7a();
    }
}

// Namespace wm
// Params 0
// Checksum 0xab3520d2, Offset: 0x3937
// Size: 0xa8
function function_c4f18802d9b14b7a()
{
    player = self;
    player.var_e4cb0f341fec0c4e = 0;
    player.var_836dbdc898238650 = gettime();
    
    if ( isdefined( player.oobtimelimit ) && isdefined( player.oobstarttime ) )
    {
        player.oobtimelimit = int( player.oobtimelimit - ( player.var_836dbdc898238650 - player.oobstarttime ) / 1000 );
    }
    
    player notify( #"hash_a2e51ad92cca329f" );
    player setclientomnvar( "ui_out_of_bounds_type", 0 );
    player setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace wm
// Params 1
// Checksum 0x8b374cda, Offset: 0x39e7
// Size: 0x1b
function function_dfb2277145204ce4( origin )
{
    return function_47c86977a18df38b( level.objectives, origin );
}

// Namespace wm
// Params 2
// Checksum 0x8180f8b1, Offset: 0x3a0b
// Size: 0x46, Type: bool
function function_58ec5e3f40b77f9( obj1, obj2 )
{
    return distance( obj1.curorigin, level.var_ce10d7a0dc140a7 ) < distance( obj2.curorigin, level.var_ce10d7a0dc140a7 );
}

// Namespace wm
// Params 0
// Checksum 0x50650b96, Offset: 0x3a5a
// Size: 0xe6
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.bombtimer = dvars::dvarfloatvalue( "bombtimer", 45, 1, 240 );
    level.planttime = dvars::dvarfloatvalue( "planttime", 10, 0, 20 );
    level.defusetime = dvars::dvarfloatvalue( "defusetime", 5, 0, 20 );
    level.multibomb = dvars::dvarintvalue( "multibomb", 1, 0, 1 );
    level.silentplant = dvars::dvarintvalue( "silentPlant", 0, 0, 1 );
    level.resetprogress = dvars::dvarintvalue( "resetProgress", 0, 0, 1 );
    level.defenderscanseedroppedbomb = dvars::dvarintvalue( "defendersCanSeeDroppedBomb", 0, 0, 1 );
    level.defenderscanseeplantedbomb = dvars::dvarintvalue( "defendersCanSeePlantedBomb", 0, 0, 1 );
    level.assignbombzonechevrons = dvars::dvarintvalue( "assignBombZoneChevrons", 0, 0, 1 );
}

// Namespace wm
// Params 1
// Checksum 0xdd235b53, Offset: 0x3b48
// Size: 0x2e
function function_4e58f404ce39689f( spawnpoint )
{
    classname = spawnpoint.classname;
    return issubstr( classname, "mp_wm_spawn" );
}

// Namespace wm
// Params 1
// Checksum 0xd7ded0c7, Offset: 0x3b7f
// Size: 0x2f
function function_88209515f085a131( spawnpoints )
{
    randomindex = randomint( spawnpoints.size );
    randompoint = spawnpoints[ randomindex ];
    return randompoint;
}

// Namespace wm
// Params 0
// Checksum 0x29e7b6a6, Offset: 0x3bb7
// Size: 0x295
function getspawnpoint()
{
    player = self;
    spawnteam = player.pers[ "team" ];
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            spawnlogic::activatespawnset( #"start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers", 2 );
            spawnset = "start_attackers";
        }
        else
        {
            spawnlogic::activatespawnset( #"start_defenders", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders", 2 );
            spawnset = "start_defenders";
        }
    }
    else
    {
        if ( player.pers[ "team" ] == game[ "attackers" ] )
        {
            side = "attackers";
        }
        else
        {
            side = "defenders";
        }
        
        var_7baa51d959d5316c = getdvarint( @"hash_3058503b6794e09b", 0 ) == 1;
        
        if ( var_7baa51d959d5316c && level.var_c1b2b25ae4535459 && isdefined( level.var_8b3d58d597f29613 ) )
        {
            spawnpoint = [[ level.var_8b3d58d597f29613 ]]( player, spawnteam, level.zone.subzones[ side ].spawnset, level.zone.subzones[ side ].fallbackspawnset, 2 );
        }
        else
        {
            spawnpoint = spawnlogic::getspawnpointlegacy( player, spawnteam, level.zone.subzones[ side ].spawnset, level.zone.subzones[ side ].fallbackspawnset, 2 );
        }
        
        spawnset = level.zone.subzones[ side ].spawnset;
    }
    
    if ( !function_4e58f404ce39689f( spawnpoint ) )
    {
        if ( !isdefined( spawnpoint.damagemod ) )
        {
            spawnpoint.damagemod = -1;
        }
        
        script::demoforcesre( "Invalid Spawn Point: " + spawnpoint.classname + " spawn Set: " + spawnset + " index " + spawnpoint.index + " target " + spawnpoint.target + " CritFail: " + spawnpoint.damagemod );
        newspawnpointsarray = level.spawnglobals.spawnsets[ spawnset ];
        spawnpoint = function_88209515f085a131( newspawnpointsarray );
    }
    
    return spawnpoint;
}

// Namespace wm
// Params 1
// Checksum 0xf4f22f03, Offset: 0x3e55
// Size: 0x6f
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    function_2e000bd8537b1aac( self );
    self.var_9b6d5e24d8eed7c4 = 1;
    self.var_e4cb0f341fec0c4e = 0;
    self.var_628b2b310720c69f = undefined;
    function_c4f18802d9b14b7a();
    
    if ( isdefined( self.slidemodel ) )
    {
        self.slidemodel delete();
        self.slidemodel = undefined;
    }
}

// Namespace wm
// Params 1
// Checksum 0x635d724b, Offset: 0x3ecc
// Size: 0x23
function onplayerconnect( player )
{
    player waittill( #"spawned_player" );
    wm_ui::init_obj_tracker( player );
}

// Namespace wm
// Params 1
// Checksum 0xf92b12d2, Offset: 0x3ef7
// Size: 0xe
function function_42d020cd11c48bf7( params )
{
    return params;
}

// Namespace wm
// Params 1
// Checksum 0xea3e6d5d, Offset: 0x3f0e
// Size: 0x4e9
function function_8314535b81f548e( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    objweapon = deathdata.objweapon;
    killid = deathdata.lifeid;
    
    if ( !isplayer( attacker ) || attacker == victim || attacker.team == victim.team )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    if ( !( isdefined( level.zone ) && isdefined( level.zone.objective ) && isdefined( level.zone.objective.objectivetype ) ) )
    {
        return;
    }
    
    ownerteam = undefined;
    attackertouching = 0;
    victimtouching = 0;
    
    if ( isdefined( level.zone.capture_zones ) )
    {
        foreach ( capture_zone in level.zone.capture_zones )
        {
            ownerteam = capture_zone.ownerteam;
            
            if ( !isdefined( ownerteam ) )
            {
                continue;
            }
            
            attackertouching = attacker istouching( capture_zone.trigger );
            victimtouching = victim istouching( capture_zone.trigger );
            
            if ( attackertouching || victimtouching )
            {
                break;
            }
        }
    }
    else if ( level.zone.objective.objectivetype == 6 )
    {
        if ( !isdefined( level.escortvehicles ) )
        {
            return;
        }
        
        ownerteam = game[ "defenders" ];
        
        foreach ( vehicle in level.escortvehicles )
        {
            if ( !isdefined( vehicle.tanknearbyrange ) )
            {
                continue;
            }
            
            rangesq = squared( vehicle.tanknearbyrange );
            attackertouching = distancesquared( attacker.origin, vehicle.origin ) <= rangesq;
            victimtouching = distancesquared( victim.origin, vehicle.origin ) <= rangesq;
            
            if ( attackertouching || victimtouching )
            {
                break;
            }
        }
    }
    else
    {
        return;
    }
    
    if ( !isdefined( ownerteam ) || !attackertouching && !victimtouching )
    {
        return;
    }
    
    if ( attacker.team != ownerteam )
    {
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && attackertouching )
        {
            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
        }
        else if ( victimtouching )
        {
            attacker thread rank::scoreeventpopup( #"assault" );
            attacker events::function_58da673c1c3fc9f2();
            victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
        }
        
        return;
    }
    
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x5b>" );
        
        if ( isdefined( attacker.pers[ "defends" ] ) )
        {
            attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
        }
    }
    
    attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
    attacker stats::setextrascore1( attacker.pers[ "defends" ], "defends" );
}

// Namespace wm
// Params 6
// Checksum 0x313a403f, Offset: 0x43ff
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

/#

    // Namespace wm
    // Params 0
    // Checksum 0xc0a178ae, Offset: 0x444f
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x81>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x8c>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x81>", "<dev string:x9f>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x8c>", "<dev string:x9f>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace wm
// Params 0
// Checksum 0xfb66d17e, Offset: 0x46d9
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace wm
// Params 0
// Checksum 0xf7fe186e, Offset: 0x472f
// Size: 0x80
function seticonnames()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
    level.iconreinforcing = "waypoint_reinforcing";
}

// Namespace wm
// Params 2
// Checksum 0x730597e2, Offset: 0x47b7
// Size: 0x10b
function wmroundend( winnerteam, loserteam )
{
    gamescore::setteamscore( winnerteam, 1 );
    gamescore::setteamscore( loserteam, 0 );
    points::function_40522c040a4e7b1( winnerteam, #"wm_round_win" );
    points::function_40522c040a4e7b1( loserteam, #"wm_round_lose" );
    
    foreach ( player in level.players )
    {
        player.pers[ "secondHalfInitialConnect" ] = 1;
        resetafk( player );
    }
    
    game[ "teamCount" ][ winnerteam ] = teams::getteamdata( loserteam, "teamCount" );
    game[ "teamCount" ][ loserteam ] = teams::getteamdata( winnerteam, "teamCount" );
}

// Namespace wm
// Params 1
// Checksum 0xd9005ae8, Offset: 0x48ca
// Size: 0x1b3
function wmforceteamassignmentoverride( params )
{
    if ( game[ "roundsPlayed" ] && self.pers[ "secondHalfInitialConnect" ] )
    {
        self.pers[ "secondHalfInitialConnect" ] = 0;
        return game_utility_mp::getotherteam( self.pers[ "team" ] );
    }
    
    isprematch = !flags::gameflagexists( "prematch_done" ) || !flags::gameflag( "prematch_done" );
    str = "isPrematch=" + isprematch;
    teamtofill = undefined;
    teamcount = 1000;
    teams = [ game[ "attackers" ], game[ "defenders" ] ];
    
    foreach ( team in teams )
    {
        count = 0;
        
        if ( isprematch )
        {
            count = game[ "teamCount" ][ team ];
        }
        else
        {
            count = teams::getteamdata( team, "teamCount" );
        }
        
        if ( count < teamcount )
        {
            teamtofill = team;
            teamcount = count;
        }
        
        str += " team=" + team + " count=" + count;
    }
    
    if ( isprematch )
    {
        game[ "teamCount" ][ teamtofill ]++;
    }
    
    logstring( "WMForceTeamAssignmentOverride. " + str + " teamToFill=" + teamtofill );
    function_8f66499644d6a058( self, teamtofill );
    return teamtofill;
}

// Namespace wm
// Params 2
// Checksum 0x6a29cdc2, Offset: 0x4a85
// Size: 0x59
function function_8f66499644d6a058( player, team )
{
    olddvar = getdvarint( @"online_allowteamchange", 0 );
    setdvar( @"online_allowteamchange", 1 );
    player menus::setsessionteam( team );
    setdvar( @"online_allowteamchange", olddvar );
}

// Namespace wm
// Params 1
// Checksum 0x6d9e4b9c, Offset: 0x4ae6
// Size: 0x28
function resetafk( player )
{
    player playerlogic::playerhasmoved();
    player.pers[ "distTrackingPassed" ] = 0;
}

// Namespace wm
// Params 0
// Checksum 0x4a7f3f66, Offset: 0x4b16
// Size: 0x45
function function_77f5dbb2603c259()
{
    dialog::leaderdialog( "attackers_won", game[ "attackers" ] );
    wmroundend( game[ "attackers" ], game[ "defenders" ] );
    thread gamelogic_mp::endgame( game[ "attackers" ], game[ "end_reason" ][ "score_limit_reached" ] );
}

// Namespace wm
// Params 0
// Checksum 0xddf3aadd, Offset: 0x4b63
// Size: 0x32
function function_ce3bf7bf55d02545()
{
    wmroundend( game[ "defenders" ], game[ "attackers" ] );
    thread gamelogic_mp::endgame( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace wm
// Params 3
// Checksum 0x8eb831f5, Offset: 0x4b9d
// Size: 0x5b
function function_ae834828ddae8820( timeleft, atkdialog, defdialog )
{
    if ( !isdefined( level.var_e07389f2b16b0867 ) )
    {
        level.var_e07389f2b16b0867 = [];
        level.var_89a304fc199d7919 = 1;
    }
    
    level.var_e07389f2b16b0867[ timeleft ] = [ atkdialog, defdialog ];
}

// Namespace wm
// Params 0
// Checksum 0xf04e63b6, Offset: 0x4c00
// Size: 0x1e2
function function_f1e7581784610aed()
{
    level endon( #"game_ended" );
    level notify( #"hash_8d5ade54e6c98d18" );
    level endon( #"hash_8d5ade54e6c98d18" );
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    clockobject hide();
    targettimesup = [];
    var_4fe7c6fe252a40b9 = [];
    
    foreach ( key, value in level.var_e07389f2b16b0867 )
    {
        targettimesup[ targettimesup.size ] = key;
        var_4fe7c6fe252a40b9[ var_4fe7c6fe252a40b9.size ] = value;
    }
    
    var_3526d85b239ce230 = 0;
    
    while ( true )
    {
        timeleft = gamelogic_mp::gettimeremaining() / 1000;
        timeleftint = int( timeleft + 0.5 );
        
        if ( var_3526d85b239ce230 < targettimesup.size && timeleftint == targettimesup[ var_3526d85b239ce230 ] )
        {
            var_be66ec6bebe9095c = var_4fe7c6fe252a40b9[ var_3526d85b239ce230 ][ 0 ];
            var_c560aad368aa0428 = var_4fe7c6fe252a40b9[ var_3526d85b239ce230 ][ 1 ];
            
            if ( isdefined( var_be66ec6bebe9095c ) )
            {
                dialog::leaderdialog( var_be66ec6bebe9095c, game[ "attackers" ] );
            }
            
            if ( isdefined( var_c560aad368aa0428 ) )
            {
                dialog::leaderdialog( var_c560aad368aa0428, game[ "defenders" ] );
            }
            
            var_3526d85b239ce230++;
        }
        
        if ( timeleftint <= 10 )
        {
            var_1e4609f489ec0c25 = 1;
            
            if ( timeleftint == 0 )
            {
                break;
            }
            
            if ( var_1e4609f489ec0c25 )
            {
                clocksoundalias = gamelogic_mp::getclocksoundaliasfortimeleft( timeleft );
                clockobject playsound( clocksoundalias );
            }
        }
        
        if ( timeleft - floor( timeleft ) >= 0.05 )
        {
            wait timeleft - floor( timeleft );
            continue;
        }
        
        wait 1;
    }
}

// Namespace wm
// Params 0
// Checksum 0x833c17fc, Offset: 0x4dea
// Size: 0xd8
function function_4c3a66465ed7504f()
{
    mapname = game_utility::getmapname();
    war_mode_mission_select = getdvarint( @"hash_89587b7750429c67", 1 );
    
    if ( war_mode_mission_select == 2 )
    {
        mapname = "mp_jup_airstrip";
    }
    
    if ( mapname == "mp_jup_launchfacility" )
    {
        var_78fc361249e5df02 = "dx_mp_mwm1_mode_t141_obin";
        var_b069af161fb57d62 = "dx_mp_mwm1_mode_spet_obid";
        game[ "dialog" ][ "offense_infil" ] = "dx_mp_mwm1_mode_t141_inat";
        game[ "dialog" ][ "defense_infil" ] = "dx_mp_mwm1_mode_spet_inde";
    }
    
    if ( mapname == "mp_jup_dam" )
    {
    }
    
    if ( mapname == "mp_jup_airstrip" )
    {
    }
    
    if ( mapname == "mp_jup_gw_fallout" || mapname == "mp_jup_gw_fallout" )
    {
    }
    
    game[ "dialog" ][ "offense_obj" ] = var_78fc361249e5df02;
    game[ "dialog" ][ "defense_obj" ] = var_b069af161fb57d62;
}

// Namespace wm
// Params 0
// Checksum 0xe19ae624, Offset: 0x4eca
// Size: 0x11
function function_e411ca05d0fbee74()
{
    return getdvarint( @"hash_82f6efcd31660d79", 1 );
}

// Namespace wm
// Params 2
// Checksum 0xe2002a6a, Offset: 0x4ee4
// Size: 0x22
function function_d6b1a87be426068b( zonename, rounds )
{
    return game[ "wm_objective_complete_time_round_" + rounds ][ zonename ];
}

// Namespace wm
// Params 0
// Checksum 0x976f93d0, Offset: 0x4f0f
// Size: 0x2
function sdhack()
{
    
}

// Namespace wm
// Params 0
// Checksum 0x4355a99b, Offset: 0x4f19
// Size: 0x45
function function_9bfc55558d794540()
{
    if ( self.team == game[ "attackers" ] )
    {
        thread dialog::leaderdialogonplayers( level.var_d787a7b192a1705a, [ self ] );
        return;
    }
    
    thread dialog::leaderdialogonplayers( level.var_3752001530d4a6ba, [ self ] );
}

/#

    // Namespace wm
    // Params 0
    // Checksum 0x5953f031, Offset: 0x4f66
    // Size: 0x1c6, Type: dev
    function function_587282b8bfef524a()
    {
        while ( true )
        {
            dvar = getdvarint( @"hash_a77639f0906e8bdf", 0 );
            
            if ( dvar )
            {
                setdvar( @"hash_a77639f0906e8bdf", 0 );
                
                foreach ( objective in level.zone.objectives )
                {
                    level.objectives[ objective ].complete = 1;
                    level.objectives[ objective ] gameobjects::setvisibleteam( "<dev string:x56>" );
                    
                    if ( level.objectives[ objective ].objectivetype == 1 )
                    {
                        level.objectives[ objective ] gameobjects::allowuse( "<dev string:x56>" );
                    }
                }
            }
            
            if ( isdefined( level.objectives ) && level.objectives.size > 0 )
            {
                level.var_8d682bbdb63a8cdf = [];
                
                foreach ( objective in level.objectives )
                {
                    level.var_8d682bbdb63a8cdf[ level.var_8d682bbdb63a8cdf.size ] = objective.objidnum;
                }
            }
            
            waitframe();
        }
    }

#/
