// scripts\mp\gametypes\hvt.gsc  (hash_43c9482a4b303776.gscc) (size: 16150 Bytes / 0x3f16 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66c95305 (1724470021)
// size ...... 16150 (0x3f16)
// includes .. 29  (offset: 0x39fe)
// strings ... 67  (offset: 0x3ae6)
// dev strs .. 4   (offset: 0x3ee6)
// exports ... 39  (offset: 0x2332)
// cseg ...... 0x4f2 + 0x1e40 (0x2332)
// imports ... 139 (offset: 0x294a)
// animtree1 . 0   (offset: 0x3f16)
// animtree2 . 0   (offset: 0x3f16)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;

#namespace hvt;

// Namespace hvt
// Params 0
// Checksum 0x355d8156, Offset: 0x510
// Size: 0x1df
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
    setdvar( @"scr_br_plate_carrier_start_level", 3 );
    level.armoronweaponswitchlongpress = 1;
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"player_laststand_revived", &onplayerrevived );
    callback::add( #"player_damaged", &onplayerdamaged );
    callback::add( #"hash_5e4c0033a7bbd7f", &function_548f63b6a329f695 );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modelaststandallowed = &modelaststandallowed;
    level.modeonlaststandfunc = &function_125c804510c1599;
    level.modeonexitlaststandfunc = &function_4350f41bc6c5eb39;
    level.var_40d8cae54a6dee6a = &function_43b1290eb3e89c2c;
    level.var_c4a835bb7120c6a0 = &function_1e88dd003e88d764;
    level.gamemodemaydropweapon = &function_a229e03864cfe8d6;
    level.var_89173a04bb110bf3 = &function_7a93eb5505da6cac;
    level.var_4c0febb86a7c172e = &function_cb7f21eed6db2300;
    level.disablebuddyspawn = 1;
    level.var_65b5e8139a5aee5b = [];
    level.var_65b5e8139a5aee5b[ "allies" ] = 0;
    level.var_65b5e8139a5aee5b[ "axis" ] = 0;
    level.var_55bbdddfcf3fe14c = 1;
}

// Namespace hvt
// Params 0
// Checksum 0x2b206812, Offset: 0x6f7
// Size: 0x37
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.var_3e1f75796cb3a708 = getmatchrulesdata( "hvtData", "hvtSpawnArmorPlates" );
    level.hvtspawnarmor = getmatchrulesdata( "hvtData", "hvtSpawnArmor" );
}

// Namespace hvt
// Params 0
// Checksum 0x2de9ea22, Offset: 0x736
// Size: 0x88
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.hvtnumhvtperteam = getmatchrulesdata( "bountyData", "hvtsPerTeam" ) ?? dvars::dvarintvalue( "hvtNumHVTPerTeam", 1, 1, 7 );
    level.hvtpointsperhvtkilled = getmatchrulesdata( "bountyData", "pointsPerHVTKill" ) ?? dvars::dvarintvalue( "hvtPointsPerHVTKilled", 5, 0, 15 );
    level.hvtpointsperkillashvt = getmatchrulesdata( "hvtData", "hvtPointsPerKillAsHVT" ) ?? dvars::dvarintvalue( "hvtPointsPerKillAsHVT", 3, 0, 15 );
}

// Namespace hvt
// Params 0
// Checksum 0x2124034f, Offset: 0x7c6
// Size: 0x143
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
        game_utility_mp::setobjectivetext( entry, &"objectives/hvt" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/hvt" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"hash_57495d6d125585fa" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"hash_56c216ec0fca58d1" );
    }
    
    initspawns();
    setomnvar( "allies_hvt_last_stand", 0 );
    setomnvar( "axis_hvt_last_stand", 0 );
}

