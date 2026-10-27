// scripts\mp\gametypes\elim.gsc  (hash_4f17015500536831.gscc) (size: 15203 Bytes / 0x3b63 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93259a90 (2468715152)
// size ...... 15203 (0x3b63)
// includes .. 29  (offset: 0x3523)
// strings ... 60  (offset: 0x360b)
// dev strs .. 14  (offset: 0x3a9f)
// exports ... 44  (offset: 0x205f)
// cseg ...... 0x43b + 0x1c24 (0x205f)
// imports ... 114 (offset: 0x273f)
// animtree1 . 0   (offset: 0x3b63)
// animtree2 . 0   (offset: 0x3b63)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\hq;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\teamrevive;

#namespace elim;

// Namespace elim
// Params 0
// Checksum 0xcccdd2fd, Offset: 0x459
// Size: 0x1c1
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "dom";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_death", &onplayerkilled );
    level.var_c1ccd70f708422ff = level.gametypebundle.var_c1ccd70f708422ff ?? #"hash_3fec3883aed31c90";
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.objectivebased = 1;
    level.var_1006ea76c66f444 = 1;
    level.var_3df1794b22c65c8a = &function_a85c2256f4732ae2;
    level.onstartgametype = &onstartgametype;
    level.updatealiveomnvars = &function_c8238fa165466b5f;
    level.getspawnpoint = &getspawnpoint;
    level.onmaprestart = &function_202a28ece717d32a;
    level.onnormaldeath = &onnormaldeath;
    level.var_4302726c8b918b9a = &function_3b23d3a5d44e56bf;
    level.ononeleftevent = &elim_ononeleftevent;
    level.ontimelimit = &elim_ontimelimit;
    level.disablespawningforplayerfunc = &function_241ce649ee44f2b7;
    level.modelaststandallowed = &modelaststandallowed;
    level.var_295e3e1536070747 = 1;
    level callback::add( "on_revive_trigger_requested", &function_1fe70fe3b2323eb7 );
    level.var_7b18d7f69313853a = 1;
    game[ "canScoreOnTie" ] = 1;
}

// Namespace elim
// Params 0
// Checksum 0x457aa519, Offset: 0x622
// Size: 0x65
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.scoreconfirm = getmatchrulesdata( "commonOption", "dogTagPointsPerConfirmedKill" );
    level.scoredeny = getmatchrulesdata( "commonOption", "dogTagPointsPerDeny" );
    level.numteamlives = getmatchrulesdata( "controlData", "numTeamLives" );
    level.suicideteamkilllowerslives = getmatchrulesdata( "controlData", "suicideTeamKillLowersLives" );
}

// Namespace elim
// Params 0
// Checksum 0xb8c28278, Offset: 0x68f
// Size: 0x2ab
function onstartgametype()
{
    function_34d249f60483bcdb();
    setdvar( @"scr_game_objonnavbar", 1 );
    level.wingamebytype = "roundsWon";
    attacking_team = game[ "attackers" ];
    defending_team = game[ "defenders" ];
    level.teamdata[ attacking_team ][ "livesCount" ] = level.numteamlives;
    level.teamdata[ defending_team ][ "livesCount" ] = level.numteamlives;
    level.teamdata[ attacking_team ][ "elimUILivesCount" ] = level.teamdata[ attacking_team ][ "livesCount" ];
    level.teamdata[ defending_team ][ "elimUILivesCount" ] = level.teamdata[ defending_team ][ "livesCount" ];
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "match_kills" ] ) )
    {
        game[ "match_kills" ][ defending_team ] = 0;
        game[ "match_kills" ][ attacking_team ] = 0;
    }
    
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
        game_utility_mp::setobjectivetext( entry, &"objectives/conf" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/conf" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/conf_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/conf_hint" );
    }
    
    initspawns();
    level.dogtagallyonusecb = &dogtagallyonusecb;
    level.dogtagenemyonusecb = &dogtagenemyonusecb;
    
    /#
        init_elim_devgui();
    #/
    
    level.var_764eb1e7a422f321 = 0;
    level.var_764eb4e7a422f9ba = 0;
    level.teamdata[ attacking_team ][ "uncountedDeaths" ] = 0;
    level.teamdata[ defending_team ][ "uncountedDeaths" ] = 0;
    level.teamdata[ attacking_team ][ "dbno" ] = 0;
    level.teamdata[ defending_team ][ "dbno" ] = 0;
    thread function_5ced1b53990218d1();
}

