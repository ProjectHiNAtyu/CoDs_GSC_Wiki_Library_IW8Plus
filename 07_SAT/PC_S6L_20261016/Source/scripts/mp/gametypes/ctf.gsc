// scripts\mp\gametypes\ctf.gsc  (hash_5790940b26492c4b.gscc) (size: 32323 Bytes / 0x7e43 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1290ce7b (311479931)
// size ...... 32323 (0x7e43)
// includes .. 31  (offset: 0x71af)
// strings ... 132 (offset: 0x72a7)
// dev strs .. 3   (offset: 0x7e07)
// exports ... 54  (offset: 0x4f57)
// cseg ...... 0x9a8 + 0x45af (0x4f57)
// imports ... 199 (offset: 0x57c7)
// animtree1 . 0   (offset: 0x7e43)
// animtree2 . 0   (offset: 0x7e43)
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace ctf;

// Namespace ctf
// Params 0
// Checksum 0xa752c68f, Offset: 0x9c6
// Size: 0x252
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    flag_default_origins();
    allowed[ 0 ] = "ctf";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    
    if ( level.winrule )
    {
        level.wingamebytype = "teamScores";
    }
    else
    {
        level.wingamebytype = "roundsWon";
    }
    
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.objectivebased = 1;
    level.overtimescorewinoverride = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onmaprestart = &function_7666cbd65a14566;
    level.spawnnodetype = "mp_ctf_spawn";
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_mpcf_mode_uktl_cft1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "gametype_ctf";
    }
    
    game[ "dialog" ][ "boost" ] = "boost_ctf";
    game[ "dialog" ][ "offense_obj" ] = "boost_ctf";
    game[ "dialog" ][ "defense_obj" ] = "boost_ctf";
    game[ "dialog" ][ "flag_taken" ] = "ourflag_taken";
    game[ "dialog" ][ "flag_dropped" ] = "ourflag_drop";
    game[ "dialog" ][ "flag_returned" ] = "ourflag_return";
    game[ "dialog" ][ "flag_captured" ] = "ourflag_capt";
    game[ "dialog" ][ "flag_getback" ] = "ourflag_getback";
    game[ "dialog" ][ "enemy_flag_bringhome" ] = "enemyflag_tobase";
    game[ "dialog" ][ "enemy_flag_taken" ] = "enemyflag_taken";
    game[ "dialog" ][ "enemy_flag_dropped" ] = "enemyflag_drop";
    game[ "dialog" ][ "enemy_flag_returned" ] = "enemyflag_return";
    game[ "dialog" ][ "enemy_flag_captured" ] = "enemyflag_capt";
    setomnvar( "ui_ctf_flag_axis", -2 );
    setomnvar( "ui_ctf_flag_allies", -2 );
}

// Namespace ctf
// Params 0
// Checksum 0xba866642, Offset: 0xc20
// Size: 0xcd
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_ctf_winrule", getmatchrulesdata( "ctfData", "winRule" ) );
    setdynamicdvar( @"scr_ctf_capturecondition", getmatchrulesdata( "ctfData", "captureCondition" ) );
    setdynamicdvar( @"scr_ctf_returntime", getmatchrulesdata( "ctfData", "returnTime" ) );
    setdynamicdvar( @"scr_ctf_showenemycarrier", getmatchrulesdata( "carryData", "showEnemyCarrier" ) );
    setdynamicdvar( @"scr_ctf_idleresettime", getmatchrulesdata( "carryData", "idleResetTime" ) );
    setdynamicdvar( @"scr_ctf_pickuptime", getmatchrulesdata( "carryData", "pickupTime" ) );
    setdynamicdvar( @"hash_82f42dfd88cbacad", getmatchrulesdata( "carryData", "manualDropEnabled" ) );
}

// Namespace ctf
// Params 1
// Checksum 0x50030642, Offset: 0xcf5
// Size: 0x13
function onspawnplayer( revivespawn )
{
    updatematchstatushintonnoflag();
}