// Namespace hvt
// Params 0
// Checksum 0xb911b68c, Offset: 0x911
// Size: 0xd1
function initspawns()
{
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

// Namespace hvt
// Params 0
// Checksum 0x7a53b7af, Offset: 0x9ea
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace hvt
// Params 0, eflags: 0xc
// Checksum 0xe0e48363, Offset: 0x9fc
// Size: 0x38
function private function_bba0f405c611038e()
{
    self notify( #"hash_9289ae978d92a720" );
    self endon( #"hash_9289ae978d92a720" );
    self endon( #"disconnect" );
    wait 3;
    
    if ( isdefined( self ) )
    {
        self.var_9bae56234ac6f96a = undefined;
    }
}

// Namespace hvt
// Params 1
// Checksum 0x6450738, Offset: 0xa3c
// Size: 0xd6
function onplayerdamaged( data )
{
    victim = data.victim;
    attacker = data.eattacker;
    
    if ( victim != attacker )
    {
        if ( victim.ishvt )
        {
            if ( player::isinlaststand( victim ) )
            {
                attacker.var_9bae56234ac6f96a = 1;
                attacker thread function_bba0f405c611038e();
            }
            else
            {
                cooldown = 20000;
                
                if ( !victim.var_4ff8306fab04a552 )
                {
                    cooldown = 0;
                }
                
                excludelist = [ data.victim ];
                dialog::statusdialog( "hvt_damaged_friendly", victim.team, undefined, excludelist, undefined, cooldown );
            }
            
            victim.var_4ff8306fab04a552 = 1;
        }
    }
}

// Namespace hvt
// Params 1
// Checksum 0xa0b68298, Offset: 0xb1a
// Size: 0x385
function onplayerkilled( deathdata )
{
    victim = deathdata.victim;
    einflictor = deathdata.inflictor;
    attacker = deathdata.attacker;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    iskillstreakweapon = deathdata.iskillstreakweapon;
    issuicide = victim damage::issuicide( einflictor, attacker, smeansofdeath, objweapon );
    
    if ( issuicide )
    {
        victim.var_46f90c843fe2dd22 = 1;
    }
    
    if ( level.friendlyfire )
    {
        if ( attacker != victim && attacker.team == victim.team )
        {
            return;
        }
    }
    
    if ( victim.ishvt )
    {
        victim function_eac57ae34f36f457( attacker, iskillstreakweapon );
    }
    else if ( attacker.ishvt )
    {
        attacker points::doscoreevent( #"hvt_kill_as" );
        
        if ( attacker.killcountthislife == 5 )
        {
            attacker thread points::doscoreevent( #"hash_ddb446a223d7d8c7" );
        }
        
        teamscore = iskillstreakweapon ? 1 : level.hvtpointsperkillashvt;
        gamescore::giveteamscoreforobjective( attacker.team, teamscore );
        totalpoints = attacker getclientomnvar( "ui_hvt_earned_points" ) + teamscore;
        attacker setclientomnvar( "ui_hvt_earned_points", totalpoints );
        
        if ( isdefined( victim.attackers ) )
        {
            foreach ( player in victim.attackers )
            {
                if ( player == attacker || player == victim )
                {
                    continue;
                }
                
                player points::doscoreevent( #"hvt_kill_assist" );
            }
        }
    }
    else if ( !issuicide )
    {
        gamescore::giveteamscoreforobjective( attacker.team, 1 );
        
        foreach ( player in teams::getteamdata( attacker.team, "players" ) )
        {
            if ( !player.ishvt )
            {
                continue;
            }
            
            if ( utility::function_92fc197c20834b39( player, attacker.origin, 394 ) )
            {
                attacker thread points::doscoreevent( #"hash_6024b517dee12974" );
                attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + 1, "hvtDefends" );
            }
        }
    }
    
    if ( !( attacker.ishvt || issuicide ) && victim.var_9bae56234ac6f96a && function_a8daead954baed9a( attacker.team ) > 0 )
    {
        victim.var_9bae56234ac6f96a = undefined;
        attacker thread points::doscoreevent( #"saved_hvt" );
    }
}

// Namespace hvt
// Params 1
// Checksum 0xc6336078, Offset: 0xea7
// Size: 0x5a
function function_548f63b6a329f695( deathdata )
{
    if ( deathdata.victim.ishvt && deathdata.victim != deathdata.attacker )
    {
        deathdata.attacker thread points::doscoreevent( #"hvt_kill" );
    }
}

// Namespace hvt
// Params 1
// Checksum 0x8f2f111c, Offset: 0xf09
// Size: 0x43, Type: bool
function function_1e88dd003e88d764( deathdata )
{
    if ( deathdata.victim.ishvt )
    {
        deathdata.attacker thread points::doscoreevent( #"killed_hvt" );
        return true;
    }
    
    return false;
}

// Namespace hvt
// Params 2
// Checksum 0x524b661e, Offset: 0xf55
// Size: 0x308
function function_eac57ae34f36f457( attacker, iskillstreakweapon )
{
    enemyteam = team_utility::getotherteam( self.team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_ally_killed", teams::getteamdata( self.team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_enemy_killed", teams::getteamdata( enemyteam, "players" ) );
    excludelist = [ self ];
    dialog::statusdialog( "hvt_friendly_eliminated", self.team, undefined, excludelist );
    dialog::statusdialog( "hvt_enemy_eliminated", enemyteam );
    
    if ( player_utility::playersareenemies( self, attacker ) )
    {
        if ( isdefined( self.attackers ) )
        {
            foreach ( player in self.attackers )
            {
                if ( player == attacker || !player_utility::playersareenemies( player, self ) )
                {
                    continue;
                }
                
                player thread points::doscoreevent( #"hash_fd3eb0cb2e45667e" );
            }
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "hvtKills" ] ) )
            {
                attacker.leaderboarddata[ "hvtKills" ] = attacker.leaderboarddata[ "hvtKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "hvtKills" ] ) )
            {
                [[ level.leaderboardfunc[ "hvtKills" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "hvtKills" ] ) )
            {
                attacker.pers[ "hvtKills" ] = attacker.pers[ "hvtKills" ] + 1;
            }
        }
        
        attacker stats::setextrascore0( attacker.pers[ "extrascore0" ] + 1, "hvtKills" );
        attacker hud_message::showsplash( "hvt_player_killed", level.hvtpointsperhvtkilled );
    }
    
    if ( self === attacker && player::isinlaststand( self ) )
    {
        if ( isdefined( self.laststandattacker ) )
        {
            self.laststandattacker thread points::doscoreevent( #"hvt_kill" );
        }
    }
    
    teamscore = iskillstreakweapon ? 1 : level.hvtpointsperhvtkilled;
    gamescore::giveteamscoreforobjective( enemyteam, teamscore );
    totalpoints = attacker getclientomnvar( "ui_hvt_earned_points" ) + teamscore;
    attacker setclientomnvar( "ui_hvt_earned_points", totalpoints );
    clearhvt();
    self.var_46f90c843fe2dd22 = 1;
}

// Namespace hvt
// Params 0
// Checksum 0xdb8a3e24, Offset: 0x1265
// Size: 0x2a
function ontimelimit()
{
    winner = gamescore::gethighestscoringteam();
    thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace hvt
// Params 1
// Checksum 0xb3973895, Offset: 0x1297
// Size: 0x108
function onplayerspawned( spawndata )
{
    println( "<dev string:x4a>" + self.name + "<dev string:x60>" + self.origin );
    
    foreach ( p in teams::getteamdata( self.team, "players" ) )
    {
        if ( p != self && isdefined( p.objidnumfriend ) )
        {
            objective_addclienttomask( p.objidnumfriend, self );
        }
    }
    
    if ( function_9d547a1dfca94392( self.team ) )
    {
        if ( self.var_46f90c843fe2dd22 )
        {
            self.var_46f90c843fe2dd22 = undefined;
            return;
        }
        
        thread becomehvt();
    }
}

// Namespace hvt
// Params 1
// Checksum 0x1048a2ff, Offset: 0x13a7
// Size: 0x21
function onplayerdisconnect( params )
{
    if ( self.ishvt )
    {
        clearhvt( 1 );
    }
}

// Namespace hvt
// Params 9
// Checksum 0xfbab78c0, Offset: 0x13d0
// Size: 0x111
function modelaststandallowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( self.ishvt )
    {
        return 1;
    }
    else if ( player::function_73fe5f51164eb3ca( self ) )
    {
        if ( damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
        {
            return player::function_77ae038c7dbd566( "headshot" );
        }
        else if ( smeansofdeath == "MOD_FIRE" )
        {
            return player::function_77ae038c7dbd566( "fire" );
        }
        else if ( smeansofdeath == "MOD_MELEE" )
        {
            return player::function_77ae038c7dbd566( "melee" );
        }
        else if ( isexplosivedamagemod( smeansofdeath ) )
        {
            return player::function_77ae038c7dbd566( "explosive" );
        }
        else if ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" )
        {
            return player::function_77ae038c7dbd566( "world" );
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace hvt
// Params 0
// Checksum 0xbe761ebc, Offset: 0x14ea
// Size: 0x1c0
function function_125c804510c1599()
{
    if ( self.ishvt )
    {
        if ( self.team == "allies" )
        {
            setomnvar( "allies_hvt_last_stand", 1 );
        }
        else
        {
            setomnvar( "axis_hvt_last_stand", 1 );
        }
        
        function_756bfbda6a656ee2( self.objidnumfriend, level.gametypebundle.reviveicon ?? "ui_icon_waypoint_revive", &"mp_ingame_only/obj_revive" );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_ally_downed", teams::getteamdata( self.team, "players" ) );
        function_756bfbda6a656ee2( self.objidnumenemy, "ui_icon_waypoint_finish", &"mp_ingame_only/obj_finish" );
        enemyteam = team_utility::getotherteam( self.team );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_enemy_downed", teams::getteamdata( enemyteam, "players" ) );
        
        if ( player_utility::playersareenemies( self.laststandattacker, self ) )
        {
            self.laststandattacker points::doscoreevent( #"hvt_downed" );
        }
        
        weapons = self getweaponslistall();
        
        foreach ( weapon in weapons )
        {
            if ( weapon == self.laststandweaponobj )
            {
                self.var_348359045a2cf8e1 = 1;
                self.var_e9ac74bd4b622ff2 = self getammocount( weapon );
                self givestartammo( weapon );
                break;
            }
        }
    }
}

// Namespace hvt
// Params 1
// Checksum 0x905f4a0c, Offset: 0x16b2
// Size: 0x135
function function_4350f41bc6c5eb39( revived )
{
    if ( self.ishvt )
    {
        if ( revived )
        {
            if ( self.team == "allies" )
            {
                setomnvar( "allies_hvt_last_stand", 0 );
            }
            else
            {
                setomnvar( "axis_hvt_last_stand", 0 );
            }
            
            function_756bfbda6a656ee2( self.objidnumenemy, level.gametypebundle.enemyteamstatusicon ?? "ui_icon_waypoint_kill", &"MP_INGAME_ONLY/OBJ_KILL_CAPS" );
            function_756bfbda6a656ee2( self.objidnumfriend, level.gametypebundle.var_ad8ba24e5f2e3d2b ?? "ui_icon_waypoint_defend", &"mp_ingame_only/obj_protect" );
            
            if ( isdefined( self.var_60ba802d319828fc ) && self.var_60ba802d319828fc != self )
            {
                self.var_60ba802d319828fc points::doscoreevent( #"hvt_revive" );
            }
            
            level thread hud_util::teamplayercardsplash( "callout_hvt_revived", self );
            
            if ( self.var_348359045a2cf8e1 )
            {
                self setweaponammoclip( self.laststandweaponobj, self.var_e9ac74bd4b622ff2 );
            }
            
            self.var_348359045a2cf8e1 = undefined;
            self.var_e9ac74bd4b622ff2 = undefined;
        }
    }
    
    self.var_60ba802d319828fc = undefined;
}

// Namespace hvt
// Params 1
// Checksum 0xabd21b17, Offset: 0x17ef
// Size: 0x20
function onplayerrevived( params )
{
    self.var_60ba802d319828fc = params.reviver;
}

// Namespace hvt
// Params 0
// Checksum 0x7eba3c30, Offset: 0x1817
// Size: 0xb
function function_43b1290eb3e89c2c()
{
    return level.var_3e1f75796cb3a708;
}

// Namespace hvt
// Params 1
// Checksum 0xdc48e601, Offset: 0x182b
// Size: 0x1c, Type: bool
function function_a229e03864cfe8d6( objweapon )
{
    if ( self.ishvt )
    {
        return false;
    }
    
    return true;
}

// Namespace hvt
// Params 1
// Checksum 0x617252f9, Offset: 0x1850
// Size: 0xc7
function function_a8daead954baed9a( team )
{
    hvtcount = 0;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( player.ishvt )
        {
            hvtcount++;
        }
    }
    
    assert( hvtcount <= level.hvtnumhvtperteam, hvtcount + "<dev string:x6d>" + level.hvtnumhvtperteam );
    return hvtcount;
}

// Namespace hvt
// Params 1
// Checksum 0x3ab0a8d8, Offset: 0x1920
// Size: 0x2f, Type: bool
function function_9d547a1dfca94392( team )
{
    if ( level.var_65b5e8139a5aee5b[ team ] )
    {
        return false;
    }
    
    return function_a8daead954baed9a( team ) < level.hvtnumhvtperteam;
}

// Namespace hvt
// Params 0
// Checksum 0xd67a04af, Offset: 0x1958
// Size: 0x61
function function_29fd6d83fa2b514c()
{
    setomnvar( "ui_" + self.team + "_hvt_count", function_a8daead954baed9a( self.team ) );
    enemyteam = team_utility::getotherteam( self.team );
    setomnvar( "ui_" + enemyteam + "_hvt_count", function_a8daead954baed9a( enemyteam ) );
}

// Namespace hvt
// Params 3
// Checksum 0x6bd4ed1, Offset: 0x19c1
// Size: 0x2d
function function_cb7f21eed6db2300( omnvar, squadindex, omnvarvalue )
{
    self setclientomnvar( omnvar + "0", omnvarvalue );
}

// Namespace hvt
// Params 1
// Checksum 0xb4b448fe, Offset: 0x19f6
// Size: 0x54
function function_7a93eb5505da6cac( player )
{
    if ( player.ishvt )
    {
        spawnarmor = level.hvtspawnarmor ?? 250;
        return [ spawnarmor, level.var_3e1f75796cb3a708 ];
    }
    
    return [ 0, 0 ];
}

// Namespace hvt
// Params 0
// Checksum 0x6fe4c45e, Offset: 0x1a53
// Size: 0x1c7
function becomehvt()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.ishvt = 1;
    self.var_4ff8306fab04a552 = 0;
    self.game_extrainfo |= 4194304;
    function_9081a6d16387a17e();
    self setclientomnvar( "ui_hvt_status", 1 );
    function_e807f48f07ea1059();
    spawnarmor = level.hvtspawnarmor ?? 250;
    armor::initarmor();
    armor::givestartingarmor();
    self.spawnarmor = spawnarmor;
    thread function_bee4bba418d17ebe();
    player::showminimap();
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        enemyteam = team_utility::getotherteam( self.team );
        excludelist = [ self ];
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_ally_spawned", teams::getteamdata( self.team, "players" ), self );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_enemy_spawned", teams::getteamdata( enemyteam, "players" ) );
        dialog::statusdialog( "hvt_new_friendly", self.team, "hvtUpdate", excludelist );
        dialog::statusdialog( "hvt_new_enemy", enemyteam, "hvtUpdate" );
    }
    
    flags::gameflagwait( "prematch_done" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread function_bdc252c9b426ac02();
    setomnvar( "ui_" + self.team + "_current_hvt", self getplayerclientnum() );
    self setclientomnvar( "ui_hvt_earned_points", 0 );
    flags::gameflagwait( "intro_boost_vo_done" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    hud_message::showsplash( "hvt_player_selected" );
    thread dialog::leaderdialogonplayer( "hvt_self", "hvtUpdate" );
    function_29fd6d83fa2b514c();
}

// Namespace hvt
// Params 0
// Checksum 0xb38e36fa, Offset: 0x1c22
// Size: 0x72
function function_e807f48f07ea1059()
{
    self.var_caab516ab542223 = outline::outlineviewmodelenable( self, "outlinefill_friendly_hvt", #"level_script" );
    self.friendlyoutlineid = outline::outlineenableforteam( self, self.team, "outlinefill_friendly_hvt", "level_script", undefined, 1 );
    self.var_e82835bccfbadc6d = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), "outlinefill_enemy_hvt", "level_script", undefined, 1 );
}

// Namespace hvt
// Params 1
// Checksum 0x5b2fab3d, Offset: 0x1c9c
// Size: 0xf6
function clearhvt( fromdisconnect )
{
    self.ishvt = undefined;
    self.spawnarmor = undefined;
    self.var_4ff8306fab04a552 = undefined;
    self.var_7572d500b8e84be1 = undefined;
    self.game_extrainfo &= ~4194304;
    function_6449da49b0aa7f2f();
    self setclientomnvar( "ui_hvt_status", 0 );
    self setclientomnvar( "ui_hvt_earned_points", 0 );
    outline::outlinedisable( self.friendlyoutlineid, self );
    outline::outlinedisable( self.var_e82835bccfbadc6d, self );
    
    if ( !fromdisconnect )
    {
        outline::outlineviewmodeldisable( self.var_caab516ab542223, self );
        self.var_caab516ab542223 = undefined;
    }
    
    self.skipuavupdate = undefined;
    
    if ( !level.minimaponbydefault )
    {
        player::hideminimap();
    }
    
    level thread function_f298575a0f142616( self.team );
    level thread function_10cf67f5f43e7654( self.team );
    function_29fd6d83fa2b514c();
}

// Namespace hvt
// Params 1
// Checksum 0xa1a321dc, Offset: 0x1d9a
// Size: 0x22
function function_f298575a0f142616( str_team )
{
    waitframe();
    setomnvar( "ui_" + str_team + "_current_hvt", -1 );
}

// Namespace hvt
// Params 1
// Checksum 0x7e3e8561, Offset: 0x1dc4
// Size: 0x4e
function function_10cf67f5f43e7654( str_team )
{
    level.var_65b5e8139a5aee5b[ str_team ] = 1;
    delay = 5;
    
    /#
        delay = getdvarint( @"scr_hvt_delay", delay );
    #/
    
    wait delay;
    level.var_65b5e8139a5aee5b[ str_team ] = 0;
}

// Namespace hvt
// Params 0
// Checksum 0x780c150, Offset: 0x1e1a
// Size: 0x3d
function function_bee4bba418d17ebe()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( self.ishvt )
    {
        level waittill( #"uav_update" );
        uav::function_2701d7fa650db090();
    }
}

// Namespace hvt
// Params 0
// Checksum 0x7b27b5de, Offset: 0x1e5f
// Size: 0xe9
function function_bdc252c9b426ac02()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    flags::gameflagwait( "prematch_done" );
    var_834a7e601b84a325 = 5;
    self.var_7572d500b8e84be1 = 0;
    var_9649ff786cade20d = 60;
    self.var_ec5feaee3ca62548 = 0;
    
    while ( isdefined( self ) && isdefined( self.ishvt ) )
    {
        if ( self.var_ec5feaee3ca62548 == var_9649ff786cade20d )
        {
            thread points::doscoreevent( #"hvt_survival" );
        }
        
        self.var_ec5feaee3ca62548++;
        
        if ( self.var_7572d500b8e84be1 >= var_834a7e601b84a325 )
        {
            self.var_7572d500b8e84be1 = 0;
            points::doscoreevent( #"hvt_survival_bonus" );
        }
        else
        {
            self.var_7572d500b8e84be1++;
        }
        
        stats::setextrascore1( self.pers[ "extrascore1" ] + 1, "hvtSurvives" );
        wait 1;
    }
}

// Namespace hvt
// Params 0
// Checksum 0xfcef5b76, Offset: 0x1f50
// Size: 0x1da
function function_9081a6d16387a17e()
{
    self.curorigin = self.origin;
    self.offset3d = ( 0, 0, 14 );
    
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
    }
    
    self.objidnumfriend = objidpoolmanager::requestobjectiveid( 1 );
    function_8960afb748158ae6( self.objidnumfriend, &"mp_ingame_only/obj_protect", level.gametypebundle.var_ad8ba24e5f2e3d2b ?? "ui_icon_waypoint_defend" );
    objective_removeallfrommask( self.objidnumfriend );
    
    foreach ( p in teams::getteamdata( self.team, "players" ) )
    {
        if ( p != self )
        {
            objective_addclienttomask( self.objidnumfriend, p );
        }
    }
    
    objective_showtoplayersinmask( self.objidnumfriend );
    self.objidnumenemy = objidpoolmanager::requestobjectiveid( 1 );
    function_8960afb748158ae6( self.objidnumenemy, &"MP_INGAME_ONLY/OBJ_KILL_CAPS", level.gametypebundle.enemyteamstatusicon ?? "ui_icon_waypoint_kill" );
    objidpoolmanager::objective_teammask_single( self.objidnumenemy, team_utility::getotherteam( self.team ) );
    
    if ( self.team == "allies" )
    {
        setomnvar( "allies_hvt_last_stand", 0 );
    }
    else
    {
        setomnvar( "axis_hvt_last_stand", 0 );
    }
    
    thread function_7d136a357d717ec3();
}

// Namespace hvt
// Params 3
// Checksum 0x8f0736c6, Offset: 0x2132
// Size: 0x2e
function function_756bfbda6a656ee2( objid, objicon, objlabel )
{
    objective_icon( objid, objicon );
    objective_setlabel( objid, objlabel );
}

// Namespace hvt
// Params 3
// Checksum 0x2d0f075b, Offset: 0x2168
// Size: 0x74
function function_8960afb748158ae6( objid, objlabel, objicon )
{
    objective_setbackground( objid, 0 );
    objective_setzoffset( objid, 30 );
    objective_position( objid, self geteye() + self.offset3d );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, self.team );
    function_756bfbda6a656ee2( objid, objicon, objlabel );
}

// Namespace hvt
// Params 0
// Checksum 0x78ba5914, Offset: 0x21e4
// Size: 0x103
function function_7d136a357d717ec3()
{
    self notify( #"hash_67e154838573dde8" );
    self endon( #"hash_67e154838573dde8" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.objpingdelay ) )
    {
        level.objpingdelay = 1.5;
    }
    
    var_82bb5d9e3a1bdcee = level.objpingdelay * 1000;
    previousupdatetime = gettime();
    
    while ( isdefined( self.objidnumfriend ) )
    {
        if ( !utility::isusingremote() )
        {
            objpos = self geteye() + self.offset3d;
            objidpoolmanager::update_objective_position( self.objidnumfriend, objpos );
            objective_ping( self.objidnumfriend );
            currtime = gettime();
            
            if ( currtime - previousupdatetime >= var_82bb5d9e3a1bdcee )
            {
                objidpoolmanager::update_objective_position( self.objidnumenemy, objpos );
                objective_ping( self.objidnumenemy );
                previousupdatetime = currtime;
            }
        }
        
        waitframe();
    }
}

// Namespace hvt
// Params 0
// Checksum 0x72348fa7, Offset: 0x22ef
// Size: 0x43
function function_6449da49b0aa7f2f()
{
    if ( isdefined( self.objidnumfriend ) )
    {
        objidpoolmanager::returnobjectiveid( self.objidnumfriend );
        objidpoolmanager::returnobjectiveid( self.objidnumenemy );
        self.objidnumfriend = undefined;
        self.objidnumenemy = undefined;
    }
}