// Namespace elim
// Params 0
// Checksum 0xa0a01a39, Offset: 0x942
// Size: 0x26
function function_5ced1b53990218d1()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    level function_18b90a2be8797f0d();
}

// Namespace elim
// Params 0
// Checksum 0xaddb3611, Offset: 0x970
// Size: 0xe1
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_c87bd865d7b44cd0( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_ctf_spawn_allies_start", game[ "defenders" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_ctf_spawn_axis_start", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_attackers", "mp_ctf_spawn_allies", game[ "defenders" ] );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_defenders", "mp_ctf_spawn_axis", game[ "attackers" ] );
    }
    
    spawnlogic::finalizemap();
}

// Namespace elim
// Params 0
// Checksum 0xe155fe50, Offset: 0xa59
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace elim
// Params 0
// Checksum 0xc80d149a, Offset: 0xa6a
// Size: 0x17
function getspawnpoint()
{
    spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self );
    return spawnpoint;
}

// Namespace elim
// Params 1
// Checksum 0xc3a6c4de, Offset: 0xa8a
// Size: 0x5b
function function_3b23d3a5d44e56bf( deathdata )
{
    var_2ad52b8e176c566 = deathdata.victim obj_dogtag::shouldspawntags( deathdata.attacker ) && !teams::getteamdata( deathdata.victim.team, "noRespawns" );
    return var_2ad52b8e176c566;
}

// Namespace elim
// Params 1
// Checksum 0xf93571e4, Offset: 0xaee
// Size: 0x58
function dogtagallyonusecb( player )
{
    if ( isplayer( player ) )
    {
        player stats::setextrascore1( player.pers[ "denied" ], "denied" );
        player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.scoredeny, 0 );
    }
}

// Namespace elim
// Params 1
// Checksum 0x66c3fb44, Offset: 0xb4e
// Size: 0x6f
function dogtagenemyonusecb( player )
{
    if ( isplayer( player ) )
    {
        currentteam = team_utility::getotherteam( player.team );
        
        if ( !teams::getteamdata( currentteam, "noRespawns" ) )
        {
            thread function_d4c51355331f39dc( player, currentteam );
            player stats::setextrascore2( player.pers[ "extrascore2" ] + 1, "confirmed" );
        }
    }
}

// Namespace elim
// Params 2
// Checksum 0xe31b9b0c, Offset: 0xbc5
// Size: 0x67
function function_7d2933aa273c0eae( player, currentteam )
{
    level.teamdata[ currentteam ][ "uncountedDeaths" ]++;
    player.uncounteddeath = 1;
    player utility::waittill_any( "spawned", "disconnect" );
    level.teamdata[ currentteam ][ "uncountedDeaths" ]--;
    player.uncounteddeath = undefined;
}