// Namespace ctf
// Params 0
// Checksum 0x1b47b374, Offset: 0xd10
// Size: 0x22c
function onstartgametype()
{
    inot = game_utility_mp::inovertime();
    var_945ecc8070842f89 = game[ "overtimeRoundsPlayed" ] == 0;
    var_206bd119e871f566 = game_utility_mp::istimetobeatvalid();
    
    if ( inot )
    {
        if ( var_945ecc8070842f89 )
        {
            setomnvar( "ui_round_hint_override_attackers", 1 );
            setomnvar( "ui_round_hint_override_defenders", 1 );
        }
        else if ( var_206bd119e871f566 )
        {
            setomnvar( "ui_round_hint_override_attackers", game[ "timeToBeatTeam" ] == game[ "attackers" ] ? 2 : 3 );
            setomnvar( "ui_round_hint_override_defenders", game[ "timeToBeatTeam" ] == game[ "defenders" ] ? 2 : 3 );
        }
        else
        {
            setomnvar( "ui_round_hint_override_attackers", 4 );
            setomnvar( "ui_round_hint_override_defenders", 4 );
        }
    }
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( !isdefined( game[ "original_defenders" ] ) )
    {
        game[ "original_defenders" ] = game[ "defenders" ];
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    setclientnamemode( "auto_change" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives_one_flag_attacker" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives_one_flag_defender" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives_one_flag_attacker_score" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives_one_flag_defender_score" );
    }
    
    game_utility_mp::setobjectivetext( game[ "attackers" ], &"objectives/ctf" );
    game_utility_mp::setobjectivetext( game[ "defenders" ], &"objectives/ctf" );
    game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives_one_flag_attacker_hint" );
    game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives_one_flag_defender_hint" );
    flag_setupvfx();
    createflagsandhud();
    initspawns();
    
    /#
        thread function_e615ba0771243a67();
    #/
    
    thread removeflag();
    thread placeflag();
}

// Namespace ctf
// Params 0
// Checksum 0x8983f750, Offset: 0xf44
// Size: 0x9c
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.winrule = dvars::dvarintvalue( "winRule", 0, 0, 1 );
    level.showenemycarrier = dvars::dvarintvalue( "showEnemyCarrier", 5, 0, 6 );
    level.idleresettime = dvars::dvarfloatvalue( "idleResetTime", 30, 0, 60 );
    level.capturecondition = dvars::dvarintvalue( "captureCondition", 0, 0, 1 );
    level.pickuptime = dvars::dvarfloatvalue( "pickupTime", 0, 0, 10 );
    level.returntime = dvars::dvarfloatvalue( "returnTime", 0, -1, 25 );
}

// Namespace ctf
// Params 0
// Checksum 0xdcb0ad9a, Offset: 0xfe8
// Size: 0x1cd
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
    setupwaypointicons();
    level.iconescort = "waypoint_escort_flag";
    level.iconkill = "waypoint_ctf_kill";
    level.iconcaptureflag = "waypoint_take_flag";
    level.icondefendflag = "waypoint_defend_flag";
    level.iconreturnflag = "waypoint_recover_flag";
    level.teamflags[ game[ "defenders" ] ] = createteamflag( game[ "defenders" ], "axis" );
    level.teamflags[ game[ "attackers" ] ] = createteamflag( game[ "attackers" ], "allies" );
    level.capzones[ game[ "defenders" ] ] = createcapzone( game[ "defenders" ], "axis" );
    level.capzones[ game[ "attackers" ] ] = createcapzone( game[ "attackers" ], "allies" );
    objidpoolmanager::function_1f589e274283d14a( level.capzones[ game[ "defenders" ] ].objidnum, 1 );
    objidpoolmanager::function_1f589e274283d14a( level.capzones[ game[ "attackers" ] ].objidnum, 1 );
}

// Namespace ctf
// Params 0
// Checksum 0x7383e1ad, Offset: 0x11bd
// Size: 0x2
function flag_setupvfx()
{
    
}

