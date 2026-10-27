// script_31480815cca1abbb  (hash_31480815cca1abbb.gscc) (size: 14442 Bytes / 0x386a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe97f45da (3917432282)
// size ...... 14442 (0x386a)
// includes .. 22  (offset: 0x3362)
// strings ... 57  (offset: 0x3412)
// dev strs .. 5   (offset: 0x3822)
// exports ... 30  (offset: 0x217e)
// cseg ...... 0x4b3 + 0x1ccb (0x217e)
// imports ... 109 (offset: 0x262e)
// animtree1 . 0   (offset: 0x386a)
// animtree2 . 0   (offset: 0x386a)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\squads;
#using scripts\mp\teams;
#using scripts\mp\uav_tower;

#namespace fireteam;

// Namespace fireteam
// Params 0
// Checksum 0x7c8c150, Offset: 0x4d1
// Size: 0x44e
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    function_afee02ea1bf7faf4();
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    possiblespawns = getentarray( "cyber_emp_pickup_trig", #targetname );
    level.uavtowerspawnpoints = [];
    
    if ( possiblespawns.size == 0 )
    {
        possiblespawns = getentarray( "flag_primary", #targetname );
        
        foreach ( spawnpoint in possiblespawns )
        {
            if ( spawnpoint.script_label == "_b" )
            {
                possiblespawns = [ spawnpoint ];
                break;
            }
        }
    }
    
    foreach ( loc in possiblespawns )
    {
        index = level.uavtowerspawnpoints.size;
        level.uavtowerspawnpoints[ index ] = spawnstruct();
        level.uavtowerspawnpoints[ index ].origin = utility::drop_to_ground( loc.origin );
        level.uavtowerspawnpoints[ index ].script_index = index;
    }
    
    restocklocs = getentarray( "ammo_restock_location", #targetname );
    level.var_19ece2592f02a8d = [];
    
    foreach ( loc in restocklocs )
    {
        level.var_19ece2592f02a8d[ level.var_19ece2592f02a8d.size ] = utility::drop_to_ground( loc.origin );
    }
    
    function_deaf0b53e4aaff96();
    level.gamemanager = spawnstruct();
    level.var_f5f810e5ea804904 = &function_1cfec6a66be7a620;
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.ondeadevent = &ondeadevent;
    level.ontimelimit = &ontimelimit;
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    hud_message::function_e369cd82a03687e0();
    uav_tower::function_710d24ec8ce5c43b( "capture" );
    thread function_362ae4e678c1b95f();
    setdvar( @"bg_piggybackarmoronnvg", 1 );
    setomnvar( "ui_wincondition", 1 );
    setomnvar( "ui_single_flag_loc", -3 );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"uav_tower_used", &onuavtowerused );
    callback::add( #"uav_tower_spawned", &function_a22c64a49cd0f804 );
    callback::add( #"player_laststand_revived", &onplayerrevived );
    callback::add( #"hash_b3506c95e28fc6c9", &onplayerrevived );
    
    /#
        dev::devcommandwatcher( @"fireteam", &debugfireteam );
    #/
}

// Namespace fireteam
// Params 0, eflags: 0x4
// Checksum 0x4205c30, Offset: 0x927
// Size: 0x79
function private function_deaf0b53e4aaff96()
{
    level.fireteamsettings = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_fireteam" );
    
    if ( !isdefined( level.fireteamsettings ) )
    {
        level.fireteamsettings = spawnstruct();
    }
    
    uavtowerdelay = level.fireteamsettings.uavtowerdelay ?? 0;
    level.fireteamsettings.uavtowerdelay = getdvarfloat( @"hash_b9e00b8bca72d4ed", uavtowerdelay );
}

// Namespace fireteam
// Params 0
// Checksum 0xcc2cca7f, Offset: 0x9a8
// Size: 0xf2
function function_afee02ea1bf7faf4()
{
    system::ignore( #"item_weapon" );
    system::ignore( #"item_killstreak" );
    system::ignore( #"item_generic" );
    system::ignore( #"item_equipment" );
    system::ignore( #"item_inventory" );
    system::ignore( #"item_currency" );
    system::ignore( #"item_revive" );
    system::ignore( #"item_super" );
    system::ignore( #"item_perk" );
    system::ignore( #"item_upgrade" );
    system::ignore( #"item_gasmask" );
    system::ignore( #"item_backpack" );
    system::ignore( #"item_ammo" );
    system::ignore( #"common_cache" );
    system::ignore( #"common_kiosk" );
}

// Namespace fireteam
// Params 0
// Checksum 0x32b67ca9, Offset: 0xaa2
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace fireteam
// Params 0
// Checksum 0x87d856e6, Offset: 0xac2
// Size: 0x15e
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
    
    bradley_spawner::inittankspawns();
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace fireteam
// Params 0
// Checksum 0x8cfcc337, Offset: 0xc28
// Size: 0x8b
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.wincondition = dvars::dvarintvalue( "winCondition", 0, 0, 2 );
    level.uavtowercapturebehaviour = dvars::dvarintvalue( "uavTowerCaptureBehaviour", 4, 0, 4 );
    level.thresholdtimeratio = dvars::dvarintvalue( "thresholdTimeRatio", 2, 1, 5000 );
    level.usetimeincreaselimit = dvars::dvarintvalue( "useTimeIncreaseLimit", 10, 1, 5000 );
    level.timelimitincreaseamount = dvars::dvarintvalue( "timeLimitIncreaseAmount", 10, 1, 5000 );
}

// Namespace fireteam
// Params 0
// Checksum 0x7b771ced, Offset: 0xcbb
// Size: 0xe2
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace fireteam
// Params 0
// Checksum 0x564a3688, Offset: 0xda5
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace fireteam
// Params 1
// Checksum 0x8c3c7439, Offset: 0xdb7
// Size: 0x3c
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
    thread arena::damagewatcher();
}

// Namespace fireteam
// Params 1
// Checksum 0x980e3bc9, Offset: 0xdfb
// Size: 0x21
function onplayerrevived( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_640934ba73e304d6 = 1;
}

// Namespace fireteam
// Params 6
// Checksum 0xa7ba48a6, Offset: 0xe24
// Size: 0x39
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    
}

// Namespace fireteam
// Params 0
// Checksum 0x66ce577e, Offset: 0xe65
// Size: 0x62
function ontimelimit()
{
    if ( level.gameended )
    {
        return;
    }
    
    switch ( level.wincondition )
    {
        case 0:
            function_1901a06ba9dc6610();
            break;
        case 1:
            checkliveswinner();
            break;
        default:
            function_1901a06ba9dc6610();
            break;
    }
}

// Namespace fireteam
// Params 0
// Checksum 0xb016ec67, Offset: 0xecf
// Size: 0x12b
function function_1901a06ba9dc6610()
{
    if ( !isdefined( level.uavtowers ) )
    {
        checkliveswinner();
        return;
    }
    
    var_21003b441285664b = [];
    currentbest = -1;
    winningteam = undefined;
    
    foreach ( uavtower in level.uavtowers )
    {
        activeteam = uavtower.uav_station.var_2c096d7520fb291a;
        
        if ( !isdefined( activeteam ) )
        {
            continue;
        }
        
        if ( !isdefined( var_21003b441285664b[ activeteam ] ) )
        {
            var_21003b441285664b[ activeteam ] = 0;
        }
        
        var_21003b441285664b[ activeteam ]++;
        
        if ( var_21003b441285664b[ activeteam ] > currentbest )
        {
            currentbest = var_21003b441285664b[ activeteam ];
            winningteam = activeteam;
        }
    }
    
    if ( !isdefined( winningteam ) )
    {
        checkliveswinner();
        return;
    }
    
    thread arena_endgame( winningteam, game[ "end_reason" ][ "ko_flag_hold_win" ], game[ "end_reason" ][ "ko_flag_hold_loss" ] );
}

// Namespace fireteam
// Params 0
// Checksum 0xf863aacd, Offset: 0x1002
// Size: 0xef
function checkliveswinner()
{
    if ( teams::getteamdata( "allies", "aliveCount" ) > teams::getteamdata( "axis", "aliveCount" ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "allies", game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "arena_time_lives_loss" ] );
        return;
    }
    
    if ( teams::getteamdata( "axis", "aliveCount" ) > teams::getteamdata( "allies", "aliveCount" ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "axis", game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "arena_time_lives_loss" ] );
        return;
    }
    
    checkhealthwinner();
}

// Namespace fireteam
// Params 0
// Checksum 0xa7cdca97, Offset: 0x10f9
// Size: 0x234
function checkhealthwinner()
{
    axishealth = teams::function_ca2fe741546df07d( "axis" );
    allieshealth = teams::function_ca2fe741546df07d( "allies" );
    
    if ( axishealth < allieshealth )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "allies", game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ] );
        return;
    }
    
    if ( allieshealth < axishealth )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "axis", game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ] );
        return;
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        if ( isintournament() )
        {
            game[ "canScoreOnTie" ] = 1;
            
            if ( game[ "finalRound" ] == 1 )
            {
                game[ "canScoreOnTie" ] = 0;
                
                if ( !isdefined( game[ "roundsTied" ] ) )
                {
                    game[ "roundsTied" ] = 1;
                }
                else
                {
                    game[ "roundsTied" ]++;
                }
                
                if ( game[ "roundsTied" ] >= 2 )
                {
                    betterteam = gamelogic_mp::getbetterteam();
                    thread gamelogic_mp::endgame( betterteam, game[ "end_reason" ][ "arena_tournament_tie_win" ], game[ "end_reason" ][ "arena_tournament_tie_loss" ] );
                }
                else
                {
                    thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
                }
            }
            else
            {
                thread arena_endgame( "tie", game[ "end_reason" ][ "cyber_tie" ] );
            }
        }
        else
        {
            if ( !isdefined( game[ "roundsTied" ] ) )
            {
                game[ "roundsTied" ] = 1;
            }
            else
            {
                game[ "roundsTied" ]++;
            }
            
            game[ "canScoreOnTie" ] = game[ "roundsTied" ] >= 2;
            
            if ( game[ "canScoreOnTie" ] )
            {
                thread arena_endgame( "tie", game[ "end_reason" ][ "cyber_tie" ] );
            }
            else
            {
                thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
            }
        }
        
        return;
    }
    
    thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace fireteam
// Params 1
// Checksum 0x302b13ec, Offset: 0x1335
// Size: 0xc
function onplayerconnect( params )
{
    
}

// Namespace fireteam
// Params 1
// Checksum 0xca5e10d5, Offset: 0x1349
// Size: 0xc
function onplayerdisconnect( params )
{
    
}

// Namespace fireteam
// Params 1
// Checksum 0x94eb33c3, Offset: 0x135d
// Size: 0xc
function onplayerkilled( deathdata )
{
    
}

// Namespace fireteam
// Params 1
// Checksum 0x16de8a9e, Offset: 0x1371
// Size: 0x6e
function ondeadevent( team )
{
    if ( level.ingraceperiod )
    {
        return;
    }
    
    if ( team == game[ "attackers" ] )
    {
        level thread arena_endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        level thread arena_endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace fireteam
// Params 5
// Checksum 0x8b2da149, Offset: 0x13e7
// Size: 0x8f
function arena_endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    if ( winningteam != "tie" )
    {
        if ( level.nukeinfo.incoming )
        {
            return;
        }
        
        waittillframeend();
        winningteam = arena::checkshouldallowtradekilltie( winningteam );
    }
    
    if ( winningteam != "tie" )
    {
        game[ "roundsTied" ] = 0;
        gamescore::giveteamscoreforobjective( winningteam, 1, 1, undefined, 1 );
    }
    
    thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
}

/#

    // Namespace fireteam
    // Params 0
    // Checksum 0x1aed6183, Offset: 0x147e
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x24>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x2f>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x24>", "<dev string:x42>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x2f>", "<dev string:x42>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace fireteam
// Params 0
// Checksum 0x212ac853, Offset: 0x1708
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace fireteam
// Params 0
// Checksum 0x76b984, Offset: 0x175e
// Size: 0xb
function function_1cfec6a66be7a620()
{
    return level.uavtowerspawnpoints;
}

// Namespace fireteam
// Params 1
// Checksum 0xeee5ccb5, Offset: 0x1772
// Size: 0x34
function function_a22c64a49cd0f804( params )
{
    instance = params.instance;
    
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    instance thread function_3d754ee8a66b92f2();
}

// Namespace fireteam
// Params 0, eflags: 0xc
// Checksum 0x5e317d00, Offset: 0x17ae
// Size: 0x1f7
function private function_3d754ee8a66b92f2()
{
    self notify( #"hash_4ae20aed0249e7ae" );
    self endon( #"hash_4ae20aed0249e7ae" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.fireteamsettings.uavtowerdelay ) || level.fireteamsettings.uavtowerdelay <= 0 )
    {
        return;
    }
    
    uav_tower::function_59ad13ac6dc2a221( self, "none" );
    level waittill( #"matchstarttimer_done" );
    hud_message::function_caacf001c8e4e6e7( 1, level.fireteamsettings.uavtowerdelay );
    lockedtime = level.fireteamsettings.uavtowerdelay;
    var_399ab9e5681a034b = getdvarfloat( @"hash_3779c9723b0a4962", 10 );
    
    if ( level.fireteamsettings.uavtowerdelay > var_399ab9e5681a034b )
    {
        lockedtime = var_399ab9e5681a034b;
        wait level.fireteamsettings.uavtowerdelay - var_399ab9e5681a034b;
    }
    
    self.capturezone gameobjects::setobjectivestatusicons( level.iconlocked );
    capturestring = gameobjects::getwaypointstring( level.iconlocked + self.capturezone.trigger.objectivekey );
    objective_setlabel( self.capturezone.objidnum, capturestring );
    self.capturezone gameobjects::setvisibleteam( "any" );
    self.capturezone.lockupdatingicons = 1;
    self.capturezone thread gameobjects::function_d7321ef757ecefd7( lockedtime );
    wait lockedtime;
    self.capturezone.lockupdatingicons = undefined;
    uav_tower::function_59ad13ac6dc2a221( self, "inactive" );
    objidpoolmanager::objective_show_progress( self.capturezone.objidnum, 0 );
    hud_message::function_caacf001c8e4e6e7( 0, 0 );
}

// Namespace fireteam
// Params 1
// Checksum 0x9e936ea3, Offset: 0x19ad
// Size: 0xc5
function onuavtowerused( params )
{
    player = params.player;
    instance = params.instance;
    
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    if ( level.wincondition == 0 )
    {
        hud_message::function_fc3ef76206896f0e( player.team );
    }
    
    level thread hud_message::notifyteam( "fireteam_uav_captured_friendly", "fireteam_uav_captured_enemy", player.team );
    setremainingtime( player, instance );
    
    if ( !isdefined( instance.usecount ) )
    {
        instance.usecount = 0;
    }
    
    instance.usecount++;
    instance.var_2c096d7520fb291a = player.team;
}

// Namespace fireteam
// Params 2, eflags: 0x4
// Checksum 0x191547ec, Offset: 0x1a7a
// Size: 0x1e1
function private setremainingtime( player, instance )
{
    timepassed = game_utility::gettimepassed() / 1000;
    currenttimeremaining = gamelogic_mp::gettimeremaining() / 1000;
    
    switch ( level.uavtowercapturebehaviour )
    {
        case 0:
            timeremaining = instance.uptime ?? level.toweruptime;
            break;
        case 1:
            if ( !instance.usecount )
            {
                timeremaining = instance.uptime ?? level.toweruptime;
            }
            else
            {
                timeremaining = int( ( instance.uptime ?? level.toweruptime ) / level.thresholdtimeratio );
                
                if ( currenttimeremaining >= timeremaining )
                {
                    return;
                }
            }
            
            break;
        case 2:
            if ( instance.usecount )
            {
                return;
            }
            
            timeremaining = instance.uptime ?? level.toweruptime;
            break;
        case 3:
            if ( !instance.usecount )
            {
                timeremaining = instance.uptime ?? level.toweruptime;
            }
            else if ( instance.usecount < 10 )
            {
                timeremaining = ( instance.uptime ?? level.toweruptime ) + 10;
                timeremaining = int( clamp( timeremaining, 0, instance.uptime ) );
            }
            
            break;
        case 4:
            return;
        default:
            timeremaining = instance.uptime ?? level.toweruptime;
            break;
    }
    
    level.timelimit = timeremaining + timepassed;
}

// Namespace fireteam
// Params 0
// Checksum 0xdec41b4c, Offset: 0x1c63
// Size: 0x369
function function_362ae4e678c1b95f()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( level.var_19ece2592f02a8d.size >= 2 )
    {
        for ( i = 0; i < 2 ; i++ )
        {
            restockstation = spawnscriptable( "military_ammo_restock_noent", level.var_19ece2592f02a8d[ i ] );
            restockstation setscriptablepartstate( "military_ammo_restock", "useable_on_armor" );
        }
        
        return;
    }
    
    utility::flag_wait( "uav_towers_created" );
    
    if ( !isdefined( level.uavtowers ) )
    {
        return;
    }
    
    var_a441491413250691 = function_1cfec6a66be7a620();
    
    foreach ( uavtower in level.uavtowers )
    {
        var_6be3a9165d5d72cc = undefined;
        
        foreach ( index, spawnloc in var_a441491413250691 )
        {
            if ( distance2d( spawnloc.origin, uavtower.uav_station.origin ) < 1 )
            {
                var_6be3a9165d5d72cc = index;
                break;
            }
        }
        
        if ( isdefined( var_6be3a9165d5d72cc ) )
        {
            var_a441491413250691[ var_6be3a9165d5d72cc ] = undefined;
        }
    }
    
    if ( var_a441491413250691.size <= 1 )
    {
        spawnpos = level.uavtowers[ 0 ].origin;
        var_5da2cdd978f31be3 = ( 700, 0, 0 );
        box1 = { #origin:getclosestpointonnavmesh( spawnpos + var_5da2cdd978f31be3 ) };
        box2 = { #origin:getclosestpointonnavmesh( spawnpos + var_5da2cdd978f31be3 * -1 ) };
        var_a441491413250691 = [ box1, box2 ];
    }
    else
    {
        foreach ( loc in var_a441491413250691 )
        {
            loc.origin = utility::drop_to_ground( loc.origin );
        }
    }
    
    numboxes = 0;
    
    foreach ( loc in var_a441491413250691 )
    {
        if ( numboxes >= 2 )
        {
            break;
        }
        
        restockstation = spawnscriptable( "military_ammo_restock_noent", loc.origin );
        restockstation setscriptablepartstate( "military_ammo_restock", "useable_on_armor" );
    }
}

/#

    // Namespace fireteam
    // Params 2, eflags: 0x4
    // Checksum 0x37458622, Offset: 0x1fd4
    // Size: 0x1aa, Type: dev
    function private debugfireteam( command, args )
    {
        host = level.players[ 0 ];
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        switch ( command )
        {
            case #"hash_4c53c7fb0dd13246":
            case #"hash_9fde433d266b157d":
                friendly = command == "<dev string:x54>";
                
                foreach ( player in level.players )
                {
                    if ( friendly && player.team == host.team )
                    {
                        player dodamage( 10000, player.origin, host, host );
                        continue;
                    }
                    
                    if ( !friendly && player.team != host.team )
                    {
                        player dodamage( 10000, player.origin, host, host );
                    }
                }
                
                break;
            case #"hash_19b3821587336857":
                level.wincondition = int( args[ 0 ] );
                break;
            case #"hash_c3b92ce9cb338ec5":
                level.uavtowercapturebehaviour = int( args[ 0 ] );
                break;
            default:
                iprintlnbold( "<dev string:x8d>" + command );
                break;
        }
    }

#/