// Namespace elim
// Params 0
// Checksum 0x624cd82b, Offset: 0xc34
// Size: 0x296
function function_18b90a2be8797f0d()
{
    attackersalivecount = teams::getteamdata( "allies", "aliveCount" );
    defendersalivecount = teams::getteamdata( "axis", "aliveCount" );
    
    if ( level.numteamlives == 0 )
    {
        setomnvar( "ui_allies_alive", teams::getteamdata( "allies", "teamCount" ) );
        setomnvar( "ui_axis_alive", teams::getteamdata( "axis", "teamCount" ) );
        setomnvar( "ui_allies_lives_remaining", teams::getteamdata( "allies", "livesCount" ) );
        setomnvar( "ui_axis_lives_remaining", teams::getteamdata( "axis", "livesCount" ) );
        return;
    }
    else if ( attackersalivecount > level.numteamlives || defendersalivecount > level.numteamlives )
    {
        var_9c81f0eee229adb2 = attackersalivecount > defendersalivecount ? attackersalivecount : defendersalivecount;
        function_fc7a52f4d4032ae2( "allies", var_9c81f0eee229adb2 );
        function_fc7a52f4d4032ae2( "axis", var_9c81f0eee229adb2 );
        level.numteamlives = var_9c81f0eee229adb2;
    }
    
    setomnvar( "ui_allies_alive", elim_get_lives( "allies", 1 ) );
    setomnvar( "ui_axis_alive", elim_get_lives( "axis", 1 ) );
    setomnvar( "ui_allies_lives_remaining", elim_get_lives( "allies", 1 ) );
    setomnvar( "ui_axis_lives_remaining", elim_get_lives( "axis", 1 ) );
    var_a93ce3abf473b242 = level.teamdata[ "allies" ][ "teamCount" ];
    
    if ( teams::getteamdata( "allies", "livesCount" ) <= 10 && !level.var_764eb1e7a422f321 && level.numteamlives - var_a93ce3abf473b242 > 10 )
    {
        dialog::statusdialog( #"team_low_lives", "allies", "lives" );
        dialog::statusdialog( #"enemy_low_lives", "axis", "lives" );
        level.var_764eb1e7a422f321 = 1;
    }
    
    var_ca46b02457bf6e22 = level.teamdata[ "axis" ][ "teamCount" ];
    
    if ( teams::getteamdata( "axis", "livesCount" ) <= 10 && !level.var_764eb4e7a422f9ba && level.numteamlives - var_ca46b02457bf6e22 > 10 )
    {
        dialog::statusdialog( #"team_low_lives", "axis", "lives" );
        dialog::statusdialog( #"enemy_low_lives", "allies", "lives" );
        level.var_764eb4e7a422f9ba = 1;
    }
}

// Namespace elim
// Params 2
// Checksum 0xc252165c, Offset: 0xed2
// Size: 0x104
function function_fc7a52f4d4032ae2( team_name, var_157b222b41e61688 )
{
    alivecount = teams::getteamdata( team_name, "aliveCount" );
    livescount = teams::getteamdata( team_name, "livesCount" );
    uicount = teams::getteamdata( team_name, "elimUILivesCount" );
    
    if ( var_157b222b41e61688 < uicount || var_157b222b41e61688 < alivecount + livescount )
    {
        assertmsg( "<dev string:x24>" + team_name );
        return;
    }
    
    if ( alivecount + livescount < var_157b222b41e61688 )
    {
        var_79f52678a11f3abc = var_157b222b41e61688 - alivecount + livescount;
        level.teamdata[ team_name ][ "livesCount" ] = level.teamdata[ team_name ][ "livesCount" ] + var_79f52678a11f3abc;
        level.teamdata[ team_name ][ "noRespawns" ] = 0;
        setomnvar( "ui_" + team_name + "_no_respawn", 0 );
    }
    
    if ( uicount != var_157b222b41e61688 )
    {
        level.teamdata[ team_name ][ "elimUILivesCount" ] = var_157b222b41e61688;
    }
}

// Namespace elim
// Params 0
// Checksum 0xb8a0ee4d, Offset: 0xfde
// Size: 0xa
function function_c8238fa165466b5f()
{
    level function_18b90a2be8797f0d();
}

// Namespace elim
// Params 2
// Checksum 0x8c9e0ff5, Offset: 0xff0
// Size: 0x86
function elim_get_lives( team, internal_count )
{
    total_lives = undefined;
    
    if ( internal_count )
    {
        total_lives = level.teamdata[ team ][ "elimUILivesCount" ];
    }
    else
    {
        livescount = teams::getteamdata( team, "livesCount" );
        alivecount = teams::getteamdata( team, "aliveCount" );
        total_lives = livescount + alivecount;
    }
    
    if ( !isdefined( total_lives ) || total_lives < 0 )
    {
        total_lives = 0;
    }
    
    return total_lives;
}

// Namespace elim
// Params 1
// Checksum 0xb5633990, Offset: 0x107f
// Size: 0x54
function onplayerspawned( player )
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned" );
        stats::setextrascore0( self.pers[ "damage" ] ?? 0, "damage" );
        level function_18b90a2be8797f0d();
    }
}

// Namespace elim
// Params 1
// Checksum 0xf673eaf2, Offset: 0x10db
// Size: 0x1c1
function onplayerkilled( deathdata )
{
    einflictor = deathdata.inflictor;
    attacker = deathdata.attacker;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    
    if ( isplayer( attacker ) && attacker != self && attacker.team != self.team )
    {
        isattacker = attacker.team == game[ "attackers" ];
        
        if ( isattacker )
        {
            attacker codcasterclientmatchdata::function_d1f0591eda60c559( 10, 1 );
        }
        else
        {
            attacker codcasterclientmatchdata::function_d1f0591eda60c559( 9, 1 );
        }
    }
    
    currentteam = self.team;
    issuicide = damage::issuicide( einflictor, attacker, smeansofdeath, objweapon );
    isteamkill = damage::isteamkill( einflictor, attacker );
    
    if ( isdefined( self.joining_team ) && self.joining_team != "spectator" )
    {
        currentteam = team_utility::getotherteam( self.joining_team );
    }
    
    if ( ( issuicide || isteamkill ) && !level.suicideteamkilllowerslives && !self.switching_teams )
    {
        if ( teams::getteamdata( currentteam, "noRespawns" ) )
        {
            thread playerlogic::spawnclient();
        }
        
        level thread function_7d2933aa273c0eae( self, currentteam );
        return;
    }
    
    game[ "match_kills" ][ team_utility::getotherteam( currentteam ) ]++;
    norespawns = teams::getteamdata( currentteam, "noRespawns" );
    
    if ( norespawns )
    {
        function_d4c51355331f39dc( self, currentteam );
    }
    
    level function_18b90a2be8797f0d();
}

// Namespace elim
// Params 2
// Checksum 0x15d225d6, Offset: 0x12a4
// Size: 0x12d
function function_d4c51355331f39dc( player, affectedteam )
{
    teamcount = teams::getteamdata( affectedteam, "teamCount" );
    norespawns = teams::getteamdata( affectedteam, "noRespawns" );
    elimuilivescount = teams::getteamdata( affectedteam, "elimUILivesCount" );
    level.teamdata[ affectedteam ][ "elimUILivesCount" ]--;
    level.teamdata[ affectedteam ][ "livesCount" ]--;
    elimuilivescount = level.teamdata[ affectedteam ][ "elimUILivesCount" ];
    
    if ( !norespawns && elimuilivescount == teamcount )
    {
        function_882fa73e858c8e90( affectedteam );
    }
    
    total_lives_left = level.teamdata[ affectedteam ][ "elimUILivesCount" ];
    
    if ( total_lives_left == 0 && level.numteamlives != 0 || teamcount == 0 )
    {
        otherteam = team_utility::getotherteam( player.team );
        elim_endround( otherteam, game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "friendlies_eliminated" ] );
    }
    
    level function_18b90a2be8797f0d();
}

// Namespace elim
// Params 5
// Checksum 0xdc037895, Offset: 0x13d9
// Size: 0x51
function elim_endround( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    gamescore::giveteamscoreforobjective( winningteam, 1 );
    level thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
    codcasterclientmatchdata::function_d6aea11d2e9ba521();
}

// Namespace elim
// Params 1
// Checksum 0x8bc938ef, Offset: 0x1432
// Size: 0x29
function elim_ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    lastplayer thread elim_givelastonteamwarning();
}