// Namespace ctf
// Params 0
// Checksum 0xebcc3f26, Offset: 0x11c7
// Size: 0x169
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    level.var_f1086140706e9fff = spawnlogic::function_5cf82e30c52a895d( spawnkey );
    
    if ( level.var_f1086140706e9fff )
    {
        spawnlogic::function_c87bd865d7b44cd0( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_ctf_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_ctf_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_ctf_spawn" );
        assignteamspawns( level.var_f1086140706e9fff, spawnkey, "spawn" );
        level.ctfteamspawnsetids[ "allies" ] = #"primary_allies";
        level.ctfteamspawnsetids[ "axis" ] = #"primary_axis";
        spawnlogic::registerspawnset( #"primary_allies", level.teamspawnpoints[ "allies" ] );
        spawnlogic::registerspawnset( #"primary_axis", level.teamspawnpoints[ "axis" ] );
        spawnlogic::registerspawnset( #"primary_neutral", level.teamspawnpoints[ "neutral" ] );
    }
    
    spawnlogic::finalizemap();
}

// Namespace ctf
// Params 3
// Checksum 0xf1ffda57, Offset: 0x1338
// Size: 0x489
function assignteamspawns( var_42296faa8a94a332, spawnkey, spawnvalue )
{
    if ( var_42296faa8a94a332 )
    {
        spawnpoints = spawnlogic::function_491fcfcdc1232e11( spawnkey, spawnvalue );
    }
    else
    {
        spawnpoints = spawnlogic::getspawnpointarray( level.spawnnodetype );
    }
    
    ispathdataavailable = spawnlogic::ispathdataavailable();
    level.teamspawnpoints[ "axis" ] = [];
    level.teamspawnpoints[ "allies" ] = [];
    level.teamspawnpoints[ "neutral" ] = [];
    
    if ( level.teamflags.size == 2 )
    {
        flaga = level.teamflags[ "allies" ];
        flagb = level.teamflags[ "axis" ];
        var_342491f3b2745a03 = ( flaga.curorigin[ 0 ], flaga.curorigin[ 1 ], 0 );
        var_9b628f393bfe7da = ( flagb.curorigin[ 0 ], flagb.curorigin[ 1 ], 0 );
        flagdelta = var_9b628f393bfe7da - var_342491f3b2745a03;
        flagdist = length2d( flagdelta );
        
        foreach ( spawnpoint in spawnpoints )
        {
            spawnpointorigin2d = ( spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], 0 );
            var_77000a400372dd95 = spawnpointorigin2d - var_342491f3b2745a03;
            dotvalue = vectordot( var_77000a400372dd95, flagdelta );
            var_5c113a3163df32c9 = dotvalue / flagdist * flagdist;
            
            if ( var_5c113a3163df32c9 < 0.33 )
            {
                spawnpoint.teambase = team_utility::getotherteam( flaga.ownerteam );
                level.teamspawnpoints[ spawnpoint.teambase ][ level.teamspawnpoints[ spawnpoint.teambase ].size ] = spawnpoint;
                continue;
            }
            
            if ( var_5c113a3163df32c9 > 0.67 )
            {
                spawnpoint.teambase = team_utility::getotherteam( flagb.ownerteam );
                level.teamspawnpoints[ spawnpoint.teambase ][ level.teamspawnpoints[ spawnpoint.teambase ].size ] = spawnpoint;
                continue;
            }
            
            var_693fcd8c01627e17 = undefined;
            var_c934a44718a296e = undefined;
            
            if ( ispathdataavailable )
            {
                var_693fcd8c01627e17 = distance( spawnpoint.origin, flaga.curorigin );
            }
            
            if ( isdefined( var_693fcd8c01627e17 ) && var_693fcd8c01627e17 != -1 )
            {
                var_c934a44718a296e = distance( spawnpoint.origin, flagb.curorigin );
            }
            
            if ( !isdefined( var_c934a44718a296e ) || var_c934a44718a296e == -1 )
            {
                var_693fcd8c01627e17 = distance2d( flaga.curorigin, spawnpoint.origin );
                var_c934a44718a296e = distance2d( flagb.curorigin, spawnpoint.origin );
            }
            
            var_aeb5bfe4a587beee = max( var_693fcd8c01627e17, var_c934a44718a296e );
            var_a653d736f4316c82 = min( var_693fcd8c01627e17, var_c934a44718a296e );
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
        spawnpoint.teambase = getnearestflagteam( spawnpoint );
        
        if ( spawnpoint.teambase == "axis" )
        {
            level.teamspawnpoints[ "axis" ][ level.teamspawnpoints[ "axis" ].size ] = spawnpoint;
            continue;
        }
        
        level.teamspawnpoints[ "allies" ][ level.teamspawnpoints[ "allies" ].size ] = spawnpoint;
    }
}

// Namespace ctf
// Params 1
// Checksum 0x8ec98803, Offset: 0x17c9
// Size: 0x122
function getnearestflagteam( spawnpoint )
{
    ispathdataavailable = spawnlogic::ispathdataavailable();
    nearestflag = undefined;
    nearestdist = undefined;
    
    foreach ( flag in level.teamflags )
    {
        dist = undefined;
        
        if ( ispathdataavailable )
        {
            dist = distance( spawnpoint.origin, flag.curorigin );
        }
        
        if ( !isdefined( dist ) || dist == -1 )
        {
            dist = distancesquared( flag.curorigin, spawnpoint.origin );
        }
        
        if ( !isdefined( nearestflag ) || dist < nearestdist )
        {
            nearestflag = flag;
            nearestdist = dist;
        }
    }
    
    return team_utility::getotherteam( nearestflag.ownerteam );
}

// Namespace ctf
// Params 0
// Checksum 0xca7c2bdc, Offset: 0x18f4
// Size: 0x7c
function getspawnpoint()
{
    if ( level.var_f1086140706e9fff )
    {
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    spawnteam = self.pers[ "team" ];
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        spawnpoint = spawnlogic::getspawnpoint( self, spawnteam, #"start", undefined );
    }
    else
    {
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, level.ctfteamspawnsetids[ spawnteam ], #"primary_neutral" );
    }
    
    return spawnpoint;
}

// Namespace ctf
// Params 0
// Checksum 0xae43e4d3, Offset: 0x1979
// Size: 0x130
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
    
    foreach ( flag in level.flags )
    {
        switch ( flag.script_label )
        {
            case #"hash_fac2c5f6bddd49bd":
                level.default_flag_origins[ game[ "attackers" ] ] = flag.origin;
                break;
            case #"hash_fac2c3f6bddd4697":
                level.default_flag_origins[ game[ "defenders" ] ] = flag.origin;
                break;
        }
    }
}

// Namespace ctf
// Params 1
// Checksum 0x71a02249, Offset: 0x1ab1
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
    goal.radius = 30;
    goal.team = team;
    goal.ball_in_goal = 0;
    goal.highestspawndistratio = 0;
    return goal;
}

// Namespace ctf
// Params 1
// Checksum 0xba6f46a7, Offset: 0x1b54
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

// Namespace ctf
// Params 3
// Checksum 0xea0a538, Offset: 0x1c12
// Size: 0x10d
function showflagradiuseffecttoplayers( team, player, position )
{
    if ( isdefined( player._flagradiuseffect[ team ] ) )
    {
        player._flagradiuseffect[ team ] delete();
    }
    
    viewerteam = player.team;
    iscodcaster = player iscodcaster();
    
    if ( iscodcaster )
    {
        viewerteam = player getcodcasterteam();
    }
    else if ( viewerteam == "spectator" )
    {
        viewerteam = "allies";
    }
    
    if ( viewerteam == team )
    {
        var_e78eae6f55d168bf = spawnfxforclient( level.flagradiusfxid[ "friendly" ], position, player, ( 0, 0, 1 ) );
        var_e78eae6f55d168bf setfxkilldefondelete();
    }
    else
    {
        var_e78eae6f55d168bf = spawnfxforclient( level.flagradiusfxid[ "enemy" ], position, player, ( 0, 0, 1 ) );
        var_e78eae6f55d168bf setfxkilldefondelete();
    }
    
    player._flagradiuseffect[ team ] = var_e78eae6f55d168bf;
    triggerfx( var_e78eae6f55d168bf );
}

// Namespace ctf
// Params 2
// Checksum 0xb4d9f1b, Offset: 0x1d27
// Size: 0x10c
function showbaseeffecttoplayer( team, player )
{
    if ( isdefined( player._flageffect[ team ] ) )
    {
        player._flageffect[ team ] delete();
    }
    
    viewerteam = player.team;
    iscodcaster = player iscodcaster();
    
    if ( iscodcaster )
    {
        viewerteam = player getcodcasterteam();
    }
    else if ( viewerteam == "spectator" )
    {
        viewerteam = "allies";
    }
    
    if ( viewerteam == team )
    {
        var_e78eae6f55d168bf = spawnfxforclient( level.flagbaseglowfxid[ "friendly" ], self.origin, player, self.baseeffectforward );
        var_e78eae6f55d168bf setfxkilldefondelete();
    }
    else
    {
        var_e78eae6f55d168bf = spawnfxforclient( level.flagbaseglowfxid[ "enemy" ], self.origin, player, self.baseeffectforward );
        var_e78eae6f55d168bf setfxkilldefondelete();
    }
    
    player._flageffect[ team ] = var_e78eae6f55d168bf;
    triggerfx( var_e78eae6f55d168bf );
}

// Namespace ctf
// Params 1
// Checksum 0x930883e4, Offset: 0x1e3b
// Size: 0x88
function removeflagpickupradiuseffect( flagteam )
{
    if ( flagteam == self.team )
    {
        if ( isdefined( self._flagradiuseffect[ self.team ] ) )
        {
            self._flagradiuseffect[ self.team ] delete();
        }
        
        return;
    }
    
    if ( isdefined( self._flagradiuseffect[ team_utility::getotherteam( self.team ) ] ) )
    {
        self._flagradiuseffect[ team_utility::getotherteam( self.team ) ] delete();
    }
}

// Namespace ctf
// Params 1
// Checksum 0xbe38153f, Offset: 0x1ecb
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

// Namespace ctf
// Params 1
// Checksum 0x32d269e0, Offset: 0x1f12
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

// Namespace ctf
// Params 1
// Checksum 0x59c7d3fe, Offset: 0x1fa2
// Size: 0x52
function getflagpos( team )
{
    ent = getent( "ctf_flag_" + team, #targetname );
    assert( isdefined( ent ) && isdefined( ent.origin ) );
    return ent.origin;
}

// Namespace ctf
// Params 2
// Checksum 0xbf739189, Offset: 0x1ffd
// Size: 0x661
function createteamflag( team, entityteam )
{
    var_ef5a1de456a59530 = 0;
    trigger = getent( "ctf_zone_" + entityteam, #targetname );
    
    if ( !isdefined( trigger ) )
    {
        flaggoal = flag_create_team_goal( team );
        trigger = spawn( "trigger_radius", flaggoal.origin - ( 0, 0, flaggoal.radius / 2 ), 0, flaggoal.radius, 80 );
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
    
    if ( getdvarint( @"hash_82f42dfd88cbacad" ) != 0 )
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

// Namespace ctf
// Params 1
// Checksum 0x9a97c46b, Offset: 0x2667
// Size: 0x15, Type: bool
function flagpickupchecks( player )
{
    return !player vehicle::is_in_vehicle();
}

// Namespace ctf
// Params 2
// Checksum 0x9e923730, Offset: 0x2685
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

// Namespace ctf
// Params 2
// Checksum 0xde7ced6c, Offset: 0x2754
// Size: 0x1ab
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
        trigger.height = 80;
    }
    
    clonetrigger = spawn( "trigger_radius", trigger.origin, 0, 15, trigger.height );
    trigger = clonetrigger;
    visuals = [];
    capzone = gameobjects::createuseobject( team, trigger, visuals, ( 0, 0, 85 ) );
    capzone gameobjects::allowuse( "friendly" );
    capzone gameobjects::setvisibleteam( "any" );
    capzone gameobjects::setobjectivestatusallicons( level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag );
    capzone gameobjects::setusetime( 0 );
    capzone gameobjects::setkeyobject( level.teamflags[ team_utility::getotherteam( team ) ] );
    capzone.onuse = &onuse;
    capzone.oncantuse = &oncantuse;
    return capzone;
}

// Namespace ctf
// Params 1
// Checksum 0xddbdd1cb, Offset: 0x2908
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

// Namespace ctf
// Params 3
// Checksum 0x11d23a86, Offset: 0x297c
// Size: 0x3b
function onenduse( player, team, success )
{
    self.trigger.radius = self.oldradius;
}

// Namespace ctf
// Params 3
// Checksum 0x1f933306, Offset: 0x29bf
// Size: 0x692
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
    
    team = player.pers[ "team" ];
    otherteam = team_utility::getotherteam( team );
    
    if ( team != ownerteam )
    {
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
        telemetry_data = spawnstruct();
        telemetry_data.player = player;
        telemetry_data.eventname = "obj_return";
        telemetry_data.position = player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        print::printandsoundoneveryone( team, team_utility::getotherteam( team ), undefined, undefined, "mp_obj_returned", "mp_obj_returned", player );
        dialog::leaderdialog( "enemy_flag_returned", otherteam, "status" );
        dialog::leaderdialog( "flag_returned", team, "status" );
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
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "pickups" ] ) )
        {
            player.pers[ "pickups" ] = player.pers[ "pickups" ] + 1;
        }
    }
    
    level.closecapturekiller[ otherteam ] = undefined;
    
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
            objective_icon( self.pingobjidnum, "icon_waypoint_kill" );
            objidpoolmanager::function_4b37488488e7d007( self.pingobjidnum, 1 );
        }
    }
    
    gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    
    if ( level.capturecondition == 0 )
    {
        level.capzones[ otherteam ] gameobjects::allowuse( "none" );
    }
    
    level.capzones[ otherteam ] gameobjects::setvisibleteam( "none" );
    print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player );
    dialog::leaderdialog( "enemy_flag_taken", team );
    dialog::leaderdialog( "flag_getback", otherteam );
    thread hud_util::teamplayercardsplash( "callout_flagpickup", player );
    
    if ( self.previouscarrier != player )
    {
        player thread points::doscoreevent( #"flag_grab" );
    }
    
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
    
    player thread superabilitywatcher();
}

// Namespace ctf
// Params 1
// Checksum 0x8925dfc2, Offset: 0x3059
// Size: 0xc
function onpickupfailed( player )
{
    
}

// Namespace ctf
// Params 0
// Checksum 0xbeee553, Offset: 0x306e
// Size: 0x9
function returnflag()
{
    gameobjects::returnhome();
}

// Namespace ctf
// Params 1
// Checksum 0xd9c883f2, Offset: 0x307f
// Size: 0x24e
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
            player.carryobject.previouscarrier = undefined;
        }
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        print::printandsoundoneveryone( otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player );
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
    }
    else
    {
        sound::playsoundonplayers( "iw9_mp_ui_objective_lost", otherteam );
    }
    
    dialog::leaderdialog( "enemy_flag_dropped", self.originalownerteam, "status" );
    dialog::leaderdialog( "flag_dropped", team_utility::getotherteam( self.originalownerteam ), "status" );
    
    if ( level.idleresettime > 0 )
    {
        thread returnaftertime();
    }
}

// Namespace ctf
// Params 0
// Checksum 0xb866f925, Offset: 0x32d5
// Size: 0x97
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
    
    team = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    sound::playsoundonplayers( "iw9_mp_ui_objective_taken", team );
    sound::playsoundonplayers( "iw9_mp_ui_objective_lost", otherteam );
    gameobjects::returnhome();
}