// Namespace elim
// Params 0
// Checksum 0xdb8cc898, Offset: 0x1463
// Size: 0x98
function elim_givelastonteamwarning()
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

// Namespace elim
// Params 1
// Checksum 0x64de4ee8, Offset: 0x1503
// Size: 0x16b
function function_cae49d4fbe5ead63( team )
{
    if ( game_utility::gettimepassed() < 5000 )
    {
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    function_3dbd2b5d0e0b249d( team );
    
    foreach ( player in players )
    {
        player thread hq::showrespawnwarningmessage();
    }
    
    dialog::statusdialog( #"team_no_lives", team, "lives" );
    dialog::statusdialog( #"enemy_no_lives", team_utility::getotherteam( team ), "lives" );
    
    foreach ( player in level.players )
    {
        if ( player.team == team_utility::getotherteam( team ) )
        {
            player perk::giveperk( "specialty_kill_report" );
        }
    }
}

// Namespace elim
// Params 2
// Checksum 0x25d54e99, Offset: 0x1676
// Size: 0xa4, Type: bool
function function_241ce649ee44f2b7( player, revivespawn )
{
    if ( !isdefined( level.var_c6b02af9c0f45ca2[ player.team ] ) || player.lastdeathtime < level.var_c6b02af9c0f45ca2[ player.team ] )
    {
        return false;
    }
    
    if ( !revivespawn && teams::getteamdata( player.team, "noRespawns" ) && player.team != "none" && player.team != "spectator" )
    {
        return true;
    }
    
    return false;
}

// Namespace elim
// Params 6
// Checksum 0x6e715b4e, Offset: 0x1723
// Size: 0x60
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    victim.lastdeathtime = gettime();
    level function_18b90a2be8797f0d();
}

// Namespace elim
// Params 1
// Checksum 0x510638a0, Offset: 0x178b
// Size: 0x7a
function onspawnplayer( spawndata )
{
    revivespawn = spawndata.revivespawn;
    
    if ( teams::getteamdata( self.team, "noRespawns" ) && revivespawn )
    {
        thread function_ae9473a3a7d1b4a3( self, self.team );
    }
    
    if ( teams::getteamdata( team_utility::getotherteam( self.team ), "noRespawns" ) )
    {
        perk::giveperk( "specialty_kill_report" );
    }
}

// Namespace elim
// Params 2
// Checksum 0x2da1fd53, Offset: 0x180d
// Size: 0x43
function function_ae9473a3a7d1b4a3( player, affectedteam )
{
    level.teamdata[ affectedteam ][ "elimUILivesCount" ]++;
    level.teamdata[ affectedteam ][ "livesCount" ]++;
    level function_18b90a2be8797f0d();
}

// Namespace elim
// Params 1
// Checksum 0x21a8aa87, Offset: 0x1858
// Size: 0x78
function function_882fa73e858c8e90( team )
{
    function_688af8cc254b5477();
    teams::setteamdata( team, "dbno", 1 );
    teams::setteamdata( team, "noRespawns", 1 );
    
    if ( !isdefined( level.var_c6b02af9c0f45ca2 ) )
    {
        level.var_c6b02af9c0f45ca2 = [];
    }
    
    level.var_c6b02af9c0f45ca2[ team ] = gettime();
    setomnvar( "ui_" + team + "_no_respawn", 1 );
    function_cae49d4fbe5ead63( team );
}

// Namespace elim
// Params 0
// Checksum 0x36fd479d, Offset: 0x18d8
// Size: 0xd9
function elim_ontimelimit()
{
    if ( !isdefined( level.var_d95b674c4a3e8f05 ) )
    {
        var_6444554a33efb111 = level.teamdata[ game[ "attackers" ] ][ "elimUILivesCount" ];
        var_232b2b8d602fe64d = level.teamdata[ game[ "defenders" ] ][ "elimUILivesCount" ];
        
        if ( var_6444554a33efb111 > var_232b2b8d602fe64d )
        {
            elim_endround( game[ "attackers" ], game[ "end_reason" ][ "elim_lives_win" ], game[ "end_reason" ][ "elim_lives_loss" ] );
        }
        else if ( var_232b2b8d602fe64d > var_6444554a33efb111 )
        {
            elim_endround( game[ "defenders" ], game[ "end_reason" ][ "elim_lives_win" ], game[ "end_reason" ][ "elim_lives_loss" ] );
        }
        
        elim_endround( "tie", game[ "end_reason" ][ "elim_tie" ] );
        level.var_d95b674c4a3e8f05 = 1;
    }
}

// Namespace elim
// Params 0
// Checksum 0xae9c9226, Offset: 0x19b9
// Size: 0xd
function function_688af8cc254b5477()
{
    level.laststand = 2;
}

// Namespace elim
// Params 0
// Checksum 0x470f2db0, Offset: 0x19ce
// Size: 0xc
function function_34d249f60483bcdb()
{
    level.laststand = 0;
}

// Namespace elim
// Params 1
// Checksum 0x1fcd9924, Offset: 0x19e2
// Size: 0x3e
function function_1bd2057248452f5e( rules )
{
    assert( rules == 2 || rules == 0 || rules == 1 || rules == 3 );
    level.laststand = rules;
}

// Namespace elim
// Params 1
// Checksum 0x93c0d82a, Offset: 0x1a28
// Size: 0x86
function function_1fe70fe3b2323eb7( deathdata )
{
    if ( !isdefined( deathdata ) )
    {
        return;
    }
    
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    meansofdeath = deathdata.meansofdeath;
    norespawns = teams::getteamdata( victim.team, "noRespawns" );
    
    if ( norespawns )
    {
        level thread teamrevive::spawnrevivetrigger( victim, attacker, meansofdeath );
    }
}

// Namespace elim
// Params 1
// Checksum 0xbf90d6f5, Offset: 0x1ab6
// Size: 0x64
function function_a85c2256f4732ae2( reviver )
{
    rescues = reviver.pers[ "rescues" ] + 1;
    reviver.pers[ "rescues" ] = rescues;
    reviver persistence::statsetchild( "round", "rescues", rescues );
    reviver stats::setextrascore1( rescues, "rescues" );
}

// Namespace elim
// Params 0
// Checksum 0x4647c7b8, Offset: 0x1b22
// Size: 0x9
function function_202a28ece717d32a()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace elim
// Params 9
// Checksum 0xb122139c, Offset: 0x1b33
// Size: 0x7d, Type: bool
function modelaststandallowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( teams::getteamdata( self.team, "dbno" ) == 1 || player::function_73fe5f51164eb3ca( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace elim
// Params 1
// Checksum 0xaf1d6ca6, Offset: 0x1bb9
// Size: 0xd2
function function_3dbd2b5d0e0b249d( teamname )
{
    foreach ( player in level.players )
    {
        if ( player.team == teamname )
        {
            player hud_message::function_78fedf6f526825f4( "elim_friendly_norespawn", level.gametypebundle.var_e662dd7f27d462eb );
            continue;
        }
        
        player hud_message::function_78fedf6f526825f4( "elim_enemy_norespawn", level.gametypebundle.var_e662dd7f27d462eb );
    }
}

// Namespace elim
// Params 1
// Checksum 0x51cbc9f7, Offset: 0x1c93
// Size: 0x2d
function function_79f7a3e4aac6b11b( player )
{
    player hud_message::function_78fedf6f526825f4( "elim_last_alive", level.gametypebundle.var_e662dd7f27d462eb );
}

/#

    // Namespace elim
    // Params 0
    // Checksum 0x993c13e4, Offset: 0x1cc8
    // Size: 0x99, Type: dev
    function init_elim_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x55>" );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x92>", &function_91c8273814eea433 );
        devgui::add_devgui_func( "<dev string:xad>", "<dev string:xc6>", &function_d2d467785ffb8d64 );
        devgui::add_devgui_func( "<dev string:xe4>", "<dev string:xf7>", &function_f7a0c2b1d751e777 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x107>" );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x92>", &function_491d1a00e7ce7092 );
        devgui::add_devgui_func( "<dev string:xad>", "<dev string:xc6>", &function_2ccad690a30302dd );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace elim
    // Params 0
    // Checksum 0x30fa3b4c, Offset: 0x1d69
    // Size: 0xb8, Type: dev
    function function_91c8273814eea433()
    {
        foreach ( player in level.players )
        {
            player hud_message::function_78fedf6f526825f4( "<dev string:x119>", level.gametypebundle.var_e662dd7f27d462eb );
            waitframe();
            player hud_message::function_78fedf6f526825f4( "<dev string:x12e>", level.gametypebundle.var_e662dd7f27d462eb );
        }
    }

    // Namespace elim
    // Params 0
    // Checksum 0x3f373fc8, Offset: 0x1e29
    // Size: 0xb8, Type: dev
    function function_d2d467785ffb8d64()
    {
        foreach ( player in level.players )
        {
            player hud_message::function_78fedf6f526825f4( "<dev string:x144>", level.gametypebundle.var_e662dd7f27d462eb );
            waitframe();
            player hud_message::function_78fedf6f526825f4( "<dev string:x12e>", level.gametypebundle.var_e662dd7f27d462eb );
        }
    }

    // Namespace elim
    // Params 0
    // Checksum 0xd3d9e8ec, Offset: 0x1ee9
    // Size: 0x7e, Type: dev
    function function_f7a0c2b1d751e777()
    {
        foreach ( player in level.players )
        {
            function_79f7a3e4aac6b11b( player );
        }
    }

    // Namespace elim
    // Params 0
    // Checksum 0xa5decebf, Offset: 0x1f6f
    // Size: 0x71, Type: dev
    function function_2ccad690a30302dd()
    {
        host = dev_mp::devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        team = host.team;
        teamcount = teams::getteamdata( team, "<dev string:x15c>" );
        
        while ( level.teamdata[ team ][ "<dev string:x166>" ] > teamcount )
        {
            function_d4c51355331f39dc( host, team );
            waitframe();
        }
    }

    // Namespace elim
    // Params 0
    // Checksum 0xcacc8994, Offset: 0x1fe8
    // Size: 0x77, Type: dev
    function function_491d1a00e7ce7092()
    {
        host = dev_mp::devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        team = utility::get_enemy_team( host.team );
        teamcount = teams::getteamdata( team, "<dev string:x15c>" );
        
        while ( level.teamdata[ team ][ "<dev string:x166>" ] > teamcount )
        {
            function_d4c51355331f39dc( host, team );
            waitframe();
        }
    }

#/