// Namespace ctf
// Params 0
// Checksum 0xc8e17cfb, Offset: 0x3374
// Size: 0x113
function onreset()
{
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
    self.previouscarrier = undefined;
}

// Namespace ctf
// Params 1
// Checksum 0xc52c0fbe, Offset: 0x348f
// Size: 0x348
function onuse( player )
{
    if ( !level.gameended )
    {
        if ( player vehicle::is_in_vehicle() )
        {
            return;
        }
        
        team = player.pers[ "team" ];
        otherteam = team_utility::getotherteam( team );
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
        dialog::leaderdialog( "enemy_flag_captured", team, "status" );
        dialog::leaderdialog( "flag_captured", otherteam, "status" );
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
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
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
        
        print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_obj_captured", "mp_enemy_obj_captured", player );
        
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
    }
}

// Namespace ctf
// Params 1
// Checksum 0xd00f2e7d, Offset: 0x37df
// Size: 0x2f
function onplayerconnect( player )
{
    player._flageffect = [];
    player._flagradiuseffect = [];
    player thread onplayerspawned();
}

// Namespace ctf
// Params 0
// Checksum 0x9a4f2487, Offset: 0x3816
// Size: 0x6d
function onplayerspawned()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned" );
        self setclientomnvar( "ui_flag_player_hud_icon", 0 );
        stats::setextrascore0( self.pers[ "captures" ] ?? 0, "captures" );
        stats::setextrascore1( self.pers[ "returns" ] ?? 0, "returns" );
    }
}

// Namespace ctf
// Params 0
// Checksum 0xf1cf08d7, Offset: 0x388b
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

// Namespace ctf
// Params 0
// Checksum 0xf64c5a34, Offset: 0x396c
// Size: 0x10e
function superabilitywatcher()
{
    self notify( #"superwatcher" );
    self endon( #"superwatcher" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"drop_object" );
    team = self.pers[ "team" ];
    otherteam = team_utility::getotherteam( team );
    level.teamflags[ otherteam ] endon( #"reset" );
    
    while ( true )
    {
        self waittill( #"super_started" );
        theflag = level.teamflags[ otherteam ];
        
        if ( !isdefined( theflag ) )
        {
            continue;
        }
        
        super = self.super;
        
        switch ( super.staticdata.ref )
        {
            case #"hash_8cf10370c167105a":
                utility::waittill_any( "teleport_success", "rewind_success" );
                theflag thread gameobjects::setdropped();
                return;
        }
    }
}

// Namespace ctf
// Params 0
// Checksum 0xb3fb9d84, Offset: 0x3a82
// Size: 0x2e
function waitattachflag()
{
    level endon( #"game_ende" );
    self endon( #"death_or_disconnect" );
    self waittill( #"spawned_player" );
    attachflag();
}

// Namespace ctf
// Params 0
// Checksum 0xb35335c3, Offset: 0x3ab8
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

// Namespace ctf
// Params 1
// Checksum 0x22e0a7c6, Offset: 0x3b5a
// Size: 0xc
function oncantuse( player )
{
    
}

// Namespace ctf
// Params 1
// Checksum 0x8fd3dafc, Offset: 0x3b6e
// Size: 0x71b
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    killid = deathdata.lifeid;
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
            var_3494613f4c5e8536 = distancesquared( victim.origin, level.capzones[ victim.team ].trigger.origin );
            
            if ( var_3494613f4c5e8536 < 90000 )
            {
                level.closecapturekiller[ attacker.team ] = attacker;
            }
            else
            {
                level.closecapturekiller[ attacker.team ] = undefined;
            }
            
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
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( attacker.pers[ "carrierKills" ] ) )
                {
                    attacker.pers[ "carrierKills" ] = attacker.pers[ "carrierKills" ] + 1;
                }
            }
            
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
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( attacker.pers[ "defends" ] ) )
                {
                    attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                }
            }
            
            attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
            victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "carrying" );
            victim codcaster_utils::function_3038b6eafc46c037( 20, attacker.team, attacker getentitynumber() );
            gaveaward = 1;
        }
        
        if ( !gaveaward )
        {
            awardassault = 0;
            awarddefense = 0;
            
            foreach ( flag in level.teamflags )
            {
                flagcheck = distsquaredcheck( attackerpos, victim.origin, flag.curorigin );
                
                if ( flagcheck )
                {
                    if ( flag.ownerteam == victim.team )
                    {
                        awardassault = 1;
                        continue;
                    }
                    
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
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
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
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                    }
                }
                
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

// Namespace ctf
// Params 3
// Checksum 0xfaa28119, Offset: 0x4291
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

// Namespace ctf
// Params 0
// Checksum 0x8335518f, Offset: 0x42fa
// Size: 0x58
function attachflag()
{
    updatematchstatushintonhasflag();
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    self attach( level.carryflag[ otherteam ], "tag_stowed_back3", 1 );
    self.carryflag = level.carryflag[ otherteam ];
}

// Namespace ctf
// Params 0
// Checksum 0x90f5a6dc, Offset: 0x435a
// Size: 0x20
function detachflag()
{
    self detach( self.carryflag, "tag_stowed_back3" );
    self.carryflag = undefined;
}

// Namespace ctf
// Params 0
// Checksum 0x305ae792, Offset: 0x4382
// Size: 0x86
function setspecialloadouts()
{
    if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", "axis", 5, "class", "inUse" ) )
    {
        level.ctf_loadouts[ "axis" ] = game_utility_mp::getmatchrulesspecialclass( "axis", 5 );
    }
    
    if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", "allies", 5, "class", "inUse" ) )
    {
        level.ctf_loadouts[ "allies" ] = game_utility_mp::getmatchrulesspecialclass( "allies", 5 );
    }
}

// Namespace ctf
// Params 0
// Checksum 0x61e422e8, Offset: 0x4410
// Size: 0x294
function removeflag()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvar( @"hash_6ce167f2cdc8ef7c", "" ) != "" )
        {
            goallabel = getdvar( @"hash_6ce167f2cdc8ef7c", "" );
            
            if ( goallabel == "_a" )
            {
                team = "allies";
            }
            else
            {
                team = "axis";
            }
            
            if ( team == "allies" )
            {
                if ( game[ "switchedsides" ] )
                {
                    team = game[ "defenders" ];
                }
                else
                {
                    team = game[ "attackers" ];
                }
            }
            else if ( game[ "switchedsides" ] )
            {
                team = game[ "attackers" ];
            }
            else
            {
                team = game[ "defenders" ];
            }
            
            level.teamflags[ team ].trigger notify( #"move_gameobject" );
            level.teamflags[ team ] gameobjects::allowuse( "none" );
            level.teamflags[ team ].trigger = undefined;
            level.teamflags[ team ] notify( #"deleted" );
            level.teamflags[ team ].visuals[ 0 ] delete();
            level.teamflagbases[ team ] delete();
            level.capzones[ team ] gameobjects::allowuse( "none" );
            level.capzones[ team ].trigger = undefined;
            level.capzones[ team ] notify( #"deleted" );
            
            foreach ( player in level.players )
            {
                player player_delete_flag_goal_fx( team );
            }
            
            level.teamflags[ team ].visibleteam = "none";
            level.teamflags[ team ] gameobjects::setobjectivestatusicons( undefined, undefined );
            level.capzones[ team ].visibleteam = "none";
            level.capzones[ team ] gameobjects::setobjectivestatusicons( undefined, undefined );
            level.teamflags[ team ] = undefined;
            setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "" );
        }
        
        wait 1;
    }
}

// Namespace ctf
// Params 0
// Checksum 0x5347f66c, Offset: 0x46ac
// Size: 0x60b
function placeflag()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvar( @"hash_29d45d6822a1cf6d", "" ) != "" )
        {
            goallabel = getdvar( @"hash_29d45d6822a1cf6d", "" );
            
            if ( goallabel == "_a" )
            {
                team = "allies";
            }
            else
            {
                team = "axis";
            }
            
            if ( team == "allies" )
            {
                if ( game[ "switchedsides" ] )
                {
                    team = game[ "defenders" ];
                }
                else
                {
                    team = game[ "attackers" ];
                }
            }
            else if ( game[ "switchedsides" ] )
            {
                team = game[ "attackers" ];
            }
            else
            {
                team = game[ "defenders" ];
            }
            
            goal = undefined;
            goal = spawnstruct();
            goal dev_flag_find_ground();
            goal.origin = goal.ground_origin;
            goal.radius = 30;
            goal.team = team;
            trigger = spawn( "trigger_radius", goal.origin, 0, 30, 80 );
            visuals[ 0 ] = spawn( "script_model", goal.origin );
            visuals[ 0 ] setmodel( level.flagmodel[ team ] );
            newteamflag = gameobjects::createcarryobject( team, trigger, visuals, ( 0, 0, 85 ) );
            newteamflag gameobjects::setteamusetext( "enemy", &"mp/grabbing_flag" );
            newteamflag gameobjects::setteamusetext( "friendly", &"mp/returning_flag" );
            newteamflag gameobjects::allowcarry( "enemy" );
            newteamflag gameobjects::setvisibleteam( "none" );
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
            newteamflag.previouscarrier = undefined;
            tracestart = trigger.origin + ( 0, 0, 32 );
            traceend = trigger.origin + ( 0, 0, -32 );
            contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
            ignoreents = [];
            trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
            newteamflag.baseeffectpos = trace[ "position" ];
            upangles = vectortoangles( trace[ "normal" ] );
            newteamflag.baseeffectforward = anglestoforward( upangles );
            level.teamflagbases[ team ] = createteamflagbase( team, newteamflag );
            
            if ( team == "allies" )
            {
                if ( game[ "switchedsides" ] )
                {
                    level.teamflags[ game[ "defenders" ] ] = newteamflag;
                }
                else
                {
                    level.teamflags[ game[ "attackers" ] ] = newteamflag;
                }
            }
            else if ( game[ "switchedsides" ] )
            {
                level.teamflags[ game[ "attackers" ] ] = newteamflag;
            }
            else
            {
                level.teamflags[ game[ "defenders" ] ] = newteamflag;
            }
            
            visuals = [];
            trigger = spawn( "trigger_radius", goal.origin - ( 0, 0, goal.radius / 2 ), 0, goal.radius, 80 );
            trigger.no_moving_platfrom_unlink = 1;
            trigger.linktoenabledflag = 1;
            trigger.baseorigin = trigger.origin;
            capzone = gameobjects::createuseobject( team, trigger, visuals, ( 0, 0, 115 ) );
            capzone gameobjects::allowuse( "friendly" );
            capzone gameobjects::setvisibleteam( "any" );
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
            upangles = vectortoangles( trace[ "normal" ] );
            
            if ( team == "allies" )
            {
                if ( game[ "switchedsides" ] )
                {
                    level.capzones[ game[ "defenders" ] ] = capzone;
                }
                else
                {
                    level.capzones[ game[ "attackers" ] ] = capzone;
                }
            }
            else if ( game[ "switchedsides" ] )
            {
                level.capzones[ game[ "attackers" ] ] = capzone;
            }
            else
            {
                level.capzones[ game[ "defenders" ] ] = capzone;
            }
            
            setdynamicdvar( @"hash_29d45d6822a1cf6d", "" );
        }
        
        wait 1;
    }
}

// Namespace ctf
// Params 0
// Checksum 0x4388dd49, Offset: 0x4cbf
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

// Namespace ctf
// Params 0
// Checksum 0x59addb2c, Offset: 0x4d8b
// Size: 0xdd
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_recover_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0, 12 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag", 0, 12 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_take_flag", 2, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0, 13 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0, 13 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined );
}

// Namespace ctf
// Params 0
// Checksum 0x2d2f5e8, Offset: 0x4e70
// Size: 0x12
function updatematchstatushintonnoflag()
{
    hud_message::function_ef4318a0090caa0f( #"flag_capture" );
}

// Namespace ctf
// Params 0
// Checksum 0xef59e321, Offset: 0x4e8a
// Size: 0x12
function updatematchstatushintonhasflag()
{
    hud_message::function_ef4318a0090caa0f( #"flag_return" );
}

/#

    // Namespace ctf
    // Params 0
    // Checksum 0x6ac4156a, Offset: 0x4ea4
    // Size: 0xa2, Type: dev
    function function_e615ba0771243a67()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x4a>", getdvarint( @"scr_give_score_allies" ), 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x51>", getdvarint( @"scr_give_score_axis" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_e615ba0771243a67();
    }

#/

// Namespace ctf
// Params 0
// Checksum 0x66ce804a, Offset: 0x4f4e
// Size: 0x9
function function_7666cbd65a14566()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

