// scripts\mp\playerlogic.gsc  (hash_344020c171ec72d5.gscc) (size: 107927 Bytes / 0x1a597 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ea3c414 (2124661780)
// size ...... 107927 (0x1a597)
// includes .. 84  (offset: 0x17ea3)
// strings ... 438 (offset: 0x18143)
// dev strs .. 57  (offset: 0x1a27f)
// exports ... 149 (offset: 0x1159f)
// cseg ...... 0x21dc + 0xf3c3 (0x1159f)
// imports ... 610 (offset: 0x12ce7)
// animtree1 . 0   (offset: 0x1a597)
// animtree2 . 0   (offset: 0x1a597)
#using script_26ccbfe3954cacf4;
#using script_3cb3908b3094b567;
#using script_607ef68f7eca6183;
#using script_72af5a878a9d3397;
#using script_7cab86232cdd30ba;
#using scripts\common\battle_tracks;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\game_utility;
#using scripts\common\math;
#using scripts\common\progression_utility;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\accolades;
#using scripts\mp\action_park_utility;
#using scripts\mp\analyticslog;
#using scripts\mp\armor;
#using scripts\mp\bots\bots;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\prestige_challenge_utility;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\gameinstance;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gamestaterestore;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\meatshield;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\personal_bests;
#using scripts\mp\playerachievements;
#using scripts\mp\playerhealth;
#using scripts\mp\playerstats_interface;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\squads;
#using scripts\mp\supers;
#using scripts\mp\teams;

#namespace playerlogic;

// Namespace playerlogic
// Params 0
// Checksum 0x18f81169, Offset: 0x21fa
// Size: 0x71
function init()
{
    setdvarifuninitialized( @"bink_complete_log", 1 );
    ui::lui_registercallback( "versus_done", &function_196e0151616871c5 );
    ui::lui_registercallback( "skip_bink_input", &function_5d4463fb0290865e );
    ui::lui_registercallback( "bink_complete", &function_5937b5e3d0c453e );
    
    if ( !isdefined( level.var_791076e7de107dc2 ) )
    {
        level.var_791076e7de107dc2 = "waiting_to_spawn";
    }
    
    /#
        setdvarifuninitialized( @"hash_2465f6d6178ab408", 0 );
    #/
}

// Namespace playerlogic
// Params 1, eflags: 0x4
// Checksum 0x556d507d, Offset: 0x2273
// Size: 0x23
function private function_196e0151616871c5( param )
{
    self.versusdone = 1;
    utility::ent_flag_set( "loading_done" );
}

// Namespace playerlogic
// Params 1, eflags: 0x4
// Checksum 0x7502e02f, Offset: 0x229e
// Size: 0xf1
function private function_5937b5e3d0c453e( param )
{
    playermsg = " player " + self getentitynumber() + ":" + ( self.name ?? "<unknown>" );
    
    if ( isdefined( self.waitingmovie ) && isxhashasset( param ) && getxhashasset( self.waitingmovie ) == param )
    {
        bink_complete_log( self.waitingmovie, "LUI_EVENT " + "bink_complete" + "_" + self.waitingmovie + playermsg );
        utility::ent_flag_set( "bink_complete" + "_" + self.waitingmovie );
    }
    else
    {
        bink_complete_log( undefined, "LUI_EVENT " + "bink_complete" + playermsg );
        utility::ent_flag_set( "bink_complete" );
    }
    
    self notify( #"bink_complete", param );
    level notify( #"bink_complete", param );
}

// Namespace playerlogic
// Params 1, eflags: 0x4
// Checksum 0x8c494214, Offset: 0x2397
// Size: 0x18
function private function_5d4463fb0290865e( param )
{
    utility::ent_flag_set( "skip_bink_input" );
}

// Namespace playerlogic
// Params 2
// Checksum 0xbaafd3e, Offset: 0x23b7
// Size: 0xa8
function bink_complete_log( var_58bb242dbcd8b7e1, msg )
{
    if ( !getdvarint( @"bink_complete_log", 0 ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        squadid = "" + ( self.sessionsquadid ?? "<unknown>" );
    }
    else
    {
        squadid = "" + ( self.index ?? "<unknown>" );
    }
    
    prefix = "[" + ( var_58bb242dbcd8b7e1 ?? "LOAD" ) + "] ";
    logstring( "[CINEMATICS] Squad " + squadid + ": " + prefix + msg );
}

// Namespace playerlogic
// Params 1
// Checksum 0xdc625223, Offset: 0x2467
// Size: 0x51, Type: bool
function function_99a4f33758d5e5ba( var_7e0d24a9bb7c209a )
{
    if ( !isxhashasset( var_7e0d24a9bb7c209a ) )
    {
        return false;
    }
    
    mapinfo = getactivemapinfobundle();
    
    if ( mapinfo.var_27ceb9081ce7fe53 == var_7e0d24a9bb7c209a )
    {
        return true;
    }
    
    if ( mapinfo.var_3b3d5e9c999d96ec == var_7e0d24a9bb7c209a )
    {
        return true;
    }
    
    return false;
}

// Namespace playerlogic
// Params 1
// Checksum 0xb0f55e84, Offset: 0x24c1
// Size: 0x102
function timeuntilwavespawn( minimumwait )
{
    if ( !self.hasspawned )
    {
        return 0;
    }
    
    earliestspawntime = gettime() + minimumwait * 1000;
    lastwavetime = level.lastwave[ self.pers[ "team" ] ];
    wavedelay = level.wavedelay[ self.pers[ "team" ] ] * 1000;
    numwavespassedearliestspawntime = ( earliestspawntime - lastwavetime ) / wavedelay;
    numwaves = ceil( numwavespassedearliestspawntime );
    timeofspawn = lastwavetime + numwaves * wavedelay;
    
    if ( !level.var_781155795b397ccb && isdefined( self.respawntimerstarttime ) )
    {
        if ( self.respawntimerstarttime < lastwavetime )
        {
            return 0;
        }
    }
    
    if ( isdefined( self.wavespawnindex ) )
    {
        timeofspawn += 50 * self.wavespawnindex;
    }
    
    return ( timeofspawn - gettime() ) / 1000;
}

// Namespace playerlogic
// Params 0
// Checksum 0x95b43f4c, Offset: 0x25cc
// Size: 0x7d
function teamkilldelay()
{
    teamkills = self.pers[ "teamkills" ];
    
    if ( !isdefined( teamkills ) || level.maxallowedteamkills < 0 || teamkills <= level.maxallowedteamkills )
    {
        return 0;
    }
    
    exceeded = teamkills - level.maxallowedteamkills;
    return getdvarfloat( @"scr_team_teamkillspawndelay", 0 ) * ( game_utility::function_7cceeebf2891ed68() ? 1 : exceeded );
}

// Namespace playerlogic
// Params 1
// Checksum 0x1446852a, Offset: 0x2652
// Size: 0x200
function timeuntilspawn( includeteamkilldelay )
{
    if ( level.ingraceperiod && !self.hasspawned || level.gameended )
    {
        return 0;
    }
    
    respawndelay = 0;
    
    if ( self.hasspawned )
    {
        result = self [[ level.onrespawndelay ]]();
        
        if ( isdefined( result ) )
        {
            respawndelay = result;
        }
        else
        {
            respawndelay = getmatchrulesdata( "commonOption", "respawnDelay" );
        }
        
        currenttime = gettime();
        
        if ( level.var_45eb883b93d0a11[ self.team ] > currenttime )
        {
            var_22c7199ec41706e0 = ( level.var_45eb883b93d0a11[ self.team ] - currenttime ) * 0.001;
            respawndelay = max( respawndelay, var_22c7199ec41706e0 );
        }
        
        if ( includeteamkilldelay && isdefined( self.pers[ "teamKillPunish" ] ) && self.pers[ "teamKillPunish" ] )
        {
            respawndelay += teamkilldelay();
        }
        
        if ( isdefined( self.suicidespawndelay ) )
        {
            respawndelay += getmatchrulesdata( "commonOption", "suicideSpawnDelay" );
        }
        
        if ( isdefined( self.respawntimerstarttime ) && !isdefined( level.spawndelay ) )
        {
            timealreadypassed = ( currenttime - self.respawntimerstarttime ) / 1000;
            respawndelay -= timealreadypassed;
            
            if ( respawndelay < 0 )
            {
                respawndelay = 0;
            }
        }
    }
    
    wavebased = getmatchrulesdata( "commonOption", "waveRespawnDelay" ) > 0;
    
    if ( wavebased )
    {
        respawndelay = timeuntilwavespawn( respawndelay );
    }
    
    if ( level.ingraceperiod && !self.hasspawned || level.gameended )
    {
        respawndelay = 0;
    }
    else if ( getdvarint( @"hash_4ac8d16ce8dd74fd", 0 ) == 1 )
    {
        respawndelay = 999;
    }
    
    if ( !isdefined( self.initialrespawndelay ) )
    {
        self.initialrespawndelay = respawndelay;
    }
    
    return respawndelay;
}

// Namespace playerlogic
// Params 1
// Checksum 0x3d9011e4, Offset: 0x285b
// Size: 0x1c6, Type: bool
function mayspawn( revivespawn = 0 )
{
    if ( level.nukeinfo.gameover )
    {
        return false;
    }
    
    if ( level.disablespawning )
    {
        if ( !istestclient( self ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.disablespawningforplayerfunc ) && [[ level.disablespawningforplayerfunc ]]( self, revivespawn ) )
    {
        return false;
    }
    
    if ( game_utility_mp::getgametypenumlives() )
    {
        if ( level.teambased && isdefined( level.teamswithplayers ) && level.teamswithplayers.size == 1 )
        {
            return true;
        }
        
        if ( self.pers[ "teamKillPunish" ] )
        {
            var_6a6d0e98f43a31d3 = game_utility::getgametype() == "cdl_control";
            var_94c536d7acd7b978 = getdvarint( @"hash_8568a599205cb922", 0 );
            
            if ( var_6a6d0e98f43a31d3 && var_94c536d7acd7b978 )
            {
                return false;
            }
            
            if ( !var_6a6d0e98f43a31d3 )
            {
                return false;
            }
        }
        
        if ( game_utility_mp::gamehasstarted() )
        {
            if ( self.pers[ "lives" ] <= 0 )
            {
                return false;
            }
            
            if ( level.ingraceperiod && !self.hasspawned )
            {
                return true;
            }
            
            if ( !level.ingraceperiod && !self.hasspawned && isdefined( level.allowlatecomers ) && !level.allowlatecomers )
            {
                if ( isdefined( self.siegelatecomer ) && !self.siegelatecomer )
                {
                    return true;
                }
                
                if ( istestclient( self ) || isbot( self ) )
                {
                    return true;
                }
                
                return false;
            }
        }
    }
    
    if ( level.var_dbeaf99627787f48 && level.teamdata[ self.team ][ "noRespawns" ] )
    {
        return false;
    }
    
    return true;
}

// Namespace playerlogic
// Params 1
// Checksum 0xe9c8bbdb, Offset: 0x2a2a
// Size: 0x638
function spawnclient( revivespawn )
{
    function_164bad72d3d50876( "spawnClient" );
    self endon( #"hash_39d42ba422f7792f", #"disconnect" );
    
    if ( isbot( self ) && bots_util::function_deef484b5b3a3977() )
    {
        self._blackboard = self getaiblackboard();
    }
    
    if ( isdefined( level.modespawnclient ) )
    {
        self [[ level.modespawnclient ]]( revivespawn );
        return;
    }
    
    if ( isdefined( self.pers[ "next_round_class" ] ) && !self.hasspawned )
    {
        self.class = self.pers[ "next_round_class" ];
    }
    
    /#
        assert( isdefined( self.team ) );
        assert( class::isvalidclass( self.class ) );
    #/
    
    if ( self.waitingtospawn )
    {
        return;
    }
    
    self.waitingtospawn = 1;
    
    if ( self.waitingtoselectclass )
    {
        self waittill( #"hash_18d39249f0d87711" );
    }
    
    if ( !level.var_b6910295c145f7c )
    {
        if ( level.agentarray && !level.var_f334a2aa4deb0aeb )
        {
            waitframe();
        }
        
        waitframe();
        level.var_b6910295c145f7c = 1;
    }
    
    if ( getdvarint( @"hash_8810ee632d53e9d7", 0 ) )
    {
        var_65f73961ed042ad7 = getdvarint( @"hash_7efd459d8899b573", 0 );
        
        if ( var_65f73961ed042ad7 > 0 )
        {
            startdelay = gettime();
            
            while ( !self function_4ba64d2ee6bcafd2() && gettime() - startdelay < var_65f73961ed042ad7 )
            {
                waitframe();
            }
        }
    }
    
    println( "<dev string:x24>" + self.name + "<dev string:x55>" + self.class );
    
    if ( !mayspawn( revivespawn ) )
    {
        self.waitingtospawn = 0;
        waitframe();
        currentorigin = self.origin;
        currentangles = self.angles;
        self notify( #"attempted_spawn" );
        
        if ( isdefined( level.var_881bfe4c4340df0c ) )
        {
            var_bc433651808bafa5 = [[ level.var_881bfe4c4340df0c ]]( self );
        }
        else if ( self.pers[ "teamKillPunish" ] )
        {
            self.pers[ "teamkills" ] = max( self.pers[ "teamkills" ] - 1, 0 );
            lower_message::setlowermessageomnvar( "no_friendly_fire" );
            
            if ( !self.hasspawned && self.pers[ "teamkills" ] <= level.maxallowedteamkills )
            {
                self.pers[ "teamKillPunish" ] = 0;
            }
        }
        else if ( ( game_utility_mp::isroundbased() || game_utility_mp::getgametypenumlives() != 0 ) && game[ "finalRound" ] == 0 || level.disablespawning )
        {
            var_bc433651808bafa5 = undefined;
            
            if ( game_utility::getgametype() != "arena" && isdefined( self.tagavailable ) && self.tagavailable )
            {
                lower_message::setlowermessageomnvar( "spawn_tag_wait" );
            }
            else if ( self.revivetriggerblockedinremote && level.teamdata[ self.team ][ "aliveCount" ] > 0 )
            {
                lower_message::setlowermessageomnvar( "spawn_revive_wait_notimer" );
            }
            else if ( self.revivetriggeravailable )
            {
                if ( isdefined( self.timeuntilbleedout ) )
                {
                    if ( isdefined( self.rallypoint ) )
                    {
                        lower_message::setlowermessageomnvar( "rally_point", int( gettime() + self.timeuntilbleedout * 1000 ) );
                    }
                    else if ( !self.eliminated )
                    {
                        lower_message::setlowermessageomnvar( "spawn_revive_wait_bleedout", int( gettime() + self.timeuntilbleedout * 1000 ) );
                    }
                }
                else if ( level.teamdata[ self.team ][ "aliveCount" ] > 0 )
                {
                    lower_message::setlowermessageomnvar( "spawn_revive_wait_notimer" );
                }
                else
                {
                    lower_message::setlowermessageomnvar( "spawn_next_round" );
                }
            }
            else if ( game_utility::getgametype() == "siege" )
            {
                lower_message::setlowermessageomnvar( "spawn_point_capture_wait" );
                var_bc433651808bafa5 = 10;
            }
            else if ( level.exfilstarted )
            {
                lower_message::setlowermessageomnvar( "exfil_eliminated" );
            }
            else if ( game_utility_mp::isroundbased() && !level.var_dbeaf99627787f48 )
            {
                lower_message::setlowermessageomnvar( "spawn_next_round" );
            }
            else if ( game_utility::getgametype() == "oic" && game_utility_mp::matchmakinggame() )
            {
                lower_message::setlowermessageomnvar( "player_eliminated_oic" );
                var_bc433651808bafa5 = 30;
            }
            else
            {
                lower_message::setlowermessageomnvar( "player_eliminated" );
                var_bc433651808bafa5 = 10;
            }
            
            if ( !isdefined( self.revivetriggeravailable ) )
            {
                thread removespawnmessageshortly( var_bc433651808bafa5 ?? 6 );
            }
        }
        
        if ( self.sessionstate != "spectator" )
        {
            currentorigin += ( 0, 0, 60 );
        }
        
        if ( utility::isusingremote() )
        {
            self.spawningafterremotedeath = 1;
            self.deathposition = self.origin;
            self waittill( #"stopped_using_remote" );
        }
        
        if ( !level.nukeinfo.gameover )
        {
            thread spawnspectator( currentorigin, currentangles );
        }
        
        return;
    }
    else if ( ( level.var_e7315dbe948883a1 || self.var_366c31f5c019b38 ) && isdefined( level.forceteamassignmentoverride ) )
    {
        params = { #firstconnect:0, #selectedteam:self.team };
        var_7c9d8af9cc2cc5e9 = self [[ level.forceteamassignmentoverride ]]( params );
        menus::addtoteam( var_7c9d8af9cc2cc5e9 );
        self.var_366c31f5c019b38 = undefined;
    }
    
    blockspawn = ( level.multimatch ?? gameinstance::is_enabled() ) && game[ "eliminated" ][ self.team ];
    
    if ( blockspawn )
    {
        spectating::setspectatepermissions();
        thread spawnspectator( self.origin + ( 0, 0, 60 ), self.angles );
    }
    else
    {
        waitandspawnclient( revivespawn );
    }
    
    if ( isdefined( self ) )
    {
        self.waitingtospawn = 0;
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0x89b247ad, Offset: 0x306a
// Size: 0xac
function waittillcanspawnclient( revivespawn )
{
    self endon( #"started_spawnplayer" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.team == "spectator" || self.team == "codcaster" )
        {
            return;
        }
        
        if ( isdefined( self ) && ( self.sessionstate == "spectator" || !player::isreallyalive( self ) ) )
        {
            if ( revivespawn )
            {
                self.pers[ "teamKillPunish" ] = 0;
            }
            
            self.pers[ "lives" ] = 1;
            thread spawnclient( revivespawn );
            continue;
        }
        
        return;
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0x738a571, Offset: 0x311e
// Size: 0xac6
function waitandspawnclient( revivespawn )
{
    function_164bad72d3d50876( "playerlogic::waitAndSpawnClient" );
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    level endon( #"game_ended" );
    self notify( #"attempted_spawn" );
    println( "<dev string:x5e>" + self.name );
    
    if ( isdefined( level.prewaitandspawnclient ) )
    {
        [[ level.prewaitandspawnclient ]]( revivespawn );
    }
    
    waitforremoteend();
    spawnedasspectator = 0;
    
    if ( self.pers[ "teamKillPunish" ] )
    {
        teamkilldelay = teamkilldelay();
        
        if ( teamkilldelay > 0 )
        {
            lower_message::setlowermessageomnvar( "no_friendly_fire_timer", int( gettime() + teamkilldelay * 1000 ) );
            thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
            spawnedasspectator = 1;
            wait teamkilldelay;
            lower_message::setlowermessageomnvar( "clear_lower_msg" );
            self.respawntimerstarttime = gettime();
        }
        
        self.pers[ "teamKillPunish" ] = 0;
    }
    else if ( teamkilldelay() )
    {
        self.pers[ "teamkills" ] = max( self.pers[ "teamkills" ] - 1, 0 );
    }
    
    if ( !isdefined( self.wavespawnindex ) && isdefined( level.waveplayerspawnindex[ self.team ] ) )
    {
        self.wavespawnindex = level.waveplayerspawnindex[ self.team ];
        level.waveplayerspawnindex[ self.team ]++;
    }
    
    if ( isdefined( self.setspawnpoint ) && !tivalidationcheck() )
    {
        spawnpoint_clearspawnpoint( 1 );
    }
    
    timeuntilspawn = timeuntilspawn( 0 );
    var_293f3ba6bdf4b868 = 0;
    
    if ( !level.disablespawncamera )
    {
        var_293f3ba6bdf4b868 = level.snaptospawncamera ? 1.25 : 2;
    }
    
    if ( level.usespawnselection )
    {
        var_293f3ba6bdf4b868 = 0.5;
    }
    
    if ( level.ingraceperiod && !self.hasspawned || level.gameended )
    {
        var_293f3ba6bdf4b868 = 0;
        timeuntilspawn = 0;
    }
    
    var_a888b44452259c15 = 0;
    
    if ( game_utility_mp::getbasegametype() == "hq" && isdefined( level.zone ) && level.zone.ownerteam == self.team )
    {
        var_a888b44452259c15 = 1;
    }
    
    wavebased = getmatchrulesdata( "commonOption", "waveRespawnDelay" ) > 0;
    
    if ( !wavebased && !self.skippedkillcam && isdefined( self.killcamwatchtime ) && !var_a888b44452259c15 )
    {
        if ( isdefined( self.initialrespawndelay ) )
        {
            timeuntilspawn = max( self.initialrespawndelay - self.killcamwatchtime, 0 );
        }
        else
        {
            timeuntilspawn = max( timeuntilspawn - self.killcamwatchtime, 0 );
        }
        
        self.killcamwatchtime = undefined;
    }
    
    if ( wavebased )
    {
        if ( isdefined( level.var_206a18d74f85474f ) )
        {
            self thread [[ level.var_206a18d74f85474f ]]( timeuntilspawn );
        }
    }
    
    if ( isdefined( self.var_1e503ec3975df6f0 ) )
    {
        timeuntilspawn = self.var_1e503ec3975df6f0;
        self.var_1e503ec3975df6f0 = undefined;
    }
    else
    {
        timeuntilspawn = max( timeuntilspawn, var_293f3ba6bdf4b868 );
    }
    
    spawn_offset = ( 0, 0, 60 );
    pastprematch = istrue( flags::gameflag( "prematch_done" ) );
    caninfil = flags::gameflag( "infil_will_run" ) && !flags::gameflag( "infil_started" );
    
    if ( level.var_693302e6ea51684f )
    {
        if ( !caninfil && !pastprematch && ( !isdefined( level.var_5092ad40df5693fd ) || [[ level.var_5092ad40df5693fd ]]() ) )
        {
            self clearpredictedstreampos();
            thread function_3f52a37e5d71e62b( getdvarint( @"hash_41c2228192c27e59", 1 ) );
        }
    }
    else if ( ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" ) && !caninfil && !pastprematch )
    {
        camerapositions = [[ level.var_5fb58f5bb9552416 ]]( self.team );
        streamorigin = streamhint::playerstreamhintlocation( camerapositions.startorigin );
        thread setuipregamefadeup();
        streamhint::playerwaittillstreamhintcomplete();
        cament = spawn( "script_model", camerapositions.startorigin );
        cament setmodel( "tag_origin" );
        cament.angles = camerapositions.startangles;
        self cameralinkto( cament, "tag_origin" );
        cament moveto( camerapositions.endorigin, 18 );
        cament rotateto( camerapositions.endangles, 18 );
        flags::gameflagset( "prematch_countdown" );
        pastprematch = 1;
        self cameraunlink();
    }
    
    if ( spawncamera::function_7e5668ce5be4b48e() && timeuntilspawn > 0 )
    {
        var_3f68a49b8039ced = 1;
        
        if ( level.swaptospawncameraifallteammatesdead )
        {
            var_3f68a49b8039ced = teams::getteamcount( self.team, 1 ) > 0;
        }
        
        if ( level.minimumtimetospectateteammates > 0 && timeuntilspawn > level.minimumtimetospectateteammates && var_3f68a49b8039ced )
        {
            var_fd6ce7f45ecdba9b = int( gettime() + timeuntilspawn * 1000 );
            
            if ( timeuntilspawn > level.minimumTimeToShowRespawnMessage )
            {
                lower_message::setlowermessageomnvar( level.var_791076e7de107dc2, var_fd6ce7f45ecdba9b );
            }
            
            thread respawn_asspectator( self.origin + spawn_offset, self.angles );
            spawnedasspectator = 1;
            faded = 0;
            value = utility::waittill_any_timeout_no_endon_death( timeuntilspawn - level.durationtoshowspawncamera, "force_spawn", "no_teammates_alive" );
            
            if ( isdefined( value ) )
            {
                if ( value == "force_spawn" )
                {
                    timeuntilspawn = 0;
                }
                else if ( value == "no_teammates_alive" && level.swaptospawncameraifallteammatesdead )
                {
                    level game_utility::fadetoblackforplayerkeepui( self, 1, 0 );
                    faded = 1;
                }
            }
            
            if ( timeuntilspawn > 0 )
            {
                thread spawncamera::startspawncamera( 0.5, 0.5, 0.5, faded );
            }
            
            timeuntilspawn = ( var_fd6ce7f45ecdba9b - gettime() ) / 1000;
        }
        else if ( getdvarint( @"hash_f011125b6f888598", 1 ) == 1 )
        {
            thread spawncamera::startspawncamera( 0, 0.1, 0.5 );
        }
        else
        {
            thread spawncamera::startspawncamera();
        }
    }
    
    if ( level.usespawnselection )
    {
        if ( !spawnlogic::shoulduseteamstartspawn() )
        {
            spawnselection::waitforspawnselection( timeuntilspawn, !pastprematch );
        }
    }
    else
    {
        if ( isdefined( self.setspawnpoint ) && !self.skippedspawnpoint )
        {
            var_e9e03128014fd70d = 0;
            
            if ( utility::issharedfuncdefined( #"tac_insert", #"respawn" ) )
            {
                var_e9e03128014fd70d = self [[ utility::getsharedfunc( #"tac_insert", #"respawn" ) ]]();
            }
            
            spawnedasspectator = 1;
            
            if ( isdefined( self.ti_timer ) )
            {
                timeuntilspawn = max( var_293f3ba6bdf4b868, timeuntilspawn - var_e9e03128014fd70d );
                self setspectatedefaults( self.origin + spawn_offset, self.angles );
                spectating::setspectatepermissions();
            }
        }
        
        if ( timeuntilspawn > 0 )
        {
            var_f6b4ae41c88a53b3 = level.var_791076e7de107dc2;
            
            if ( game_utility_mp::getbasegametype() == "hq" )
            {
                if ( isdefined( level.zone ) )
                {
                    if ( level.zone.ownerteam == self.team )
                    {
                        dialog::leaderdialogonplayer( "hp_dead" );
                        var_f6b4ae41c88a53b3 = "waiting_for_hq";
                        
                        if ( isdefined( self.suicidespawndelay ) )
                        {
                            timeuntilspawn -= getmatchrulesdata( "commonOption", "suicideSpawnDelay" );
                            timeuntilspawn = max( 0, timeuntilspawn );
                        }
                    }
                    else if ( isdefined( self.suicidespawndelay ) && getmatchrulesdata( "commonOption", "suicideSpawnDelay" ) > 0 && level.zone.ownerteam == "neutral" )
                    {
                        var_f6b4ae41c88a53b3 = "waiting_suicide_delay";
                        self.suicidespawndelay = undefined;
                    }
                }
            }
            else if ( isdefined( self.suicidespawndelay ) && getmatchrulesdata( "commonOption", "suicideSpawnDelay" ) > 0 )
            {
                var_f6b4ae41c88a53b3 = "waiting_suicide_delay";
                self.suicidespawndelay = undefined;
            }
            
            if ( timeuntilspawn > level.minimumTimeToShowRespawnMessage )
            {
                lower_message::setlowermessageomnvar( var_f6b4ae41c88a53b3, int( gettime() + timeuntilspawn * 1000 ) );
            }
            
            if ( getdvarint( @"hash_f011125b6f888598", 1 ) == 1 && self.inspawncamera && game_utility::getgametype() == "gwtdm" )
            {
            }
            else
            {
                if ( isdefined( level.var_7472a836e89dda97 ) )
                {
                    self thread [[ level.var_7472a836e89dda97 ]]( timeuntilspawn );
                }
                else if ( !spawnedasspectator )
                {
                    thread respawn_asspectator( self.origin + spawn_offset, self.angles );
                }
                
                spawnedasspectator = 1;
            }
            
            if ( self.var_e95cd0c15f8374cb )
            {
                waitframe();
            }
            else
            {
                utility::waittill_any_timeout_no_endon_death( timeuntilspawn, "force_spawn" );
            }
            
            if ( !self.waitingtoselectclass )
            {
                self notify( #"stop_wait_safe_spawn_button" );
            }
        }
    }
    
    if ( !isbot( self ) && needsbuttontorespawn() )
    {
        if ( function_ee42f75b665e506d() )
        {
            if ( self.hasspawned )
            {
                function_7928d05cbb8d8374();
            }
        }
        else
        {
            if ( !self.waitingtoselectclass )
            {
                lower_message::setlowermessageomnvar( "press_to_spawn" );
            }
            
            if ( !spawnedasspectator )
            {
                thread respawn_asspectator( self.origin + spawn_offset, self.angles );
            }
            
            spawnedasspectator = 1;
            waitrespawnbutton();
        }
    }
    
    if ( !level.disablespawncamera || game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
    {
        thread spawncamera::endspawncamera();
    }
    
    waitclassselected();
    
    if ( isbot( self ) )
    {
        if ( !bots::bot_is_ready_to_spawn() )
        {
            self waittill( #"hash_df28b3ea97310afa" );
        }
        
        /#
            spawnlogic::function_11b5562082e3b940( self );
        #/
    }
    
    if ( utility::issharedfuncdefined( #"instanceInventory", #"inventoryisvalid" ) )
    {
        while ( !level.var_8671749938fb45db && !utility::callsharedfunc( #"instanceInventory", #"inventoryisvalid", self ) )
        {
            waitframe();
        }
    }
    
    self.waitingtospawn = 0;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self.wavespawnindex = undefined;
    thread spawnplayer( undefined, revivespawn );
}

// Namespace playerlogic
// Params 0
// Checksum 0xc8f2fd68, Offset: 0x3bec
// Size: 0x7e
function function_b81aa08420416b47()
{
    var_7237854e3be197ca = level.var_12b7786bc54c0097;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_12b7786bc54c0097 = level.gametypebundle.var_4ee1a78d9606aad6 || isdefined( level.gametypebundle.var_5c4544fbd39f2bc3 );
    
    if ( var_12b7786bc54c0097 && getdvarint( @"hash_fb3f53875a017bbb", 0 ) > 0 )
    {
        var_12b7786bc54c0097 = 0;
    }
    
    level.var_12b7786bc54c0097 = var_12b7786bc54c0097;
    return var_12b7786bc54c0097;
}

// Namespace playerlogic
// Params 0
// Checksum 0x1b779c6d, Offset: 0x3c73
// Size: 0xcd
function function_17bffb98a94b1e2b()
{
    if ( !function_b81aa08420416b47() )
    {
        return;
    }
    
    var_f2ff03344c016cf4 = level.gametypebundle.var_5c4544fbd39f2bc3;
    var_92a7f93304544977 = 0;
    waittillframeend();
    
    do
    {
        if ( level.gametypebundle.var_4ee1a78d9606aad6 )
        {
            while ( level.var_28b0b95d6825011 == function_8fc063681724727f() )
            {
                waitframe();
                waittillframeend();
            }
        }
        
        if ( ( var_f2ff03344c016cf4 ?? 0 ) <= 0 )
        {
            var_92a7f93304544977 = 1;
            continue;
        }
        
        currentframe = function_8fc063681724727f();
        var_f065f333e6f49f76 = level.var_db04c0739d9ee86d[ currentframe ];
        level.var_db04c0739d9ee86d = [];
        level.var_db04c0739d9ee86d[ currentframe ] = var_f065f333e6f49f76;
        
        if ( ( var_f065f333e6f49f76 ?? 0 ) >= var_f2ff03344c016cf4 )
        {
            waitframe();
            waittillframeend();
            continue;
        }
        
        var_92a7f93304544977 = 1;
    }
    while ( !var_92a7f93304544977 );
}

// Namespace playerlogic
// Params 1
// Checksum 0x10007777, Offset: 0x3d48
// Size: 0x126
function function_3f52a37e5d71e62b( mintime )
{
    self endon( #"death_or_disconnect" );
    self waittill( #"spawned_player" );
    self setclientomnvar( "ui_world_fade", 1 );
    starttime = gettime();
    streamhint::playerstreamhintlocation( self geteye() );
    self waittill( #"hash_2d0813a2d19b7c7e" );
    self clearpredictedstreampos();
    
    if ( isdefined( mintime ) )
    {
        timepassed = ( gettime() - starttime ) / 1000;
        
        if ( timepassed < mintime )
        {
            wait mintime - timepassed;
        }
    }
    
    fadeupduration = 0.5;
    
    if ( fadeupduration > 0 )
    {
        var_bbb8bb827b4d548b = 1;
        framecount = fadeupduration / level.framedurationseconds;
        var_fb561b1f5305f2a0 = 1 / framecount;
        currentframe = 0;
        
        while ( currentframe < framecount )
        {
            currentframe++;
            var_bbb8bb827b4d548b -= var_fb561b1f5305f2a0;
            var_bbb8bb827b4d548b = clamp( var_bbb8bb827b4d548b, 0, 1 );
            self setclientomnvar( "ui_world_fade", var_bbb8bb827b4d548b );
            waitframe();
        }
    }
    
    self setclientomnvar( "ui_world_fade", 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0xa9949429, Offset: 0x3e76
// Size: 0x64
function waitforremoteend()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( utility::isusingremote() )
    {
        self.spawningafterremotedeath = 1;
        self.deathposition = self.origin;
        self waittill( #"stopped_using_remote" );
        
        if ( level.nukeinfo.gameover )
        {
            return;
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xb6525c68, Offset: 0x3ee2
// Size: 0x3, Type: bool
function shouldwaitforsquadspawn()
{
    return false;
}

// Namespace playerlogic
// Params 0
// Checksum 0x79e19a41, Offset: 0x3eee
// Size: 0x5d
function queueclientforsquadspawn()
{
    while ( !level.squaddata[ self.team ][ self.sessionsquadid ].isfull && !level.squaddata[ self.team ][ self.sessionsquadid ].isstale )
    {
        waitframe();
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x62fe4a93, Offset: 0x3f53
// Size: 0x2a
function waitclassselected()
{
    function_164bad72d3d50876( "playerlogic::waitClassSelected start" );
    
    while ( self.waitingtoselectclass )
    {
        waitframe();
    }
    
    function_164bad72d3d50876( "playerlogic::waitClassSelected end" );
}

// Namespace playerlogic
// Params 0
// Checksum 0xf9d85d8d, Offset: 0x3f85
// Size: 0x90, Type: bool
function needsbuttontorespawn()
{
    if ( self.var_14955bc056bab547 )
    {
        return false;
    }
    
    if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( function_ee42f75b665e506d() )
    {
        return true;
    }
    
    if ( getmatchrulesdata( "commonOption", "forceRespawn" ) != 0 )
    {
        return false;
    }
    
    if ( !self.hasspawned )
    {
        return false;
    }
    
    wavebased = dvars::function_13909a5327c395b9( "waverespawndelay" ) > 0;
    
    if ( wavebased )
    {
        return false;
    }
    
    if ( self.wantsafespawn )
    {
        return false;
    }
    
    return true;
}

// Namespace playerlogic
// Params 0
// Checksum 0x754e4258, Offset: 0x401e
// Size: 0x33
function waitrespawnbutton()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    
    while ( true )
    {
        if ( self usebuttonpressed() )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xbdb635f5, Offset: 0x4059
// Size: 0x6a
function function_3765e79e200dd60f()
{
    if ( isplayer( self ) && self function_a174861f8b1a5880() )
    {
        if ( !self.usepressed && self usebuttonpressed() )
        {
            self.usepressed = 1;
            self.toggleuse = !self.toggleuse;
            return;
        }
        
        if ( self.usepressed && !self usebuttonpressed() )
        {
            self.usepressed = 0;
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xbf348572, Offset: 0x40cb
// Size: 0x23, Type: bool
function function_ee42f75b665e506d()
{
    if ( game_utility::function_a43ada404e8c591f() && !isbot( self ) && !self isplayerheadless() )
    {
        return true;
    }
    
    return false;
}

// Namespace playerlogic
// Params 0
// Checksum 0x6882333d, Offset: 0x40f7
// Size: 0x4d
function function_7928d05cbb8d8374()
{
    self openmenu( "Shop" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_d2bd141a0077e2dc" ][ #"hash_a15f6baadf2003f7" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 0, undefined, undefined, self );
    }
    
    function_7af889ba87a4fbc5();
}

// Namespace playerlogic
// Params 0
// Checksum 0x1dd524ac, Offset: 0x414c
// Size: 0x4e
function function_7af889ba87a4fbc5()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"buy_menu_close" );
    self endon( #"game_ended" );
    
    while ( true )
    {
        wait game_utility_mp::matchmakinggame() ? 10 : 20;
        break;
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0xb380dac5, Offset: 0x41a2
// Size: 0x40
function removespawnmessageshortly( delay )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waittillframeend();
    self endon( #"end_respawn" );
    wait delay;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace playerlogic
// Params 0
// Checksum 0xc4cd68a6, Offset: 0x41ea
// Size: 0x383, Type: bool
function tivalidationcheck()
{
    if ( !isdefined( self.setspawnpoint ) )
    {
        return false;
    }
    
    if ( isdefined( level.canspawnontacinsert ) && ![[ level.canspawnontacinsert ]]( self ) )
    {
        return false;
    }
    
    carepackages = getentarray( "care_package", #targetname );
    
    foreach ( package in carepackages )
    {
        if ( distancesquared( package.origin, self.setspawnpoint.playerspawnpos ) > 4096 )
        {
            continue;
        }
        
        if ( isdefined( package.owner ) )
        {
            hud_message::showsplash( "destroyed_insertion", undefined, package.owner );
        }
        
        spawnpoint_clearspawnpoint();
        return false;
    }
    
    radiusvector = ( 30, 30, 80 );
    aabbmin = self.setspawnpoint.playerspawnpos - radiusvector;
    aabbmax = self.setspawnpoint.playerspawnpos + radiusvector;
    contents = physics_createcontents( [ "physicscontents_vehicle" ] );
    ignorelist = [];
    vehicles = physics_aabbbroadphasequery( aabbmin, aabbmax, contents, ignorelist );
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        fakevehicle = 1;
        
        foreach ( vehicle in vehicles )
        {
            fake = vehicle.code_classname == "scriptable" || vehicle.code_classname == "worldspawn";
            
            if ( !fake )
            {
                fakevehicle = 0;
                break;
            }
        }
        
        if ( !fakevehicle )
        {
            return false;
        }
    }
    
    startpos = self.setspawnpoint.playerspawnpos + ( 0, 0, 60 );
    endpos = self.setspawnpoint.playerspawnpos + ( 0, 0, 1 );
    ignoreents = [];
    ignoreents[ 0 ] = self;
    ignoreents[ 1 ] = self.setspawnpoint;
    contentoverride = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass" ] );
    
    if ( !trace::ray_trace_passed( startpos, endpos, ignoreents, contentoverride ) )
    {
        return false;
    }
    
    tracestartpos = self.setspawnpoint.playerspawnpos + ( 0, 0, 1 );
    traceendpos = playerphysicstrace( tracestartpos, self.setspawnpoint.playerspawnpos + ( 0, 0, -16 ) );
    
    if ( tracestartpos[ 2 ] == traceendpos[ 2 ] )
    {
        return false;
    }
    
    return true;
}

// Namespace playerlogic
// Params 0
// Checksum 0x7a3963c3, Offset: 0x4576
// Size: 0x1de
function revivespawnvalidationcheck()
{
    if ( !isdefined( self.forcespawnorigin ) )
    {
        return 0;
    }
    
    var_73f86b53e7f5451a = spawnstruct();
    var_73f86b53e7f5451a.spawnposition = self.forcespawnorigin;
    var_73f86b53e7f5451a.isvalidpos = 1;
    ignoreents = [];
    ignoreents[ 0 ] = self;
    contentoverride = trace::create_contents( 1, 1, 1, 0, 0, 1, 1 );
    
    if ( !trace::ray_trace_passed( self.forcespawnorigin + ( 0, 0, 60 ), self.forcespawnorigin, ignoreents, contentoverride ) )
    {
        var_73f86b53e7f5451a.isvalidpos = 0;
        return var_73f86b53e7f5451a;
    }
    
    forward = anglestoforward( self.angles );
    delta = vectornormalize( forward ) * 5;
    
    if ( !trace::ray_trace_passed( self.forcespawnorigin + delta, self.forcespawnorigin + delta - ( 0, 0, 16 ), ignoreents, contentoverride ) )
    {
        var_73f86b53e7f5451a.isvalidpos = 0;
        return var_73f86b53e7f5451a;
    }
    
    tracestartpos = self.forcespawnorigin + ( 0, 0, 1 );
    traceendpos = playerphysicstrace( tracestartpos, self.forcespawnorigin + ( 0, 0, -16 ) );
    
    if ( tracestartpos[ 2 ] == traceendpos[ 2 ] )
    {
        var_73f86b53e7f5451a.isvalidpos = 0;
        return var_73f86b53e7f5451a;
    }
    else
    {
        var_73f86b53e7f5451a.spawnposition = traceendpos;
        var_73f86b53e7f5451a.isvalidpos = 0;
    }
    
    if ( self.faux_spawn_stance == "prone" )
    {
        self.faux_spawn_stance = "prone";
    }
    else
    {
        self.faux_spawn_stance = "crouch";
    }
    
    var_73f86b53e7f5451a.isvalidpos = 1;
    return var_73f86b53e7f5451a;
}

// Namespace playerlogic
// Params 0
// Checksum 0x903982f0, Offset: 0x475d
// Size: 0x25
function spawningclientthisframereset()
{
    self notify( #"hash_52c0072834703d23" );
    self endon( #"hash_52c0072834703d23" );
    waitframe();
    level.numplayerswaitingtospawn--;
}

// Namespace playerlogic
// Params 1
// Checksum 0x7952a16c, Offset: 0x478a
// Size: 0x165
function getplayerassets( classstruct )
{
    assets = { #tertiaryWeapon:classstruct.var_441e64c50e9d846a, #secondaryweapon:classstruct.loadoutsecondaryfullname, #primaryweapon:classstruct.loadoutprimaryfullname };
    
    if ( assets.primaryweapon == "none" )
    {
        assets.primaryweapon = undefined;
    }
    
    if ( assets.secondaryweapon == "none" )
    {
        assets.secondaryweapon = undefined;
    }
    
    if ( assets.tertiaryWeapon == "none" )
    {
        assets.tertiaryWeapon = undefined;
    }
    
    if ( isdefined( classstruct.operatorskin ) )
    {
        assets.operatorskin = classstruct.operatorskin;
        assets.body = operator::function_4e6b11f7340acc24( classstruct.operatorskin );
        assets.head = operator::function_115f78fb5f506daa( classstruct.operatorskin );
    }
    else
    {
        customization = operator::getoperatorcustomization();
        assets.operatorskin = self.operatorcustomization.skinref;
        assets.body = customization[ 0 ];
        assets.head = customization[ 1 ];
    }
    
    return assets;
}

// Namespace playerlogic
// Params 3
// Checksum 0xa5f24aa0, Offset: 0x48f8
// Size: 0x1de
function loadplayerassets( assetsarray, highpriority, var_3d108eb75be0d19a )
{
    weaponassets = [];
    var_e73dbb9102f83922 = [];
    
    foreach ( assets in assetsarray )
    {
        if ( isdefined( assets.primaryweapon ) )
        {
            weaponassets[ weaponassets.size ] = assets.primaryweapon;
        }
        
        if ( isdefined( assets.secondaryweapon ) )
        {
            weaponassets[ weaponassets.size ] = assets.secondaryweapon;
        }
        
        if ( isdefined( assets.tertiaryWeapon ) )
        {
            weaponassets[ weaponassets.size ] = assets.tertiaryWeapon;
        }
        
        if ( !var_3d108eb75be0d19a )
        {
            if ( assets.operatorskin == "" )
            {
                var_e73dbb9102f83922[ var_e73dbb9102f83922.size ] = assets;
                continue;
            }
            
            self function_d8a8c316c2436b4b( assets.operatorskin, highpriority );
        }
    }
    
    foreach ( asset in var_e73dbb9102f83922 )
    {
        script::demoforcesre( "loadPlayerAssets failed due to wrong asset data. asset body : " + getxhashhexname( assets.body ) + ". asset head " + getxhashhexname( assets.head ) );
    }
    
    if ( weaponassets.size > 0 )
    {
        self loadweaponsforplayer( weaponassets, highpriority );
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0x2f09df57, Offset: 0x4ade
// Size: 0x9e, Type: bool
function allplayershaveassetsloaded( assets )
{
    weaponassets = [];
    
    if ( isdefined( assets.primaryweapon ) )
    {
        weaponassets[ weaponassets.size ] = assets.primaryweapon;
    }
    
    if ( isdefined( assets.secondaryweapon ) )
    {
        weaponassets[ weaponassets.size ] = assets.secondaryweapon;
    }
    
    if ( isdefined( assets.tertiaryWeapon ) )
    {
        weaponassets[ weaponassets.size ] = assets.tertiaryWeapon;
    }
    
    if ( !self hasloadedviewweapons( weaponassets ) )
    {
        return false;
    }
    
    if ( !self function_16495e02aff8ee53( assets.operatorskin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace playerlogic
// Params 0
// Checksum 0x88ec707b, Offset: 0x4b85
// Size: 0xb4c
function getspawnpoint()
{
    spawnpoint = undefined;
    spawnorigin = undefined;
    spawnangles = undefined;
    forceangles = undefined;
    self.ti_spawn = 0;
    
    if ( getdvarint( @"hash_3f36284b49b3d7a", 0 ) != 0 )
    {
        if ( isbrgamemode() )
        {
            spawnarray = getspawnarray( "mp_dm_spawn_start" );
            
            if ( spawnarray.size == 0 )
            {
                spawnarray = getspawnarray( "mp_tdm_spawn_allies_start" );
            }
        }
        else if ( spawnlogic::function_5cf82e30c52a895d( "tdm" ) )
        {
            spawnarray = spawnlogic::function_491fcfcdc1232e11( "tdm", spawnlogic::function_61ba521db28762a7() );
            
            if ( spawnarray.size == 0 )
            {
                spawnarray = getspawnarray( "mp_tdm_spawn_allies_start" );
            }
        }
        else
        {
            spawnarray = getspawnarray( "mp_tdm_spawn_allies_start" );
        }
        
        spawnpoint = spawnarray[ 0 ];
        spawnorigin = getgroundposition( spawnpoint.origin, 15 );
        spawnangles = spawnpoint.angles;
    }
    else if ( isdefined( self.forcespawnorigin ) )
    {
        var_73f86b53e7f5451a = revivespawnvalidationcheck();
        
        if ( !var_73f86b53e7f5451a.isvalidpos && isdefined( self.prevrevivepos ) && !isdefined( self.rallypoint ) )
        {
            spawnorigin = self.prevrevivepos;
        }
        else
        {
            spawnorigin = self.forcespawnorigin;
            self.forcespawnorigin = undefined;
        }
        
        if ( isdefined( self.forcespawnangles ) )
        {
            spawnangles = self.forcespawnangles;
            self.forcespawnangles = undefined;
        }
        else
        {
            spawnangles = ( 0, randomfloatrange( 0, 360 ), 0 );
        }
        
        if ( isdefined( self.reviver ) )
        {
            if ( self.liveragdoll )
            {
                vehicles = vehicle_getarrayinradius( spawnorigin, 500 );
                
                foreach ( vehicle in vehicles )
                {
                    if ( vehicle vehicle_occupancy::function_6b3a6137e14e34e2( spawnorigin ) )
                    {
                        exit = vehicle_occupancy::function_7ce9972f31ab138b( self, vehicle, spawnorigin );
                        
                        if ( isdefined( exit.origin ) )
                        {
                            spawnorigin = exit.origin;
                        }
                        
                        break;
                    }
                }
            }
            else if ( positionwouldtelefrag( spawnorigin ) || !var_73f86b53e7f5451a.isvalidpos )
            {
                spawnpoint = spawnscoring::findteammatebuddyspawn( self.reviver );
                self.reviver = undefined;
                
                if ( isdefined( spawnpoint ) )
                {
                    spawnorigin = spawnpoint.origin;
                    spawnangles = spawnpoint.angles;
                }
            }
            else
            {
                spawnorigin = var_73f86b53e7f5451a.spawnposition;
            }
        }
    }
    else if ( level.usespawnselection && self [[ level.var_e91f2ef9c58faa7c ]]() && flags::gameflag( "prematch_done" ) )
    {
        spawnpoint = spawnselection::getspawnpoint();
        assert( isdefined( spawnpoint ), "<dev string:x80>" );
        assert( isdefined( spawnpoint.origin ) );
        assert( isdefined( spawnpoint.angles ) );
        spawnorigin = spawnpoint.origin;
        spawnangles = spawnpoint.angles;
    }
    else if ( getdvarint( @"hash_3542e3e8d2b9907f", 0 ) == 1 )
    {
        deg = randomintrange( 0, 360 );
        radius = randomintrange( 1000, 7500 );
        center = ( 0, 0, 100 );
        x = cos( deg );
        x *= radius;
        y = sin( deg );
        y *= radius;
        x += center[ 0 ];
        y += center[ 1 ];
        z = center[ 2 ];
        println( "<dev string:xb9>" + x + "<dev string:xc8>" + y + "<dev string:xcd>" + z );
        spawnpoint = spawnstruct();
        spawnpoint.origin = getclosestpointonnavmesh( ( x, y, z ), undefined );
        spawnpoint.lastspawntime = gettime();
        spawnpoint.angles = ( 0, randomfloatrange( 0, 360 ), 0 );
        spawnpoint.index = 0;
        spawnorigin = spawnpoint.origin;
        spawnangles = spawnpoint.angles;
    }
    else
    {
        spawnpoint = self [[ level.getspawnpoint ]]();
        assert( isdefined( spawnpoint ), "<dev string:xd2>" );
        assert( isdefined( spawnpoint.origin ) );
        assert( isdefined( spawnpoint.angles ) );
        spawnorigin = spawnpoint.origin;
        spawnangles = spawnpoint.angles;
        forceangles = spawnpoint.forceangles;
    }
    
    if ( isdefined( self.setspawnpoint ) )
    {
        if ( self.skippedspawnpoint )
        {
            spawnpoint_clearspawnpoint( 0, 0, 1 );
        }
        else
        {
            if ( !level.usespawnselection )
            {
                self.ti_spawn = 1;
            }
            
            if ( self.ti_spawn )
            {
                spawnpoint = self.setspawnpoint;
                
                if ( !self.setspawnpoint.notti )
                {
                    if ( level.isgroundwarinfected && level.var_f49e119ce25800d3 && level.mapname != "mp_aniyah" )
                    {
                        self.movedtoinfected = undefined;
                        parachutespawn = level.alwaysdoskyspawnontacinsert ? 1 : istrue( self.setspawnpoint.issuper );
                        
                        if ( parachutespawn )
                        {
                            self.setspawnpoint.playerspawnpos += ( 0, 0, level.infectparachuteheightoffset );
                            heightclamp = getdvarint( @"hash_492618a75e1c0035", 0 );
                            
                            if ( heightclamp > 0 )
                            {
                                if ( self.setspawnpoint.playerspawnpos[ 2 ] > heightclamp )
                                {
                                    self.setspawnpoint.playerspawnpos = ( self.setspawnpoint.playerspawnpos[ 0 ], self.setspawnpoint.playerspawnpos[ 1 ], heightclamp );
                                }
                            }
                            
                            self.isparachutespawning = 1;
                        }
                    }
                    
                    self.ti_spawn = 1;
                    self playlocalsound( "tactical_spawn" );
                    
                    if ( level.teambased )
                    {
                        foreach ( entry in level.teamnamelist )
                        {
                            if ( entry != self.team )
                            {
                                self playsoundtoteam( "tactical_spawn", entry );
                            }
                        }
                    }
                    else
                    {
                        self playsound( "tactical_spawn" );
                    }
                }
                
                foreach ( tank in level.ugvs )
                {
                    if ( distancesquared( tank.origin, spawnpoint.playerspawnpos ) < 1024 )
                    {
                        tank notify( #"damage", 5000, tank.owner, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon( "killstreak_jammer_mp" ) );
                    }
                }
                
                assert( isdefined( spawnpoint.playerspawnpos ) );
                assert( isdefined( spawnpoint.angles ) );
                var_f108595a7ecc1898 = 0;
                
                if ( isdefined( level.sharedfuncs[ #"tac_insert" ][ #"hash_2dbdd4400cffa8b8" ] ) )
                {
                    var_f108595a7ecc1898 = utility::callsharedfunc( #"tac_insert", #"hash_2dbdd4400cffa8b8", self.setspawnpoint.playerspawnpos );
                }
                
                if ( var_f108595a7ecc1898 )
                {
                    spawnorigin = self.setspawnpoint.playerspawnpos;
                    spawnangles = self.setspawnpoint.playerspawnangles;
                    self.var_2f4095841cd45bab = gettime();
                    var_235d2b5a070622ce = 1;
                    
                    if ( isdefined( level.sharedfuncs[ #"tac_insert" ][ #"hash_3a8e8197efa33bc1" ] ) )
                    {
                        var_235d2b5a070622ce = utility::callsharedfunc( #"tac_insert", #"hash_3a8e8197efa33bc1" );
                    }
                    
                    self.var_61e17fe9b183ff1c = var_235d2b5a070622ce;
                }
                else
                {
                    var_9528598ac3ec9a9c = getnodesinradiussorted( self.setspawnpoint.playerspawnpos, 512, 0, 64, "path" );
                    
                    foreach ( node in var_9528598ac3ec9a9c )
                    {
                        position = node.origin + ( 0, 0, 3 );
                        
                        if ( canspawn( position, self ) )
                        {
                            spawnorigin = position;
                            spawnangles = node.angles;
                            break;
                        }
                    }
                }
                
                spawnpoint_clearspawnpoint( 0, 1 );
                spawnpoint = undefined;
            }
        }
    }
    
    if ( level.var_c0dd81d8b3b40fed && spawnorigin && !is_water_spawn( spawnorigin ) )
    {
        if ( !level.var_ecc9a5fdfad46e14 || level.var_ecc9a5fdfad46e14 && spawnlogic::shoulduseteamstartspawn() )
        {
            radius = self function_e41b19f339e20300();
            spawnorigin = getgroundposition( spawnorigin, radius, 1000, 200 );
        }
    }
    
    /#
        if ( isplayer( self ) && !isbot( self ) && getdvarint( @"hash_2465f6d6178ab408", 0 ) )
        {
            spawnorigin = self.lastdeathpos ?? spawnorigin;
            spawnangles = self.lastdeathangles ?? spawnangles;
            forceangles = 0;
            
            if ( getdvarint( @"hash_2465f6d6178ab408" ) > 1 && self.lastdeathpos )
            {
                leftdir = anglestoleft( spawnangles );
                spawnorigin += leftdir * 50;
            }
        }
    #/
    
    spawndata = { #spawnorigin:spawnorigin, #spawnpoint:spawnpoint };
    
    if ( !isdefined( spawnangles ) )
    {
        spawnangles = ( 0, 0, 0 );
    }
    
    if ( forceangles )
    {
        spawndata.spawnangles = spawnangles;
        spawndata.forceangles = 1;
    }
    else
    {
        spawndata.spawnangles = ( 0, spawnangles[ 1 ], 0 );
    }
    
    return spawndata;
}

// Namespace playerlogic
// Params 1
// Checksum 0x39eba212, Offset: 0x56da
// Size: 0x7d, Type: bool
function is_water_spawn( spawnorigin )
{
    water_physics_content = physics_createcontents( [ "physicscontents_water" ] );
    ray_start = spawnorigin + ( 0, 0, 100 );
    ray_end = spawnorigin - ( 0, 0, 100 );
    water_trace_result = trace::ray_trace( ray_start, ray_end, undefined, water_physics_content );
    return water_trace_result[ "hittype" ] != "hittype_none";
}

// Namespace playerlogic
// Params 0
// Checksum 0x86b07a93, Offset: 0x5760
// Size: 0x191
function function_49df7b3b8b7a279f()
{
    self endon( #"disconnect" );
    var_e3f9badd2a488b16 = [ 2:@"hash_b634ea478e1daedb", @"hash_69467fcb5c998358", 0:@"hash_aaff82c73940d37d" ];
    
    while ( true )
    {
        self waittill( #"sloadouts_badloadout", badloadouttype );
        
        if ( badloadouttype < 0 || badloadouttype >= var_e3f9badd2a488b16.size )
        {
            logstring( "** BAD LOADOUT ** " + self.name + " Called with invalid badLoadoutType " + badloadouttype );
            continue;
        }
        
        logstring( "** BAD LOADOUT ** " + self.name + " failed loadout verification." );
        var_64efc1f11997fc2a = getdvarint( var_e3f9badd2a488b16[ badloadouttype ], 0 );
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "monitorSecureLoadoutsErrors: sloadouts_badloadout on " + ( self.name ?? "<undefined>" ) + " with enforcementLevel " + ( var_64efc1f11997fc2a ?? "<undefined>" ) );
        
        if ( isdefined( self.pers[ "class" ] ) )
        {
            class::loadout_emptycacheofloadout( self.pers[ "class" ] );
        }
        
        if ( var_64efc1f11997fc2a & 4 )
        {
            kick( self getentitynumber(), &"hash_275a12071058303b" );
        }
        
        if ( var_64efc1f11997fc2a & 2 )
        {
            self kill();
        }
        
        if ( var_64efc1f11997fc2a & 1 )
        {
            script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "monitorSecureLoadoutsErrors: Setting self.pers[ 'forceDefaultLoadouts' ] to true and calling menus::onClassChoiceCallback( 1, true, true )" );
            self.pers[ "forceDefaultLoadouts" ] = 1;
            menus::onclasschoicecallback( 1, 1, 1 );
            self.pers[ "forceDefaultLoadouts" ] = 0;
        }
    }
}

// Namespace playerlogic
// Params 0, eflags: 0x4
// Checksum 0x870bef, Offset: 0x58f9
// Size: 0x82
function private function_4624b982c75a6e90()
{
    if ( !isdefined( self.operatorcustomization ) )
    {
        operator::createoperatorcustomization();
    }
    
    teams::setcharactermodels( self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm );
    player::_setsuit( utility::function_f825237e0eda5adf() );
    self giveweapon( level.defaultfist );
    self switchtoweaponimmediate( level.defaultfist );
}

// Namespace playerlogic
// Params 2
// Checksum 0x9248dc0e, Offset: 0x5983
// Size: 0x1831
function spawnplayer( fauxspawn = 0, revivespawn = 0 )
{
    function_164bad72d3d50876( "playerlogic::spawnplayer" );
    self endon( #"disconnect" );
    self endon( #"joined_spectators" );
    self notify( #"spawned" );
    self notify( #"end_respawn" );
    self notify( #"started_spawnplayer" );
    self allowwallrun( 0 );
    
    if ( self.team == "codcaster" )
    {
        return;
    }
    
    if ( game_utility_mp::teamhasinfil( self.team ) && !flags::gameflag( "infil_started" ) && !isdefined( level.bypassclasschoicefunc ) )
    {
        if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && isbrgamemode() && game_utility::getgametype() != "dmz" && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "sandbox" )
        {
            hasinfil = game_utility_mp::teamhasinfil( self.team );
            started = flags::gameflag( "infil_started" );
            bypass = isdefined( level.bypassclasschoicefunc );
            script::demoforcesre( "spawnPlayer()" + self.name + " ui_open_menu_from_script = UI_MENU_LOADOUT_MENU, hasInfil = " + hasinfil + " infil_started = " + started + "bypassClassChoiceFunc = " + bypass );
        }
        
        if ( !self.var_c7ad15df404c5ded )
        {
            self setclientomnvar( "ui_open_menu_from_script", 2 );
        }
    }
    else if ( ( !isdefined( game_utility_mp::getgamestate( self ) ) || game_utility_mp::getgamestate( self ) != "playing" ) && !self.var_ee74e8eed7f0fe09 )
    {
        self setclientomnvar( "ui_open_menu_from_script", -1 );
    }
    
    if ( self function_5c766d1d0140b86( "ui_combat_report_num_attackers" ) )
    {
        self setclientomnvar( "ui_combat_report_num_attackers", 0 );
    }
    
    self.lastkillsplash = undefined;
    self.spawnedasspectator = undefined;
    self.scorestreakvariantattackerinfo = undefined;
    self.cratemantle = undefined;
    self.var_45ab03788f1a0a4d = undefined;
    
    if ( getmatchrulesdata( "commonOption", "radarAlwaysOn" ) > 1 )
    {
        level thread uav::function_76ded778d105259d( self );
    }
    
    level operator::function_d846e5ddf3fe819();
    
    if ( !isdefined( level.var_5931b7e101986e80 ) )
    {
        level.var_5931b7e101986e80 = ( level.gametypebundle.var_5c4544fbd39f2bc3 ?? 0 ) <= 0;
    }
    
    if ( level.var_5931b7e101986e80 )
    {
        if ( self.waitingtospawnamortize )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_c4849d6a757e0b64", 0 ) != 0 )
            {
                self.waitingtospawnamortize = 1;
                numplayerswaitingtospawn = getdvarint( @"hash_c4849d6a757e0b64", 0 );
                wait level.framedurationseconds * numplayerswaitingtospawn;
                self.waitingtospawnamortize = 0;
            }
        #/
        
        level.numplayerswaitingtospawn++;
        
        if ( level.numplayerswaitingtospawn > 1 )
        {
            println( "<dev string:x10b>" );
            self.waitingtospawnamortize = 1;
            wait level.framedurationseconds * ( level.numplayerswaitingtospawn - 1 );
        }
    }
    
    if ( teams::getteamdata( self.team, "noRespawns" ) == 1 && !revivespawn )
    {
        if ( !isdefined( self.lastdeathtime ) )
        {
            return;
        }
        else if ( level.var_c6b02af9c0f45ca2[ self.team ] < self.lastdeathtime )
        {
            return;
        }
    }
    
    self.spawninginprogress = 1;
    shouldgiveloadout = gamelogic_mp::function_8f165bf1d7e138c4( revivespawn );
    var_5d807c12a88ad75 = 0;
    
    if ( shouldgiveloadout )
    {
        var_5d807c12a88ad75 = gamelogic_mp::function_323a8653c264b72f();
        
        if ( var_5d807c12a88ad75 )
        {
            shouldgiveloadout = 0;
        }
    }
    
    if ( shouldgiveloadout )
    {
        if ( !class::isvalidclass( self.class ) )
        {
            self.class = self.pers[ "class" ] ?? "default1";
        }
        
        if ( !isdefined( self.pers[ "copiedClass" ] ) )
        {
            script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "spawnPlayer: shouldgiveloadout - not copiedClass - self.class is " + ( self.class ?? "<undefined>" ) );
            loadoutstruct = class::preloadandqueueclass( self.class, 1 );
        }
        else
        {
            script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "spawnPlayer: shouldgiveloadout - copiedClass - self.class is " + ( self.class ?? "<undefined>" ) + ", self.pers[ 'lastKiller' ] is " + ( self.pers[ "lastKiller" ] ?? "<undefined>" ) );
            classstruct = class::loadout_getorbuildclassstruct( self.class );
            class::loadout_fixcopiedclassstruct( self.pers[ "copiedClass" ], classstruct );
            
            if ( isdefined( self.pers[ "lastKiller" ] ) )
            {
                logloadoutcopy( self.pers[ "lastKiller" ] );
                self.pers[ "lastKiller" ] = undefined;
            }
            
            class::preloadandqueueclassstruct( self.pers[ "copiedClass" ], 1 );
            loadoutstruct = self.pers[ "copiedClass" ];
            self.pers[ "copiedClass" ] = undefined;
        }
    }
    
    if ( level.var_5931b7e101986e80 )
    {
        thread spawningclientthisframereset();
        self.waitingtospawnamortize = 0;
    }
    
    function_17bffb98a94b1e2b();
    self.validspawn = 0;
    thread validatespawn();
    self.spawndata = getspawnpoint();
    profilestart();
    spawnstarttime = gettime();
    
    if ( !isdefined( level.var_96bcabbf9556147 ) )
    {
        level.var_96bcabbf9556147 = spawnstarttime;
    }
    
    level.var_96bcabbf9556147 = level.var_96bcabbf9556147 <= spawnstarttime ? spawnstarttime : level.var_96bcabbf9556147;
    setspawnvariables();
    
    /#
        if ( !getdvarint( @"force_ranking" ) && !level.istrainingcourse )
        {
            assert( level.teambased && ( game_utility_mp::denysystemicteamchoice() || self.sessionteam == self.team ) || !level.teambased && self.sessionteam == "<dev string:x134>" );
        }
    #/
    
    hadspawned = self.hasspawned;
    self.suicidespawndelay = undefined;
    function_b2741fbfac0c8b8c( 0 );
    self sethidenameplate( 0 );
    self setentityhudoutlinedata( 2, self.team );
    
    if ( !fauxspawn )
    {
        self.killsthislife = [];
        
        if ( !self.inspawncamera )
        {
            player::updatesessionstate( "playing" );
        }
        
        player::clearkillcamstate( self.spawndata.forceangles );
        self.cancelkillcam = undefined;
        
        if ( self.liveragdoll )
        {
            println( "<dev string:x139>" + gettime() + "<dev string:x13c>" + self.name + "<dev string:x13f>" + self.health );
        }
        
        self.maxhealth = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
        
        if ( revivespawn )
        {
            health = int( getmatchrulesdata( "commonOption", "teamReviveHealth" ) );
            overridehealth = dvars::getwatcheddvar( "teamReviveHealth" );
            health = overridehealth ?? health;
            
            if ( !isdefined( health ) )
            {
                self.health = getdvarint( @"hash_a8543004b97470b5", 50 );
            }
            else
            {
                self.health = health;
            }
            
            thread notifyreviveregen();
        }
        else
        {
            self.health = self.maxhealth;
        }
        
        if ( self.friendlyfiredeath )
        {
            self.friendlyfiredeath = undefined;
            thread common::ffmessageonspawn();
        }
        
        self.friendlydamage = undefined;
        self.spawntime = gettime();
        self.wasti = self.ti_spawn;
        self.damagedplayers = [];
        self.objectivescaler = 1;
        self.shieldbullethits = 0;
        self.recentshieldxp = 0;
        self.switching_teams = undefined;
        self.respawntimerstarttime = undefined;
        self.initialrespawndelay = undefined;
        self.lastgastouchtime = undefined;
        self.lastsnapshotgrenadetime = undefined;
        self.var_9ae31e49bba9af9a = undefined;
        self.lastinsmoketime = undefined;
        self.lastburntime = undefined;
        self.lasttimedamaged = undefined;
        self.var_c8e77c8b66f05eaa = undefined;
        self.var_d15047abc75b9fb7 = undefined;
        self.weaponslotblocked = undefined;
        self.var_4f8bc414b5378af = undefined;
        self.var_1030b877096cfad2 = undefined;
        self.var_b4300d21ff2d6a8e = !issimulationplayer( self ) && level.spawnprotectiontimer > 0;
        self.var_c19506b543ae5021 = !issimulationplayer( self ) && level.var_44d02731194e3f49 > 0;
        self.var_13e00284b1601b70 = undefined;
        self.br_spectatorinitialized = undefined;
        
        if ( !isdefined( self.pers[ "agentsKillstreakCount" ] ) )
        {
            self.pers[ "agentsKillstreakCount" ] = 0;
        }
        
        if ( isdefined( self.stuckbygrenade ) && self.stuckbygrenade.stuckenemyentity == self )
        {
            self.stuckbygrenade.stuckenemyentity = undefined;
        }
        
        self.stuckbygrenade = undefined;
        self.stuckbygrenadeowner = undefined;
        self.lifeid = 0;
        
        if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 1 )
        {
            if ( isdefined( game[ "gameStateRestore" ] ) && game[ "gameStateRestore" ].enabled )
            {
                self.pers[ "deaths" ] = gamestaterestore::getlifeid( self.name );
            }
        }
        
        if ( isdefined( self.pers[ "deaths" ] ) )
        {
            self.lifeid = self.pers[ "deaths" ];
        }
        
        damage_utility::cleardamagemodifiers();
        namespace_2be4972bbff8c613::clearkillcamomnvars();
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            thread function_1243baf9662a3d80();
        }
        
        player::function_28363dff0f011241();
    }
    
    self.movespeedscaler = 1;
    
    if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    if ( !fauxspawn )
    {
        self.avoidkillstreakonspawntimer = level.spawnprotectiontimer;
        var_8f459b453406e6dd = self.pers[ "lives" ];
        
        if ( var_8f459b453406e6dd == game_utility_mp::getgametypenumlives() && game_utility_mp::getbasegametype() != "control" )
        {
            addtolivescount();
        }
        
        if ( var_8f459b453406e6dd )
        {
            if ( game_utility_mp::getbasegametype() != "control" )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "lives" ] ) )
                    {
                        self.leaderboarddata[ "lives" ] = self.leaderboarddata[ "lives" ] + -1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "lives" ] ) )
                    {
                        [[ level.leaderboardfunc[ "lives" ] ]]( self, -1 );
                    }
                    
                    assert( isint( -1 ) || isfloat( -1 ), "<dev string:x198>" );
                    
                    if ( isdefined( self.pers[ "lives" ] ) )
                    {
                        self.pers[ "lives" ] = self.pers[ "lives" ] + -1;
                    }
                }
            }
        }
        
        if ( !self.gulag && !self.respawningfromtoken && !self.respawningbr && !self.var_99785ac1853ef492 )
        {
            addtoalivecount( "spawnPlayer" );
        }
        
        if ( !hadspawned || game_utility_mp::gamehasstarted() || game_utility_mp::gamehasstarted() && level.ingraceperiod && self.hasdonecombat )
        {
            var_f4e8af738fb465ed = 1;
            
            if ( !level.suicideteamkilllowerslives && self.uncounteddeath )
            {
                if ( game_utility_mp::getbasegametype() == "control" )
                {
                    var_f4e8af738fb465ed = 0;
                }
            }
            else if ( level.var_1006ea76c66f444 )
            {
                var_f4e8af738fb465ed = 0;
            }
            
            if ( var_f4e8af738fb465ed )
            {
                removefromlivescount();
            }
        }
        
        if ( !self.wasaliveatmatchstart )
        {
            var_6af4cb8943374697 = 20;
            
            if ( game_utility_mp::gettimelimit() > 0 && var_6af4cb8943374697 < game_utility_mp::gettimelimit() / 4 )
            {
                var_6af4cb8943374697 = game_utility_mp::gettimelimit() / 4;
            }
            
            if ( level.ingraceperiod || game_utility::gettimepassed() < var_6af4cb8943374697 * 1000 )
            {
                self.wasaliveatmatchstart = 1;
            }
        }
    }
    
    callback::callback( "onPlayerSpawn", { #player:self } );
    
    if ( isdefined( self.spawndata.spawnpoint ) )
    {
        if ( !self.shouldgetnewspawnpoint )
        {
            spawnlogic::finalizespawnpointchoice( self.spawndata.spawnpoint );
        }
        
        self.lastspawntime = gettime();
    }
    else if ( !isdefined( self.faux_spawn_infected ) )
    {
        self.lastspawntime = gettime();
    }
    
    self.spawnpos = self.spawndata.spawnorigin;
    self.var_af6d8f2a60e3cf4a = self.spawndata.spawnpoint.evaluationid;
    self.lifetimedamage = 0;
    self.var_52134643987847ec = 0;
    spectating::setspectatepermissions();
    
    if ( self.liveragdoll )
    {
        self sethidenameplate( 0 );
        self.healthregendisabled = 0;
        self.liveragdoll = 0;
        stopspectateplayer( self getentitynumber(), 1, 0 );
        player::updatesessionstate( "playing" );
        player_utility::function_b54a1e23734ef07();
        player_utility::function_4688d689820ff1ed( "playerlogic::spawnPlayer()" );
        self function_53d446e6e6a7f1ac( 0 );
        self function_715e8b27564eeece( 0 );
        self stopliveragdoll();
        player::_freezecontrols( 0, undefined, "liveRagdoll" );
        class::setthirdpersonview();
    }
    else
    {
        if ( isdefined( self.var_52451a3506366553 ) )
        {
            self function_8f78218d9160cb4d( self.spawndata.spawnorigin, self.spawndata.spawnangles[ 1 ], self.var_52451a3506366553 );
        }
        else
        {
            self spawn( self.spawndata.spawnorigin, self.spawndata.spawnangles );
        }
        
        if ( self.spawndata.forceangles )
        {
            playerangles = self.spawndata.spawnangles;
        }
        else
        {
            playerangles = ( 0, self.spawndata.spawnangles[ 1 ], 0 );
        }
        
        self setplayerangles( playerangles, 1 );
        
        /#
            player::printspawnmessage( "<dev string:x1be>" + self.spawndata.spawnorigin );
        #/
        
        if ( getdvarint( @"scr_br_alt_mode_arcade_royale", 0 ) == 1 )
        {
            outline::hudoutline_add_channel_internal( "eagle_eye_enemy", 10, "outline_nodepth_red" );
        }
    }
    
    self.combatinstances = [];
    
    if ( !self.inspawncamera )
    {
        self.var_52451a3506366553 = undefined;
        self.platformoffset = undefined;
    }
    
    if ( !isdefined( level.lastspawnpos ) )
    {
        level.lastspawnpos = [];
    }
    
    level.lastspawnpos[ self.team ] = self.spawndata.spawnorigin;
    self.death_timer_length = 1023;
    
    if ( ( fauxspawn || revivespawn ) && isdefined( self.faux_spawn_stance ) )
    {
        self setstance( self.faux_spawn_stance );
        self.faux_spawn_stance = undefined;
    }
    
    if ( isai( self ) )
    {
        player::_freezecontrols( 1, undefined, "spawn" );
    }
    
    self motionblurhqenable();
    
    if ( getdvarint( @"hash_204f67bbaa6705ea", 0 ) && getdvarint( @"hash_35f4e6208a21198a", 1 ) )
    {
        self function_76025bf1685180e2( 1 );
    }
    
    if ( !fauxspawn )
    {
        self painvisionon();
    }
    
    game_utility_mp::canparachutebecut( self );
    var_b34c8cbb8fd348 = !fauxspawn || self.faux_spawn_infected;
    [[ level.onspawnplayer ]]( revivespawn );
    
    if ( !isdefined( level.var_5092ad40df5693fd ) || [[ level.var_5092ad40df5693fd ]]() )
    {
        self clearpredictedstreampos();
    }
    
    if ( var_b34c8cbb8fd348 )
    {
        if ( isai( self ) )
        {
            bots::bot_player_spawned();
        }
        
        if ( isdefined( level.matchrecording_logevent ) )
        {
            [[ level.matchrecording_logevent ]]( self.clientid, self.team, "SPAWN", self.spawnpos[ 0 ], self.spawnpos[ 1 ], self.spawntime );
        }
        
        if ( !isai( self ) && !( isbrgamemode() && level.gametypebundle.var_4e6fb01eb6514cdc ) )
        {
            thread totaldisttracking( self.spawndata.spawnorigin );
        }
    }
    
    if ( !fauxspawn )
    {
        telemetry_utils::function_af2d366f9522f76f( "callback_on_player_spawned", self );
        callback::callback( "onPlayerSpawn_destroyEquipment" );
        self.matchdatalifeindex = -1;
        
        if ( telemetry_utils::is_valid_client( self ) )
        {
            self.matchdatalifeindex = game[ "life_count" ];
            game[ "life_count" ]++;
        }
        
        self.lastmatchdatakillstreakindex = -1;
        
        if ( getdvarint( @"online_matchdata_enabled" ) != 0 )
        {
            setmatchdata( "lifeCount", game[ "life_count" ] );
        }
    }
    
    if ( isdefined( self.selectedspawnarea ) )
    {
        analyticslog::logevent_spawnselectionchoice( self, self.selectedspawnarea );
    }
    
    equipment_mp::clearallequipment();
    assert( class::isvalidclass( self.class ) );
    class::setclass( self.class );
    
    if ( isdefined( level.custom_giveloadout ) )
    {
        self [[ level.custom_giveloadout ]]( fauxspawn, revivespawn );
    }
    else if ( shouldgiveloadout )
    {
        if ( self.var_97174dbd51b73ea5 )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"tac_insert" ][ #"waitgiveloadout" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self thread [[ var_32dbca3143d9c4a5 ]]( revivespawn );
            }
        }
        else
        {
            class::giveloadout( self.team, self.class, undefined, undefined, revivespawn, undefined, undefined, undefined, { #fromspawnplayer:1 } );
        }
        
        if ( !isbrgamemode() )
        {
            if ( !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
            {
                supers_mp::function_7d55dcbfe177d86f( 0 );
                self.overclockcharge = undefined;
            }
        }
        
        if ( isdefined( self.perks[ "specialty_survivor" ] ) )
        {
            self.var_300ce019f5fb0cb0 = 0;
        }
    }
    
    if ( getomnvar( "ui_prematch_period" ) )
    {
        thread showgamemodeobjectivetext();
        thread function_7376357a50f8c839();
        
        if ( isbrgamemode() )
        {
            thread function_ccdd146f3e6e3c82();
        }
    }
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread logstartingloadout();
        
        if ( level.codcasterenabled && !self iscodcaster() )
        {
            thread function_23bd7fea624acc6f( self );
        }
    }
    
    if ( game[ "roundsPlayed" ] > 0 )
    {
        if ( !self.classrefreshed )
        {
            if ( isdefined( self.class_num ) )
            {
                self.classrefreshed = 1;
            }
        }
    }
    
    if ( level.forcethirdperson )
    {
        player::setthirdpersondof( 1 );
    }
    
    if ( isai( self ) )
    {
        player::_freezecontrols( 0, undefined, "spawn" );
    }
    
    if ( game[ "inLiveLobby" ] || isbrgamemode() && !flags::gameflag( "prematch_done" ) )
    {
    }
    else if ( !flags::gameflag( "prematch_done" ) )
    {
        allowprematchlook( self );
    }
    else
    {
        force = !self.hasspawned;
        player::_freezecontrols( 0, force, "spawn" );
        player::_freezelookcontrols( 0, force );
    }
    
    if ( !self.hasspawned )
    {
        gamelogic_mp::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
        callback::callback( #"hash_6cd8138b7ddba849", {} );
    }
    
    if ( isdefined( self.pers[ "hasEarnedHardlineStreak" ] ) && self.pers[ "hasEarnedHardlineStreak" ] == 0 )
    {
        killstreaks::givestreakpoints( #"perk_package_activate", 3, 0 );
    }
    
    self.hasspawned = 1;
    self.pers[ "hasSpawned" ] = 1;
    profilestop();
    
    if ( level.gametypebundle.var_5c4544fbd39f2bc3 > 0 )
    {
        currentframe = function_8fc063681724727f();
        
        if ( !isdefined( level.var_db04c0739d9ee86d[ currentframe ] ) )
        {
            level.var_db04c0739d9ee86d[ currentframe ] = 0;
        }
        
        level.var_db04c0739d9ee86d[ currentframe ]++;
        level.var_a97ce32d4d2a2f7a = currentframe;
    }
    
    waittillframeend();
    self.spawningafterremotedeath = undefined;
    self.delayedspawnedplayernotify = undefined;
    
    if ( !level.disablespawncamera && isdefined( self.spawncameraent ) || level.disablespawncamera && isdefined( self.spawncameraent ) && ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" ) )
    {
        self.wasrevivespawn = revivespawn;
        self.delayedspawnedplayernotify = 1;
        self notify( #"spawncamera_start" );
    }
    
    if ( self.var_97174dbd51b73ea5 )
    {
        self.wasrevivespawn = revivespawn;
        self.delayedspawnedplayernotify = 1;
        self notify( #"ti_spawncamera_start" );
    }
    
    if ( !self.delayedspawnedplayernotify )
    {
        self notify( #"spawned_player" );
        level notify( #"player_spawned", self, revivespawn );
        thread setspawnnotifyomnvar();
    }
    
    if ( game_utility_mp::getgamestate( self ) == "postgame" )
    {
        assert( !level.intermission );
        gamelogic_mp::freezeplayerforroundend();
    }
    
    if ( ( level.var_98dc8a7195ec7c4b ?? analyticslog::function_c0d649dd2c6fbce5() ) && !fauxspawn )
    {
        if ( analyticslog::analyticsdoesspawndataexist() )
        {
            level.spawncount += 1;
        }
        else
        {
            analyticslog::analyticsinitspawndata();
        }
        
        if ( analyticslog::analyticssend_shouldsenddata( level.spawncount ) )
        {
            if ( isdefined( level.spawnglobals.spawnpointslist ) )
            {
                analyticslog::analyticssend_spawnfactors( self, self.spawnpointslist, level.spawncount, self.spawndata.spawnpoint );
                analyticslog::analyticssend_spawntype( self.spawndata.spawnpoint.origin, self.team, self.lifeid, level.spawncount );
                analyticslog::analyticssend_spawnplayerdetails( self, self.spawndata.spawnpoint.origin, level.spawncount );
            }
        }
        
        self.lastspawnpoint = self.spawndata.spawnpoint;
    }
    
    if ( !self.delayedspawnedplayernotify )
    {
        self.spawndata = undefined;
    }
    
    if ( !isdefined( self.revive_chosenclass ) )
    {
        thread class::updateinstantclassswapallowed();
    }
    
    if ( game_utility_mp::function_4818e8dcc8c3ec96() )
    {
        self skydive_setbasejumpingstatus( 1 );
        self skydive_setdeploymentstatus( 1 );
    }
    
    player::setwind( "1" );
    self.spawninginprogress = 0;
    self.validspawn = 1;
    self notify( #"validate_spawn" );
    
    if ( self.var_78eccdb92a3a3896 )
    {
        level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
    }
    
    pbgpostfxbundlekillall( self );
    
    if ( self.visibilitymode.darkbackgroundvalue )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:%"cer_vismode_nosaturation" }, 1, 1 );
    }
    
    if ( !self.delayedspawnedplayernotify )
    {
        callback::callback( #"player_spawned", { #player:self, #revivespawn:revivespawn } );
    }
    
    if ( var_5d807c12a88ad75 )
    {
        function_4624b982c75a6e90();
    }
    
    if ( isautopilot( self ) || self.pers[ #"hash_1d057e7863454d0e" ] )
    {
        level thread game_utility::fadetoblackforplayer( self, 0, 0 );
        level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0xbf751369, Offset: 0x71bc
// Size: 0x2a
function function_b2741fbfac0c8b8c( active )
{
    self.fauxdead = active ? 1 : undefined;
    function_748b4335a908f089( istrue( active ) );
}

// Namespace playerlogic
// Params 1
// Checksum 0xc8b6ea33, Offset: 0x71ee
// Size: 0x41
function function_748b4335a908f089( value )
{
    if ( value )
    {
        self.game_extrainfo |= 4096;
        return;
    }
    
    self.game_extrainfo &= ~4096;
}

// Namespace playerlogic
// Params 0
// Checksum 0x8c3fcace, Offset: 0x7237
// Size: 0x3f
function function_1243baf9662a3d80()
{
    self notify( #"hash_b22ea369111eda63" );
    self endon( #"hash_b22ea369111eda63" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    self.var_b73925ccb5007bd8 = gettime();
}

// Namespace playerlogic
// Params 0
// Checksum 0x99cec9bc, Offset: 0x727e
// Size: 0x51
function validatespawn()
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 1, "validate_spawn" );
    
    if ( !self.validspawn )
    {
        self.kick_reason = #"timeout";
        kick( self getentitynumber(), &"exe/playerkicked" );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x24639072, Offset: 0x72d7
// Size: 0xc, Type: bool
function function_c9e59c8ceebcab38()
{
    return istrue( self.spycamoutline );
}

// Namespace playerlogic
// Params 0
// Checksum 0x34ec484a, Offset: 0x72ec
// Size: 0x10
function enableoutline()
{
    thread function_7291c0e817c418d4();
    thread function_470cb1856206b475();
}

// Namespace playerlogic
// Params 0
// Checksum 0xf917f8c8, Offset: 0x7304
// Size: 0x621
function function_7291c0e817c418d4()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_634290e8f865d746 = [];
    var_53815581e0ba5aa6 = spawnstruct();
    self.wasdriver = 0;
    self.isdriver = 0;
    thread isvehicledriver();
    outlinedenemies = [];
    
    while ( true )
    {
        if ( !self tagexists( "tag_eye" ) )
        {
            waitframe();
            continue;
        }
        
        if ( function_c9e59c8ceebcab38() )
        {
            waitframe();
            continue;
        }
        
        enemies = self getsightedplayers();
        
        if ( !isdefined( enemies ) )
        {
            continue;
        }
        
        for ( i = 0; i < outlinedenemies.size ; i++ )
        {
            var_fee89c2a9b236735 = 0;
            var_cbc0493bff83382b = outlinedenemies[ i ];
            
            foreach ( localenemy in enemies )
            {
                if ( var_cbc0493bff83382b == localenemy )
                {
                    var_fee89c2a9b236735 = 1;
                    break;
                }
            }
            
            if ( !var_fee89c2a9b236735 )
            {
                if ( isent( var_cbc0493bff83382b ) )
                {
                    var_cbc0493bff83382b outline::function_a232cd494502454d( self, "target acquisition transparent", 1 );
                    var_cbc0493bff83382b outline::function_a232cd494502454d( self, "target acquisition", 1 );
                }
                
                outlinedenemies[ i ] = undefined;
            }
        }
        
        outlinedenemies = function_5713d46873b29625( outlinedenemies );
        
        if ( self.isdriver )
        {
            if ( !self.wasdriver )
            {
                foreach ( localenemy in enemies )
                {
                    localenemy outline::function_a232cd494502454d( self, "target acquisition", 1 );
                }
                
                self.wasdriver = 1;
            }
            
            waitframe();
            continue;
        }
        
        function_a2cae108f3853cc1( var_53815581e0ba5aa6 );
        var_ff38de2209af3a3d = isbrgamemode();
        
        foreach ( localenemy in enemies )
        {
            if ( var_ff38de2209af3a3d )
            {
                if ( isdefined( localenemy.haslanded ) && !localenemy.haslanded )
                {
                    continue;
                }
            }
            
            if ( isdefined( self.var_634290e8f865d746[ localenemy.clientid ] ) )
            {
                self.var_634290e8f865d746[ localenemy.clientid ].visible = 1;
            }
            else
            {
                self.var_634290e8f865d746[ localenemy.clientid ] = spawnstruct();
                self.var_634290e8f865d746[ localenemy.clientid ].enemyentity = localenemy;
                self.var_634290e8f865d746[ localenemy.clientid ].finishtimer = 0;
                thread function_56a24b40fbccbaa1( localenemy );
            }
            
            enable_outline = 0;
            viewpos = localenemy gettagorigin( "j_spinelower" ) - self gettagorigin( "tag_eye" );
            disttoplayer = length( viewpos );
            
            if ( self.var_634290e8f865d746[ localenemy.clientid ].finishtimer )
            {
                if ( disttoplayer < var_53815581e0ba5aa6.maxdist && disttoplayer > getdvarfloat( @"hash_1adfe2e839bc58a6" ) )
                {
                    angle = math::anglebetweenvectors( viewpos, anglestoforward( self getplayerangles() ) );
                    
                    if ( angle < var_53815581e0ba5aa6.maxangle )
                    {
                        enable_outline = 1;
                    }
                }
            }
            
            var_ae7252a7c66ff7ce = !isbot( self ) ? getdvarint( @"hash_87485eca39b418a6", 1 ) == 1 && self function_57413eeef54cb2cd() : 1;
            
            if ( var_ae7252a7c66ff7ce && enable_outline )
            {
                localenemy outline::function_a232cd494502454d( self, "target acquisition transparent", 1 );
                localenemy outline::hudoutline_enable_internal( self, "target acquisition" );
            }
            else
            {
                localenemy outline::function_a232cd494502454d( self, "target acquisition", 1 );
                localenemy outline::hudoutline_enable_internal( self, "target acquisition transparent" );
            }
            
            var_d069cb9629a4bf44 = 0;
            
            foreach ( var_3be30283560a7bc0 in outlinedenemies )
            {
                if ( var_3be30283560a7bc0 == localenemy )
                {
                    var_d069cb9629a4bf44 = 1;
                    break;
                }
            }
            
            if ( !var_d069cb9629a4bf44 )
            {
                outlinedenemies[ outlinedenemies.size ] = localenemy;
            }
        }
        
        timersarraykeys = getarraykeys( self.var_634290e8f865d746 );
        
        foreach ( var_9cad7b3e3b16ee05 in timersarraykeys )
        {
            if ( isdefined( self.var_634290e8f865d746[ var_9cad7b3e3b16ee05 ].visible ) && !self.var_634290e8f865d746[ var_9cad7b3e3b16ee05 ].visible )
            {
                self.var_634290e8f865d746[ var_9cad7b3e3b16ee05 ].enemyentity notify( "out_of_sight_" + self.clientid );
                self.var_634290e8f865d746[ var_9cad7b3e3b16ee05 ] = undefined;
                continue;
            }
            
            self.var_634290e8f865d746[ var_9cad7b3e3b16ee05 ].visible = 0;
        }
        
        waitframe();
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x6c164183, Offset: 0x792d
// Size: 0xa4
function function_6ea87ad28b31cae1()
{
    teammates = teams::getteamdata( self.team, "players" );
    
    foreach ( player in teammates )
    {
        if ( player == self )
        {
            continue;
        }
        
        player outline::function_a232cd494502454d( self, "teammate outlines", 1 );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x97072a69, Offset: 0x79d9
// Size: 0x17d
function function_470cb1856206b475()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    maxdistance = getdvarfloat( @"hash_dde5893bef72aafa", 4000 );
    
    while ( true )
    {
        if ( !self tagexists( "tag_eye" ) )
        {
            waitframe();
            continue;
        }
        
        teammates = teams::getteamdata( self.team, "players" );
        
        foreach ( player in teammates )
        {
            if ( !isdefined( player ) || player == self )
            {
                continue;
            }
            
            if ( !isdefined( player gettagorigin( "j_spinelower", 1 ) ) )
            {
                continue;
            }
            
            viewpos = player gettagorigin( "j_spinelower" ) - self gettagorigin( "tag_eye" );
            disttoplayer = length( viewpos );
            
            if ( getdvarint( @"hash_e52b5e6aa3bc54b1", 1 ) == 1 && disttoplayer < maxdistance && self function_1b85550aef30c475() )
            {
                player outline::hudoutline_enable_internal( self, "teammate outlines" );
                continue;
            }
            
            player outline::function_a232cd494502454d( self, "teammate outlines", 1 );
        }
        
        waitframe();
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x202de032, Offset: 0x7b5e
// Size: 0xb3
function isvehicledriver()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        message = utility::waittill_any_timeout( 1, "vehicle_enter", "vehicle_change_seat", "vehicle_exit" );
        
        if ( self.wasdriver && message == "vehicle_exit" )
        {
            self.wasdriver = 0;
            self.isdriver = 0;
            continue;
        }
        
        if ( message == "vehicle_enter" )
        {
            self.isdriver = vehicle_occupancy::function_3080323254ba6900( self );
            continue;
        }
        
        if ( message == "vehicle_change_seat" )
        {
            self.wasdriver = self.isdriver;
            self.isdriver = vehicle_occupancy::function_3080323254ba6900( self );
        }
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0x5123ed, Offset: 0x7c19
// Size: 0x79
function function_56a24b40fbccbaa1( localenemy )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    localenemy endon( #"death_or_disconnect" );
    localenemy endon( "out_of_sight_" + self.clientid );
    wait getdvarfloat( @"hash_babf297f40ef9792", 1.5 );
    self.var_634290e8f865d746[ localenemy.clientid ].finishtimer = 1;
}

// Namespace playerlogic
// Params 1
// Checksum 0xeead180, Offset: 0x7c9a
// Size: 0x137
function function_a2cae108f3853cc1( var_53815581e0ba5aa6 )
{
    isads = self playerads() > 0.5;
    var_26e23e177510df89 = self function_17fdc69f02da1f1d();
    var_53815581e0ba5aa6.minangle = getdvarfloat( @"hash_82bf79a286a47409", 1 );
    
    if ( isads && isdefined( var_26e23e177510df89 ) && var_26e23e177510df89 < 6 )
    {
        var_fd767c460577493b = getdvarfloat( @"hash_9166b379c429ca44" );
        var_bbd4f1546efbf36a = getdvarfloat( @"hash_b04f78259746bfaa", 7 );
        var_53815581e0ba5aa6.maxdist = var_fd767c460577493b * ( 1 + getdvarfloat( @"hash_bd6366aa8fdd2c54", 0.35 * var_26e23e177510df89 ) );
        var_53815581e0ba5aa6.maxangle = var_bbd4f1546efbf36a;
        
        if ( var_26e23e177510df89 > 0 )
        {
            var_53815581e0ba5aa6.maxangle -= 1 + var_26e23e177510df89 * 0.7;
        }
        
        return;
    }
    
    var_53815581e0ba5aa6.maxdist = getdvarfloat( @"hash_d9a3414a981b1b5a" );
    var_53815581e0ba5aa6.maxangle = getdvarfloat( @"hash_7544939a6ec22268", 12 );
}

// Namespace playerlogic
// Params 1
// Checksum 0xf1fd81bb, Offset: 0x7dd9
// Size: 0x7a
function logloadoutcopy( killer )
{
    if ( isdefined( killer ) )
    {
        self dlog_recordplayerevent( "dlog_event_loadout_copy", [ "receiver_player_client_id", self.clientid, "receiver_gamertag", self.name, "giver_player_client_id", killer.clientid, "giver_gamertag", killer.name ] );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xe852987f, Offset: 0x7e5b
// Size: 0xa7
function logstartingloadout()
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( !isdefined( self.curclass ) )
    {
        return;
    }
    
    if ( self.curclass == "juggernaut" )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    class::function_cc134deb92601b32( self.classstruct );
    flags::gameflagwait( "prematch_done" );
    
    if ( isdefined( level.throttle_log_starting_loadout ) )
    {
        throttle::throttle_wait_in_queue( level.throttle_log_starting_loadout, self );
    }
    
    class::loadout_lognewlygivenloadout( self.globalstruct, self.classstruct, self.curclass );
}

// Namespace playerlogic
// Params 0
// Checksum 0xdf4e33c, Offset: 0x7f0a
// Size: 0x26
function notifyreviveregen()
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    waitframe();
    playerhealth::forcehealthregen( self, 1 );
}

// Namespace playerlogic
// Params 0
// Checksum 0x7bcf4e26, Offset: 0x7f38
// Size: 0x1e
function setspawnnotifyomnvar()
{
    self endon( #"disconnect" );
    waitframe();
    self setclientomnvar( "ui_player_spawned_notify", gettime() );
}

// Namespace playerlogic
// Params 1
// Checksum 0x7b0fece, Offset: 0x7f5e
// Size: 0x1bb
function playerprematchallow( allow )
{
    if ( !allow )
    {
        val::set( "prematch", "allow_movement", 0 );
        val::set( "prematch", "fire", 0 );
        val::set( "prematch", "offhand_weapons", 0 );
        val::set( "prematch", "offhand_primary_weapons", 0 );
        val::set( "prematch", "offhand_secondary_weapons", 0 );
        val::set( "prematch", "force_enable_offhand_sprays", 1 );
        val::set( "prematch", "supers", 0 );
        val::set( "prematch", "allow_jump", 0 );
        val::set( "prematch", "melee", 0 );
        val::set( "prematch", "sprint", 0 );
        val::set( "prematch", "killstreaks", 0 );
        val::set( "prematch", "usability", 0 );
        val::set( "prematch", "allow_meleegrapple", 0 );
        val::set( "prematch", "allow_throwweapon", 0 );
        
        if ( level.var_6673aa86c64b71b )
        {
            player::_freezelookcontrols( 1 );
        }
        
        if ( !level.disablemount )
        {
            val::set( "prematch_mount", "mount_top", 0 );
            val::set( "prematch_mount", "mount_side", 0 );
        }
        
        if ( level.var_30f4ed96883cd0b8 )
        {
            val::set( "prematch", "weapon_switch", 0 );
        }
        
        return;
    }
    
    val::reset_all( "prematch" );
    
    if ( !level.disablemount )
    {
        val::reset_all( "prematch_mount" );
    }
    
    if ( level.var_6673aa86c64b71b )
    {
        player::_freezelookcontrols( 0 );
    }
    
    self notify( #"hash_193e233f169e993f" );
}

// Namespace playerlogic
// Params 1
// Checksum 0xb3ca7520, Offset: 0x8121
// Size: 0x29
function allowprematchlook( player )
{
    player [[ level.prematchallowfunc ]]( 0 );
    player.prematchlook = 1;
}

// Namespace playerlogic
// Params 1
// Checksum 0xf292bf27, Offset: 0x8152
// Size: 0x43
function clearprematchlook( player )
{
    if ( player.prematchlook && !level.gameended )
    {
        player [[ level.prematchallowfunc ]]( 1 );
        player.prematchlook = undefined;
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xe012a0d5, Offset: 0x819d
// Size: 0x57
function waitforversusmenudone()
{
    level endon( #"prematch_over" );
    self endon( #"versus_menu_done" );
    
    for ( ;; )
    {
        self waittill( #"luinotifyserver", result, value );
        
        if ( result == "versus_done" )
        {
            self notify( #"versus_menu_done" );
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xef26cfe9, Offset: 0x81fc
// Size: 0x11c
function function_5b6c338ab843939f()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"hash_2d419a6536e7a794" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    var_8d825f0657a9c427 = armor::function_22290101992e4874();
    backpackplates = 0;
    
    if ( utility::issharedfuncdefined( #"backpack", #"gettotalitemcountinbag" ) )
    {
        lootid = loot::function_d3e3bcaea591a6a2( "brloot_armor_plate" );
        backpackplates = [[ utility::getsharedfunc( #"backpack", #"gettotalitemcountinbag" ) ]]( lootid );
    }
    
    totalplates = var_8d825f0657a9c427 + backpackplates;
    codcasterclientmatchdata::function_ee35d29284860183( 20, totalplates );
    var_a7ad91e89a3dde85 = 0;
    
    if ( isdefined( self.gasmaskhealth ) && isdefined( self.gasmaskmaxhealth ) )
    {
        var_a7ad91e89a3dde85 = ( self.gasmaskhealth + 1 ) / self.gasmaskmaxhealth;
    }
    
    codcasterclientmatchdata::function_ee35d29284860183( 21, var_a7ad91e89a3dde85 );
    hasselfrevivetoken = laststand::hasselfrevivetoken();
    codcasterclientmatchdata::function_ee35d29284860183( 22, hasselfrevivetoken );
}

// Namespace playerlogic
// Params 1
// Checksum 0x34a7c815, Offset: 0x8320
// Size: 0xec
function function_23bd7fea624acc6f( player )
{
    player endon( #"death_or_disconnect" );
    
    for ( ;; )
    {
        if ( isdefined( player.primaryweaponobj ) && !( player.primaryweaponobj === player.var_709577f800a50e3b ) )
        {
            player setclientweaponinfo( 0, getcompleteweaponname( player.primaryweaponobj ) );
            player.var_709577f800a50e3b = player.primaryweaponobj;
        }
        
        if ( isdefined( player.secondaryweaponobj ) && !( player.secondaryweaponobj === player.var_d0dcd97d91a4a748 ) )
        {
            player setclientweaponinfo( 1, getcompleteweaponname( player.secondaryweaponobj ) );
            player.var_d0dcd97d91a4a748 = player.secondaryweaponobj;
        }
        
        player updatemlgammoinfo();
        player updatecurrentweapon();
        player function_5b6c338ab843939f();
        wait 0.05;
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x293aafa6, Offset: 0x8414
// Size: 0x44a
function function_1c192fb84f87316d()
{
    var_9ebd5d8856246063 = utility::getstructarray( "camera_intro", "targetname" );
    
    if ( !isdefined( var_9ebd5d8856246063 ) || var_9ebd5d8856246063.size == 0 )
    {
        var_9ebd5d8856246063 = [];
        var_9ebd5d8856246063[ 0 ] = spawnstruct();
        var_9ebd5d8856246063[ 0 ].origin = ( 0, 0, 0 );
        var_9ebd5d8856246063[ 0 ].angles = ( 0, 0, 0 );
    }
    
    mapname = game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_a62df42a13dad323":
            var_9ebd5d8856246063[ 0 ].origin = ( 1606.95, 2238.61, 958.77 );
            var_9ebd5d8856246063[ 0 ].angles = ( 17, 215, -4.14 );
            break;
        case #"hash_81c63d549bea3339":
            var_9ebd5d8856246063[ 0 ].origin = ( 310, -627, 279 );
            var_9ebd5d8856246063[ 0 ].angles = ( 4, 196, 0 );
            break;
        case #"hash_8eb456b9e1d842c7":
            var_9ebd5d8856246063[ 0 ].origin = ( 1867, -2487, 664 );
            var_9ebd5d8856246063[ 0 ].angles = ( 15, 118, 0 );
            break;
        case #"hash_9c2fdccb75b37f7e":
            var_9ebd5d8856246063[ 0 ].origin = ( -856, 2771, 1030 );
            var_9ebd5d8856246063[ 0 ].angles = ( 18, 313, 0 );
            break;
        case #"hash_a8186a9f8bd241d6":
            var_9ebd5d8856246063[ 0 ].origin = ( 691, -536, 223 );
            var_9ebd5d8856246063[ 0 ].angles = ( 9, 159, 0 );
            var_9ebd5d8856246063[ 1 ] = spawnstruct();
            var_9ebd5d8856246063[ 1 ].origin = ( 428, 508, 14 );
            var_9ebd5d8856246063[ 1 ].angles = ( 0, 182, 0 );
            break;
        case #"hash_d369b0ca801c4b63":
            var_9ebd5d8856246063[ 0 ].origin = ( 1260, 203, 239 );
            var_9ebd5d8856246063[ 0 ].angles = ( 15, 189, 0 );
            var_9ebd5d8856246063[ 1 ] = spawnstruct();
            var_9ebd5d8856246063[ 1 ].origin = ( -582, -154, 64 );
            var_9ebd5d8856246063[ 1 ].angles = ( 0, 137, 0 );
            break;
        case #"hash_89cd8aae588a4328":
            var_9ebd5d8856246063[ 0 ].origin = ( 2446, 19, 377 );
            var_9ebd5d8856246063[ 0 ].angles = ( 24, 178, 0 );
            var_9ebd5d8856246063[ 1 ] = spawnstruct();
            var_9ebd5d8856246063[ 1 ].origin = ( 435, 11, 15 );
            var_9ebd5d8856246063[ 1 ].angles = ( 0, 0, 0 );
            break;
        case #"hash_51f2bb9a988ac56a":
            var_9ebd5d8856246063[ 0 ].origin = ( 254, 1651, 353 );
            var_9ebd5d8856246063[ 0 ].angles = ( 10, 253, 0 );
            var_9ebd5d8856246063[ 1 ] = spawnstruct();
            var_9ebd5d8856246063[ 1 ].origin = ( 231, -1024, 37 );
            var_9ebd5d8856246063[ 1 ].angles = ( 353, 89, 0 );
            break;
        case #"hash_a11e6e81ea219453":
        case #"hash_ce2681671c034722":
            var_9ebd5d8856246063[ 0 ].origin = ( -36200, -25850, 2000 );
            var_9ebd5d8856246063[ 0 ].angles = ( 25, 70, 0 );
            break;
        case #"hash_5586b38644ed9b26":
            var_9ebd5d8856246063[ 0 ].origin = ( -8982.57, -51049.3, 2653.06 );
            var_9ebd5d8856246063[ 0 ].angles = ( 14, 59, 0 );
            break;
    }
    
    return var_9ebd5d8856246063;
}

// Namespace playerlogic
// Params 1
// Checksum 0xadc55549, Offset: 0x8867
// Size: 0xdbe
function spawnspectatormapcam( cameraoverride )
{
    var_b37687b20ada7bbf = 6;
    var_45d1c75d0359d386 = 4;
    var_c3e665445ce41afc = 4;
    var_6eb3c9ab18f19809 = 0;
    self endon( #"disconnect" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( level.splitscreen || self issplitscreenplayer() )
    {
        self setclientdvars( @"cg_fovscale", "0.65" );
    }
    else
    {
        self setclientdvars( @"cg_fovscale", "1" );
    }
    
    self setclientomnvar( "ui_mapshot_camera", 1 );
    self lerpfovbypreset( "mapflyover" );
    var_9ebd5d8856246063 = function_1c192fb84f87316d();
    
    if ( var_9ebd5d8856246063.size == 0 || flags::gameflag( "infil_will_run" ) )
    {
        self visionsetfadetoblackforplayer( "", 0.75 );
        return;
    }
    
    var_67e2060d64615ca7 = undefined;
    endpoint = undefined;
    var_c213e04cb176f44f = undefined;
    setspawnvariables();
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    player::updatesessionstate( "spectator" );
    self.pers[ "team" ] = "spectator";
    self.team = "spectator";
    player::clearkillcamstate();
    self.friendlydamage = undefined;
    resetuidvarsonspectate();
    
    foreach ( entry in level.teamnamelist )
    {
        self allowspectateteam( entry, 0 );
    }
    
    self allowspectateteam( "freelook", 0 );
    self allowspectateteam( "none", 0 );
    
    if ( isdefined( var_9ebd5d8856246063 ) && var_9ebd5d8856246063.size > 1 && !var_6eb3c9ab18f19809 )
    {
        var_41322d1ff0c48d21 = randomintrange( 0, var_9ebd5d8856246063.size - 1 );
        var_67e2060d64615ca7 = var_9ebd5d8856246063[ var_41322d1ff0c48d21 ];
    }
    else if ( isdefined( var_9ebd5d8856246063 ) )
    {
        var_67e2060d64615ca7 = var_9ebd5d8856246063[ 0 ];
        
        if ( var_6eb3c9ab18f19809 )
        {
            var_c213e04cb176f44f = var_9ebd5d8856246063[ 1 ];
        }
    }
    else
    {
        assertmsg( "<dev string:x1ec>" );
    }
    
    var_67e2060d64615ca7.fil = 1;
    player::_freezecontrols( 1, undefined, "spectatorMapCam" );
    self setspectatedefaults( var_67e2060d64615ca7.origin, var_67e2060d64615ca7.angles );
    self spawn( var_67e2060d64615ca7.origin, var_67e2060d64615ca7.angles );
    player::printspawnmessage( "playerlogic::spawnSpectatorMapCam() !!!CODE SPAWN!!! @" + var_67e2060d64615ca7.origin );
    var_b39c953c4add67ea = spawn( "script_model", var_67e2060d64615ca7.origin );
    var_b39c953c4add67ea setmodel( "tag_origin" );
    var_b39c953c4add67ea.angles = var_67e2060d64615ca7.angles;
    var_66bafc3b57259650 = undefined;
    
    if ( var_6eb3c9ab18f19809 )
    {
        var_66bafc3b57259650 = spawn( "script_model", var_c213e04cb176f44f.origin );
        var_66bafc3b57259650 setmodel( "tag_origin" );
        var_66bafc3b57259650.angles = var_c213e04cb176f44f.angles;
    }
    
    thread waitforversusmenudone();
    
    if ( cameraoverride == 99 )
    {
        result = "debug";
        println( "<dev string:x206>" );
    }
    else if ( flags::gameflag( "prematch_done" ) )
    {
        result = "prematch_over";
    }
    else if ( self.versusdone )
    {
        result = "versus_menu_done";
    }
    else
    {
        result = utility::waittill_any_timeout( 2, "versus_menu_done", "prematch_over" );
    }
    
    if ( result == "timeout" )
    {
        if ( flags::gameflag( "prematch_done" ) )
        {
            result = "prematch_over";
        }
        else
        {
            result = "versus_menu_done";
        }
    }
    
    if ( result == "prematch_over" )
    {
        self visionsetfadetoblackforplayer( "", 0.75 );
        return;
    }
    
    if ( self issplitscreenplayer() && self issplitscreenplayerprimary() )
    {
        otherplayer = self getothersplitscreenplayer();
        otherplayer notify( #"versus_menu_done" );
        waitframe();
    }
    
    self cameralinkto( var_b39c953c4add67ea, "tag_origin", 1 );
    self notify( #"hash_9444ed845fd6c055" );
    
    switch ( level.mapname )
    {
        case #"hash_7ac8036cc19377e5":
            var_b39c953c4add67ea scriptmodelplayanimdeltamotion( "iw7_mp_intro_camera_parkour" );
            self visionsetfadetoblackforplayer( "", 0.75 );
            self playlocalsound( "mp_camera_intro_whoosh" );
            wait var_b37687b20ada7bbf - 0.25;
            return;
        default:
            break;
    }
    
    wait 0.25;
    self visionsetfadetoblackforplayer( "", 0.75 );
    self playlocalsound( "mp_camera_intro_whoosh" );
    curpoint = var_67e2060d64615ca7;
    endpoint[ 0 ] = spawnstruct();
    
    if ( isdefined( var_67e2060d64615ca7.target ) )
    {
        endpoint[ 0 ] = utility::getstruct( var_67e2060d64615ca7.target, "targetname" );
    }
    else
    {
        endpoint[ 0 ].origin = ( 0, 0, 0 );
        endpoint[ 0 ].angles = ( 0, 0, 0 );
    }
    
    switch ( level.mapname )
    {
        case #"hash_a62df42a13dad323":
            endpoint[ 0 ].origin = ( 1925, -857, 1033 );
            endpoint[ 0 ].angles = ( 362, 127, 0 );
            break;
        case #"hash_81c63d549bea3339":
            endpoint[ 0 ].origin = ( -399, -1457, 667 );
            endpoint[ 0 ].angles = ( 15, 57, 0 );
            break;
        case #"hash_8eb456b9e1d842c7":
            endpoint[ 0 ].origin = ( 1422, 2073, 464 );
            endpoint[ 0 ].angles = ( 6, 236, 0 );
            break;
        case #"hash_9c2fdccb75b37f7e":
            endpoint[ 0 ].origin = ( 1559, 1586, 1030 );
            endpoint[ 0 ].angles = ( 30, 234, 0 );
            break;
        case #"hash_a8186a9f8bd241d6":
            endpoint[ 0 ].origin = ( 921, 300, 223 );
            endpoint[ 0 ].angles = ( 8, 202, 0 );
            endpoint[ 1 ] = spawnstruct();
            endpoint[ 1 ].origin = ( 415, 372, 14 );
            endpoint[ 1 ].angles = ( 3, 179, 0 );
            break;
        case #"hash_d369b0ca801c4b63":
            endpoint[ 0 ].origin = ( 714, 440, 167 );
            endpoint[ 0 ].angles = ( 13, 205, 0 );
            endpoint[ 1 ] = spawnstruct();
            endpoint[ 1 ].origin = ( -859, -349, 75 );
            endpoint[ 1 ].angles = ( 7, 104, 0 );
            break;
        case #"hash_89cd8aae588a4328":
            endpoint[ 0 ].origin = ( 1952, 354, 77 );
            endpoint[ 0 ].angles = ( 6, 208, 0 );
            endpoint[ 1 ] = spawnstruct();
            endpoint[ 1 ].origin = ( 906, 9, 15 );
            endpoint[ 1 ].angles = ( 0, 0, 0 );
            var_6eb3c9ab18f19809 = 1;
            break;
        case #"hash_51f2bb9a988ac56a":
            endpoint[ 0 ].origin = ( -1332, 483, 252 );
            endpoint[ 0 ].angles = ( 11, 313, 0 );
            endpoint[ 1 ] = spawnstruct();
            endpoint[ 1 ].origin = ( 65, -547, 351 );
            endpoint[ 1 ].angles = ( 16, 83, 0 );
            break;
        case #"hash_a11e6e81ea219453":
        case #"hash_ce2681671c034722":
            endpoint[ 0 ].origin = ( -30200, -23550, 2000 );
            endpoint[ 0 ].angles = ( 25, 150, 0 );
            break;
        case #"hash_5586b38644ed9b26":
            endpoint[ 0 ].origin = ( 6444.48, -46895.7, 2653.06 );
            endpoint[ 0 ].angles = ( 16, 117, 0 );
            break;
    }
    
    totaldistance = 0;
    
    while ( true )
    {
        if ( isdefined( curpoint.speedadjust ) )
        {
            speedadjustment = 1 / curpoint.speedadjust;
            nodedistance = speedadjustment * distance( curpoint.origin, endpoint[ 0 ].origin );
        }
        else
        {
            nodedistance = distance( curpoint.origin, endpoint[ 0 ].origin );
        }
        
        totaldistance += nodedistance;
        curpoint.distancetotarg = nodedistance;
        curpoint = endpoint[ 0 ];
        
        if ( isdefined( curpoint.target ) )
        {
            endpoint[ 0 ] = utility::getstruct( curpoint.target, "targetname" );
            continue;
        }
        
        break;
    }
    
    curpoint.eol = 1;
    curpoint = var_67e2060d64615ca7;
    
    if ( isdefined( var_67e2060d64615ca7.target ) )
    {
        endpoint[ 0 ] = utility::getstruct( var_67e2060d64615ca7.target, "targetname" );
    }
    else
    {
        endpoint[ 0 ].origin = ( 0, 0, 0 );
        endpoint[ 0 ].angles = ( 0, 0, 0 );
    }
    
    if ( totaldistance > 0 )
    {
        while ( true )
        {
            var_ee0afab2957428bf = curpoint.distancetotarg / totaldistance;
            timetomove = var_6eb3c9ab18f19809 ? var_ee0afab2957428bf * var_45d1c75d0359d386 : var_ee0afab2957428bf * var_b37687b20ada7bbf;
            
            if ( isdefined( endpoint[ 0 ].eol ) )
            {
                decel = timetomove / 2;
            }
            else
            {
                decel = 0;
            }
            
            if ( isdefined( curpoint.fil ) )
            {
                accel = timetomove / 2;
            }
            else
            {
                accel = 0;
            }
            
            var_b39c953c4add67ea moveto( endpoint[ 0 ].origin, timetomove, accel, decel );
            var_b39c953c4add67ea rotateto( endpoint[ 0 ].angles, timetomove, accel, decel );
            
            if ( isdefined( endpoint[ 0 ].eol ) )
            {
                halftime = int( timetomove / 2 );
                wait halftime;
                wait halftime;
            }
            else
            {
                wait timetomove;
            }
            
            curpoint = endpoint[ 0 ];
            
            if ( isdefined( curpoint.target ) )
            {
                endpoint[ 0 ] = utility::getstruct( curpoint.target, "targetname" );
                continue;
            }
            
            break;
        }
    }
    
    if ( var_6eb3c9ab18f19809 )
    {
        totaldistance = 0;
        var_7ad93c516d084e10 = var_c213e04cb176f44f;
        self spawn( var_c213e04cb176f44f.origin, var_c213e04cb176f44f.angles );
        self cameralinkto( var_66bafc3b57259650, "tag_origin", 1 );
        wait 0.25;
        self visionsetfadetoblackforplayer( "", 0.75 );
        self playlocalsound( "mp_camera_intro_whoosh" );
        
        while ( true )
        {
            if ( isdefined( var_7ad93c516d084e10.speedadjust ) )
            {
                speedadjustment = 1 / var_7ad93c516d084e10.speedadjust;
                nodedistance = speedadjustment * distance( var_7ad93c516d084e10.origin, endpoint[ 1 ].origin );
            }
            else
            {
                nodedistance = distance( var_7ad93c516d084e10.origin, endpoint[ 1 ].origin );
            }
            
            totaldistance += nodedistance;
            var_7ad93c516d084e10.distancetotarg = nodedistance;
            
            if ( isdefined( var_7ad93c516d084e10.target ) )
            {
                endpoint[ 1 ] = utility::getstruct( curpoint.target, "targetname" );
                continue;
            }
            
            break;
        }
        
        var_7ad93c516d084e10.eol = 1;
        var_7ad93c516d084e10.fil = 1;
        endpoint[ 1 ].eol = 1;
        
        while ( true )
        {
            var_ee0afab2957428bf = var_7ad93c516d084e10.distancetotarg / totaldistance;
            timetomove = var_6eb3c9ab18f19809 ? var_ee0afab2957428bf * var_c3e665445ce41afc : var_ee0afab2957428bf * var_b37687b20ada7bbf;
            
            if ( isdefined( endpoint[ 1 ].eol ) )
            {
                decel = timetomove / 2;
            }
            else
            {
                decel = 0;
            }
            
            if ( isdefined( var_7ad93c516d084e10.fil ) )
            {
                accel = timetomove / 2;
            }
            else
            {
                accel = 0;
            }
            
            var_66bafc3b57259650 moveto( endpoint[ 1 ].origin, timetomove, accel, decel );
            var_66bafc3b57259650 rotateto( endpoint[ 1 ].angles, timetomove, accel, decel );
            
            if ( isdefined( endpoint[ 1 ].eol ) )
            {
                halftime = int( timetomove / 2 );
                wait halftime;
                wait halftime;
            }
            else
            {
                wait timetomove;
            }
            
            var_7ad93c516d084e10 = endpoint[ 1 ];
            
            if ( isdefined( var_7ad93c516d084e10.target ) )
            {
                endpoint[ 1 ] = utility::getstruct( var_7ad93c516d084e10.target, "targetname" );
                continue;
            }
            
            break;
        }
    }
    
    player::_freezecontrols( 0, undefined, "spectatorMapCam" );
    self.startcament = var_b39c953c4add67ea;
    self setclientomnvar( "ui_mapshot_camera", 0 );
}

// Namespace playerlogic
// Params 3
// Checksum 0x6adb6ac, Offset: 0x962d
// Size: 0x12f
function spawnspectator( origin, angles, gameended )
{
    self notify( #"spawned" );
    self notify( #"end_respawn" );
    self notify( #"joined_spectators" );
    level notify( #"joined_spectators", self );
    self.spawnedasspectator = 1;
    self.waitingtospawnamortize = 0;
    self.waitingtospawn = 0;
    
    if ( isdefined( self.deathspectatepos ) )
    {
        origin = self.deathspectatepos;
        angles = vectortoangles( self.origin - self.deathspectatepos );
    }
    
    if ( isdefined( self.startcament ) && !isdefined( origin ) )
    {
        origin = self.startcament.origin;
        angles = self.startcament.angles;
        self.startcament delete();
    }
    
    if ( isdefined( self.team ) )
    {
        teams::validatealivecount( "spectator", self.team, self, "spawnSpectator" );
    }
    
    in_spawnspectator( origin, angles, gameended );
    thread callback::callback( #"music_player_spectating" );
}

// Namespace playerlogic
// Params 2
// Checksum 0xd3fb9768, Offset: 0x9764
// Size: 0x6b
function respawn_asspectator( origin, angles )
{
    if ( isdefined( self.deathspectatepos ) )
    {
        origin = self.deathspectatepos;
        
        if ( isdefined( self.deathspectateangles ) )
        {
            angles = self.deathspectateangles;
        }
        else
        {
            angles = vectortoangles( self.origin - self.deathspectatepos );
        }
    }
    
    in_spawnspectator( origin, angles );
}

// Namespace playerlogic
// Params 3
// Checksum 0xe96605fd, Offset: 0x97d7
// Size: 0xf5
function in_spawnspectator( origin, angles, gameended )
{
    setspawnvariables();
    var_1e074d485eb927a7 = self.pers[ "team" ];
    
    if ( isdefined( var_1e074d485eb927a7 ) && ( var_1e074d485eb927a7 == "spectator" || var_1e074d485eb927a7 == "codcaster" ) && !level.gameended )
    {
        lower_message::setlowermessageomnvar( "clear_lower_msg" );
    }
    
    self.var_f180f5a67f79ba56 = 1;
    class::loadout_clearperks();
    player::updatesessionstate( "spectator" );
    player::clearkillcamstate();
    self.friendlydamage = undefined;
    self.var_f180f5a67f79ba56 = undefined;
    resetuidvarsonspectate();
    spectating::setspectatepermissions();
    onspawnspectator( origin, angles, gameended );
    
    if ( level.teambased && !level.splitscreen && !self issplitscreenplayer() )
    {
        player::setdof_spectator();
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0x83f7acac, Offset: 0x98d4
// Size: 0x5a
function getplayerfromclientnum( clientnum )
{
    if ( clientnum < 0 )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] getentitynumber() == clientnum )
        {
            return level.players[ i ];
        }
    }
}

// Namespace playerlogic
// Params 3
// Checksum 0xf36fc881, Offset: 0x9937
// Size: 0x2da
function onspawnspectator( origin, angles, gameended )
{
    if ( isdefined( origin ) && isdefined( angles ) )
    {
        self setspectatedefaults( origin, angles );
        self spawn( origin, angles );
        player::printspawnmessage( "playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + origin );
        return;
    }
    
    spawnpoint = getspectatepoint();
    
    if ( level.usespawnselection )
    {
        if ( level.usestaticspawnselectioncamera )
        {
            spawnpoint = spawnselection::getstaticcameraposition( self.sessionteam );
        }
        else if ( self.sessionteam == "allies" )
        {
            ref = "gw_fob_alliesHQ";
            spawnpoint = level.spawncameras[ ref ][ "allies" ];
        }
        else if ( self.sessionteam == "axis" )
        {
            ref = "gw_fob_axisHQ";
            spawnpoint = level.spawncameras[ ref ][ "axis" ];
        }
    }
    
    var_b98bba65a2a3a72 = 8;
    
    if ( isdefined( level.camerapos ) && level.camerapos.size )
    {
        for ( i = 0; i < level.camerahighestindex + 1 && i < var_b98bba65a2a3a72 ; i++ )
        {
            if ( !( isdefined( level.camerapos[ i ] ) && isdefined( level.cameraang[ i ] ) ) )
            {
                continue;
            }
            
            self setmlgcameradefaults( i, level.camerapos[ i ], level.cameraang[ i ] );
            level.cameramapobjs[ i ].origin = level.camerapos[ i ];
            level.numbermapobjs[ i ].origin = level.camerapos[ i ];
            level.cameramapobjs[ i ].angles = level.cameraang[ i ];
            level.numbermapobjs[ i ].angles = level.cameraang[ i ];
        }
    }
    else
    {
        for ( i = 0; i < var_b98bba65a2a3a72 ; i++ )
        {
            self setmlgcameradefaults( i, spawnpoint.origin, spawnpoint.angles );
        }
    }
    
    self setspectatedefaults( spawnpoint.origin, spawnpoint.angles );
    
    if ( isdefined( gameended ) )
    {
        self allowspectateteam( "freelook", 1 );
        self allowspectateteam( "none", 1 );
    }
    
    if ( game_utility_mp::isgroundwarcoremode() && !self.hasspawned )
    {
        self function_e19ccf4da1a61ba7( spawnpoint.origin );
    }
    
    self spawn( spawnpoint.origin, spawnpoint.angles );
    player::printspawnmessage( "playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + spawnpoint.origin );
}

// Namespace playerlogic
// Params 0
// Checksum 0x15654afb, Offset: 0x9c19
// Size: 0x5ab
function getspectatepoint()
{
    if ( game_utility::getgametype() == "gwtdm" && isdefined( level.spawncameras[ "default" ] ) )
    {
        return level.spawncameras[ "default" ][ self.sessionteam ];
    }
    
    if ( game_utility::getgametype() == "brtdm" )
    {
        return level.brtdm_config.spectatepoint;
    }
    
    if ( level.var_49876561ccb7f1db && level.var_49876561ccb7f1db[ self.team ?? self.sessionteam ] )
    {
        return level.var_49876561ccb7f1db[ self.team ?? self.sessionteam ];
    }
    
    if ( !isdefined( level.spectatepoints ) )
    {
        spawnpoints = getentarray( "mp_global_intermission", #classname );
        assert( spawnpoints.size, "<dev string:x213>" );
        validspawnpoints = [];
        
        if ( action_park_utility::is_enabled() )
        {
            foreach ( point in spawnpoints )
            {
                if ( !isdefined( point.script_noteworthy ) )
                {
                    spawnpoints = arrayremove( spawnpoints, point );
                }
            }
        }
        
        if ( isdefined( game_utility::getlocaleid() ) )
        {
            if ( level.localeid == "locale_6" )
            {
                spawnpoint = spawn( "script_origin", ( 25642, -26550, 1818 ) );
                spawnpoint.targetname = "getSpectatePoint";
                spawnpoint.script_noteworthy = level.localeid;
                spawnpoint.angles = ( 14, 101, 0 );
                spawnpoints[ spawnpoints.size ] = spawnpoint;
            }
            else if ( level.localeid == "locale_3" )
            {
                spawnpoint = spawn( "script_origin", ( 34440, -18522, 995 ) );
                spawnpoint.targetname = "getSpectatePoint";
                spawnpoint.script_noteworthy = level.localeid;
                spawnpoint.angles = ( 10, 281, 0 );
                spawnpoints[ spawnpoints.size ] = spawnpoint;
            }
            else if ( level.localeid == "locale_deadtown" || level.localeid == "locale_deadtown2" || level.localeid == "locale_deadtown3" )
            {
                spawnpoint = spawn( "script_origin", ( -34210, -37830, 9200 ) );
                spawnpoint.targetname = "getSpectatePoint";
                spawnpoint.script_noteworthy = level.localeid;
                spawnpoint.angles = ( 36, 138, 0 );
                spawnpoints[ spawnpoints.size ] = spawnpoint;
            }
            else if ( level.localeid == "locale_farmland" || level.localeid == "locale_farmland2" )
            {
                spawnpoint = spawn( "script_origin", ( -33600, -45460, 9000 ) );
                spawnpoint.targetname = "getSpectatePoint";
                spawnpoint.script_noteworthy = level.localeid;
                spawnpoint.angles = ( 36, 17, 0 );
                spawnpoints[ spawnpoints.size ] = spawnpoint;
            }
            else if ( level.localeid == "locale_entertainment1" )
            {
                spawnpoint = spawn( "script_origin", ( 23310, -37300, 12325 ) );
                spawnpoint.targetname = "getSpectatePoint";
                spawnpoint.script_noteworthy = level.localeid;
                spawnpoint.angles = ( 52, 160, 0 );
                spawnpoints[ spawnpoints.size ] = spawnpoint;
            }
            
            foreach ( spawnpoint in spawnpoints )
            {
                if ( spawnpoint.script_noteworthy == level.localeid )
                {
                    validspawnpoints[ validspawnpoints.size ] = spawnpoint;
                    continue;
                }
                
                spawnpoint delete();
            }
        }
        else
        {
            foreach ( spawnpoint in spawnpoints )
            {
                if ( !isdefined( spawnpoint.script_noteworthy ) || !issubstr( spawnpoint.script_noteworthy, "locale" ) )
                {
                    validspawnpoints[ validspawnpoints.size ] = spawnpoint;
                    continue;
                }
                
                spawnpoint delete();
            }
        }
        
        if ( validspawnpoints.size == 0 )
        {
            assert( validspawnpoints.size, "<dev string:x240>" );
            spawnpoint = spawn( "script_origin", ( 0, 0, 0 ) );
            spawnpoint.targetname = "getSpectatePoint";
            spawnpoint.angles = ( 0, 0, 0 );
            validspawnpoints[ validspawnpoints.size ] = spawnpoint;
        }
        
        level.spectatepoints = validspawnpoints;
    }
    
    spawnpoint = spawnlogic::getspawnpoint_random( level.spectatepoints );
    return spawnpoint;
}

// Namespace playerlogic
// Params 3
// Checksum 0xb9eb3b28, Offset: 0xa1cd
// Size: 0x2d6
function spawnintermission( spawnpoint, sessionstate, everyonehearseveryone )
{
    self endon( #"disconnect" );
    self notify( #"spawned" );
    self notify( #"end_respawn" );
    
    if ( !isdefined( sessionstate ) )
    {
        sessionstate = "intermission";
    }
    
    if ( !isdefined( everyonehearseveryone ) )
    {
        everyonehearseveryone = 1;
    }
    
    setspawnvariables();
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    lower_message::clearlowermessages();
    
    if ( !getdvarint( @"hash_8117734e3e0f8be5", 0 ) )
    {
        player::_freezecontrols( 1, undefined, "spawnIntermission" );
    }
    
    if ( everyonehearseveryone )
    {
        self setclientdvar( @"cg_everyonehearseveryone", 1 );
    }
    
    if ( isdefined( level.finalkillcam_winner ) && level.finalkillcam_winner != "none" && isdefined( level.match_end_delay ) && game_utility_mp::waslastround() && !level.doing_winners_circle )
    {
        wait level.match_end_delay;
    }
    
    if ( isdefined( level.spawnintermissiondelayseconds ) )
    {
        wait level.spawnintermissiondelayseconds;
    }
    
    if ( !isdefined( spawnpoint ) )
    {
        if ( !isdefined( level.localeid ) )
        {
            if ( level.var_e35ab30242703f86.size )
            {
                spawnpoints = level.var_e35ab30242703f86;
            }
            else
            {
                spawnpoints = getentarray( "mp_global_intermission", #classname );
            }
            
            spawnpoints = spawnscoring::checkdynamicspawns( spawnpoints );
            assert( spawnpoints.size, "<dev string:x213>" );
            
            if ( action_park_utility::is_enabled() )
            {
                foreach ( point in spawnpoints )
                {
                    if ( !isdefined( point.script_noteworthy ) )
                    {
                        spawnpoints = arrayremove( spawnpoints, point );
                    }
                }
            }
            
            if ( level.var_b7013d9ccd1b171a )
            {
                spawnpoint = utility::array_random( spawnpoints );
            }
            else
            {
                spawnpoint = spawnpoints[ 0 ];
            }
        }
        else
        {
            spawnpoint = getspectatepoint();
        }
    }
    
    if ( isdefined( level.var_a190593393675f2f ) )
    {
        self [[ level.var_a190593393675f2f ]]( spawnpoint );
    }
    
    if ( !level.doing_winners_circle )
    {
        player::updatesessionstate( sessionstate );
    }
    
    player::clearkillcamstate();
    self.friendlydamage = undefined;
    
    if ( !isdefined( level.custom_ending ) )
    {
        self spawn( spawnpoint.origin, spawnpoint.angles );
        player::printspawnmessage( "playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + spawnpoint.origin );
        player::setdof_spectator();
    }
    
    if ( !getdvarint( @"hash_8117734e3e0f8be5", 0 ) )
    {
        player::_freezecontrols( 1, undefined, "spawnIntermission" );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x2d820aba, Offset: 0xa4ab
// Size: 0x88
function spawnendofgame()
{
    if ( isdefined( level.modespawnendofgame ) && self [[ level.modespawnendofgame ]]() )
    {
        return;
    }
    
    if ( isdefined( level.custom_ending ) && game_utility_mp::waslastround() )
    {
        level notify( #"start_custom_ending" );
    }
    
    if ( !self.controlsfrozen )
    {
        player::_freezecontrols( 1, undefined, "spawnEndOfGame" );
    }
    
    if ( level.doing_winners_circle )
    {
        self notify( #"spawned" );
        player::clearkillcamstate();
        return;
    }
    
    spawnspectator();
}

// Namespace playerlogic
// Params 0
// Checksum 0x8b35a758, Offset: 0xa53b
// Size: 0x28
function setspawnvariables()
{
    shellshock_utility_cpmp::_stopshellshock();
    self stoprumble( "damage_heavy" );
    self.deathposition = undefined;
    self.var_6db12e4862ea2427 = 0;
}

// Namespace playerlogic
// Params 1
// Checksum 0xfdcdd17d, Offset: 0xa56b
// Size: 0x207
function function_6721fb96f1931666( player )
{
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    weapon_accuracy = 0;
    totalshots = player.pers[ "shotsFired" ];
    totalhits = player.pers[ "shotsHit" ];
    
    if ( isdefined( totalhits ) && totalshots > 0 )
    {
        weapon_accuracy = float( totalhits / totalshots * 100 );
    }
    
    xp_at_start = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].xp_at_start ) )
    {
        xp_at_start = player.pers[ "telemetry" ].xp_at_start;
    }
    
    xp_at_end = 0;
    
    if ( player game_utility_mp::rankingenabled() )
    {
        xp_at_end = player.pers[ "rankxp" ];
    }
    
    playerstats = spawnstruct();
    playerstats.time_in_match = gettime() - player.connecttime;
    playerstats.kills = player.pers[ "kills" ];
    playerstats.deaths = player.pers[ "deaths" ];
    playerstats.headshots = player.pers[ "headshots" ];
    playerstats.xp_earned = xp_at_end - xp_at_start;
    playerstats.accuracy = weapon_accuracy;
    playerstats.xuid = player getxuid();
    playerstats.winner = player.pers[ "match_outcome" ] == "win";
    playerstats.team = getcodeteamindex( isdefined( player.pers[ "team" ] ) ? player.pers[ "team" ] : "none" );
    return playerstats;
}

// Namespace playerlogic
// Params 1
// Checksum 0x441d1e8a, Offset: 0xa77b
// Size: 0x803
function callback_playerdisconnect( reason )
{
    if ( !isdefined( self.connected ) )
    {
        return;
    }
    
    self.disconnecting = 1;
    isbotplayer = isbot( self );
    isuibot = manager::isuibot();
    
    if ( !isuibot )
    {
        setomnvar( "ui_infofeed_connection_player", self getentitynumber() );
        setomnvar( "ui_infofeed_connection_status", 0 );
        setomnvar( "ui_infofeed_connection_notify", gettime() );
    }
    
    playerstats = function_6721fb96f1931666( self );
    
    if ( isdefined( playerstats ) )
    {
        self function_86664f2af70d102e( playerstats );
    }
    
    if ( !isuibot && getdvarint( @"online_matchdata_enabled" ) != 0 )
    {
        playercountleft = getmatchdata( "commonMatchData", "player_count_left" );
        playercountleft++;
        setmatchdata( "commonMatchData", "player_count_left", playercountleft );
    }
    
    result = undefined;
    
    if ( !isbotplayer && ( isbrgamemode() || isdefined( level.modeplayerkilledspawn ) ) )
    {
        if ( self.pers[ "hasDoneAnyCombat" ] || self.pers[ "participation" ] )
        {
            result = "eliminated";
        }
        
        if ( level.modeplayerkilledspawn )
        {
            result = "eliminated";
        }
        
        if ( level.var_c7696bc1e0d0289e && self isinexecutionvictim() && isalive( self ) )
        {
            attacker = self getexecutionpartner();
            var_23646deaadab01d3 = self.health;
            
            if ( damage::shouldrecorddamagestats( self ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "damage" ] ) )
                    {
                        attacker.leaderboarddata[ "damage" ] = attacker.leaderboarddata[ "damage" ] + var_23646deaadab01d3;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "damage" ] ) )
                    {
                        [[ level.leaderboardfunc[ "damage" ] ]]( attacker, var_23646deaadab01d3 );
                    }
                    
                    assert( isint( var_23646deaadab01d3 ) || isfloat( var_23646deaadab01d3 ), "<dev string:x198>" );
                    
                    if ( isdefined( attacker.pers[ "damage" ] ) )
                    {
                        attacker.pers[ "damage" ] = attacker.pers[ "damage" ] + var_23646deaadab01d3;
                    }
                }
                
                if ( !isdefined( attacker.damagethisround ) )
                {
                    attacker.damagethisround = var_23646deaadab01d3;
                }
                else
                {
                    attacker.damagethisround += var_23646deaadab01d3;
                }
            }
            else if ( isdefined( level.onattackerdamagenottracked ) )
            {
                attacker [[ level.onattackerdamagenottracked ]]( var_23646deaadab01d3 );
            }
            
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"br" ][ #"hash_ccc082092db526b8" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                attacker [[ var_32dbca3143d9c4a5 ]]( "damageDealt", attacker.pers[ "damage" ] );
            }
            
            self kill( self.origin, attacker, attacker, "MOD_EXECUTION" );
            self notify( #"disconnect" );
        }
    }
    
    if ( isdefined( level.endgamewinner ) )
    {
        result = level.endgamewinner;
    }
    
    disconnect_event_aggregator::function_c57c9f42e530d106( self );
    
    if ( isdefined( result ) )
    {
        game_utility::stopkeyearning( result );
    }
    
    if ( killstreak::iscontrollingproxyagent() )
    {
        self restorecontrolagent();
    }
    
    if ( !isuibot )
    {
        telemetrydata = spawnstruct();
        telemetrydata.player = self;
        telemetrydata.disconnectreason = reason;
        
        if ( isbrgamemode() )
        {
            if ( !isdefined( self.pers[ "match_outcome" ] ) )
            {
                var_16925f8a393cac3e = isdefined( result ) && self.team == result;
                
                if ( var_16925f8a393cac3e )
                {
                    self.pers[ "match_outcome" ] = "win";
                }
                else
                {
                    self.pers[ "match_outcome" ] = "loss";
                }
            }
        }
        
        telemetry_utils::function_af2d366f9522f76f( "callback_on_player_disconnect", telemetrydata );
    }
    
    removeplayerondisconnect();
    game_utility_common::removefromparticipantsarray();
    game_utility_common::removefromcharactersarray();
    player_utility::removefromdismembermentlist();
    function_7531e9c14a2a5653( self, reason );
    
    if ( !level.teambased )
    {
        game[ "roundsWon" ][ self.guid ] = undefined;
    }
    
    if ( level.splitscreen )
    {
        players = level.players;
        
        if ( players.size <= 1 )
        {
            level thread gamelogic_mp::forceend();
        }
    }
    
    if ( !isbotplayer && isdefined( self.kills ) && isdefined( self.deaths ) )
    {
        var_9acfc5169ae0e036 = getdvarint( @"hash_9e2f598909a3fc6e", 0 );
        
        if ( game_utility::getgametype() == "arena" && self.pers[ "telemetry" ].var_66d40dcc3e2ce088 > 1 )
        {
            if ( !isdefined( self.arenadamage ) )
            {
                return;
            }
            
            damage = self.arenadamage;
            println( "<dev string:x25f>" + damage );
            
            if ( isdefined( level.var_871c7d9fbeeb5187 ) )
            {
                self [[ level.var_871c7d9fbeeb5187 ]]( self, self.clientid, damage );
            }
            else
            {
                gamelogic_mp::function_871c7d9fbeeb5187( self, self.clientid, damage );
            }
        }
        else if ( self.pers[ "telemetry" ].var_66d40dcc3e2ce088 >= var_9acfc5169ae0e036 && self.timeplayed[ "total" ] > 0 )
        {
            timeplayed = self.timeplayed[ "total" ] / 60;
            
            if ( timeplayed == 0 )
            {
                timeplayed = 1;
            }
            
            kd = ( self.kills - self.deaths ) / timeplayed;
            println( "<dev string:x25f>" + self.kills + "<dev string:x267>" + self.deaths + "<dev string:x26b>" + kd );
            
            if ( isdefined( level.var_871c7d9fbeeb5187 ) )
            {
                self [[ level.var_871c7d9fbeeb5187 ]]( self, self.clientid, kd );
            }
            else
            {
                gamelogic_mp::function_871c7d9fbeeb5187( self, self.clientid, kd );
            }
        }
    }
    else
    {
        println( "<dev string:x26f>" );
    }
    
    lpselfnum = self getentitynumber();
    lpguid = self.guid;
    logprint( "Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n" );
    
    if ( analyticsstreamerislogfilestreamingenabled() )
    {
        analyticsstreamerlogfilewritetobuffer( "Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n" );
    }
    
    thread events::disconnected();
    
    if ( level.gameended )
    {
        gamescore::removedisconnectedplayerfromplacement();
    }
    
    if ( isdefined( self.team ) )
    {
        removefromteamcount();
        
        if ( arraycontains( level.teamdata[ self.team ][ "alivePlayers" ], self ) )
        {
            removefromalivecount( 1, "disconnect", 0 );
            teams::validatealivecount( "disconnect", self.team, self, "Callback_PlayerDisconnect" );
        }
        
        if ( isdefined( self.sessionsquadid ) && isdefined( self.team ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squads::leavesquad( self.team, self.sessionsquadid );
        }
    }
    
    weapon_utility::clearlockedonondisconnect( self );
    level thread [[ level.updategameevents ]]();
    rejoin_utility::rejoin_ondisconnect( reason );
    disconnect_event_aggregator::rundisconnectcallbacks( self );
    gamelogic_mp::updatematchhasmorethan1playeromnvaronplayerdisconnect();
    
    if ( !isbotplayer )
    {
        utility::trycall( level.matchdata_logplayerdata, reason );
        
        if ( !gamelogic_mp::function_45db3a140da5f4b1( self ) )
        {
            level thread endemptygamewatcher();
        }
    }
    
    game_utility::function_f3b8c430e6514f98( 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0xd3e258fa, Offset: 0xaf86
// Size: 0x111
function endemptygamewatcher()
{
    level notify( #"endemptygamewatcher" );
    level endon( #"endemptygamewatcher" );
    println( "<dev string:x296>" );
    var_aa74dc1c83b9336c = getdvarfloat( @"hash_36c64acc6ca5e510", 30 );
    wait var_aa74dc1c83b9336c;
    
    if ( gamelogic_mp::function_45db3a140da5f4b1() )
    {
        println( "<dev string:x2ce>" );
        return;
    }
    
    if ( isbrgamemode() && getdvarint( @"hash_e709033afed344c5", 1 ) == 1 && level.br_prematchstarted )
    {
        gamelogic_mp::sendendofmatchdata();
    }
    
    endgamemethod = -2;
    reason = "Force end game, last human player disconnected";
    logstring( "[KEY_MOMENT] ForceEndGame. endGameMethod=" + endgamemethod + " reason=" + reason );
    namespace_ddca46d216b096e2::debuglogforceendgame( endgamemethod );
    
    if ( isdefined( level.var_59b27686ba033588 ) )
    {
        thread [[ level.var_59b27686ba033588 ]]( "none", game[ "end_reason" ][ "host_ended_game" ] );
        return;
    }
    
    thread gamelogic_mp::endgame( "none", game[ "end_reason" ][ "host_ended_game" ] );
}

// Namespace playerlogic
// Params 0
// Checksum 0x8ab3af61, Offset: 0xb09f
// Size: 0xb8
function removeplayerondisconnect()
{
    found = 0;
    
    for ( entry = 0; entry < level.players.size ; entry++ )
    {
        if ( level.players[ entry ] == self )
        {
            found = 1;
            
            while ( entry < level.players.size - 1 )
            {
                level.players[ entry ] = level.players[ entry + 1 ];
                assert( level.players[ entry ] != self );
                entry++;
            }
            
            level.players[ entry ] = undefined;
            break;
        }
    }
    
    level.playersbyentitynumber[ self getentitynumber() ] = undefined;
    assert( found );
}

// Namespace playerlogic
// Params 0
// Checksum 0xd6851b63, Offset: 0xb15f
// Size: 0x51
function initclientdvarssplitscreenspecific()
{
    if ( level.splitscreen || self issplitscreenplayer() )
    {
        self setclientdvars( @"cg_fovscale", "0.75" );
        setdvar( @"hash_d18838f3e4b65d16", 0 );
        return;
    }
    
    self setclientdvars( @"cg_fovscale", "1" );
}

// Namespace playerlogic
// Params 0
// Checksum 0x907e3670, Offset: 0xb1b8
// Size: 0x239
function initclientdvars()
{
    if ( getdvarint( @"hash_e8ed2e7086fa6182" ) )
    {
        self function_a565dafac620d68e( "hw_kuwahara" );
    }
    
    setdvar( @"cg_drawcrosshair", 1 );
    setdvar( @"cg_drawcrosshairnames", 1 );
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        setdvar( @"cg_drawcrosshair", 0 );
        setdvar( @"cg_drawcrosshairnames", 1 );
    }
    
    if ( isdefined( level.alwaysdrawfriendlynames ) && level.alwaysdrawfriendlynames )
    {
        setdvar( @"cg_drawfriendlynamesalways", 1 );
    }
    else
    {
        setdvar( @"cg_drawfriendlynamesalways", 0 );
    }
    
    self setclientdvars( @"cg_drawspectatormessages", 1 );
    initclientdvarssplitscreenspecific();
    
    if ( game_utility_mp::getgametypenumlives() )
    {
        if ( level.teambased )
        {
            self setclientdvars( @"cg_deadchatwithdead", 0, @"cg_deadchatwithteam", 1, @"cg_deadhearteamliving", 1, @"cg_deadhearallliving", 0 );
        }
        else
        {
            self setclientdvars( @"cg_deadchatwithdead", 1, @"cg_deadchatwithteam", 0, @"cg_deadhearteamliving", 0, @"cg_deadhearallliving", 0 );
        }
    }
    else
    {
        self setclientdvars( @"cg_deadchatwithdead", 0, @"cg_deadchatwithteam", 1, @"cg_deadhearteamliving", 1, @"cg_deadhearallliving", 0 );
    }
    
    if ( level.teambased )
    {
        self setclientdvars( @"cg_everyonehearseveryone", 0 );
    }
    
    self setclientdvar( @"voice_proximity_enemy_client", 1 );
    
    if ( !level.prematchstarted && level.gametypebundle.var_f4153a316844f5b2 )
    {
        self setclientdvar( @"voice_proximity_enemy_client", 0 );
    }
    
    self setclientdvar( @"cg_fov", 65 );
    self setclientdvar( @"cg_disable_user_fov", 0 );
    
    if ( getdvarint( @"scr_hitloc_debug" ) )
    {
        for ( i = 0; i < 6 ; i++ )
        {
            self setclientdvar( hashcat( @"hash_3dd1dde9508849d5", string( i ) ), "" );
        }
        
        self.hitlocinited = 1;
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x92ad8833, Offset: 0xb3f9
// Size: 0xb9
function connect_validateplayerteam()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    forceteam = getdvar( @"scr_force_team", "" );
    
    if ( self.sessionteam == "none" && game_utility_mp::matchmakinggame() && level.teambased && !isbot( self ) && !istestclient( self ) && !self iscodcaster() && !level.gametypebundle.var_f5242bb1aa8222f8 && !team_utility::isgameplayteam( forceteam ) )
    {
        println( "<dev string:x308>" );
        wait 1.5;
        kick( self getentitynumber(), &"exe/playerkicked_invalidteam" );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x60c7550c, Offset: 0xb4ba
// Size: 0xa9
function queueconnectednotify()
{
    for ( ;; )
    {
        if ( !isdefined( level.players_waiting_for_callback ) )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    for ( ;; )
    {
        for ( i = 0; i < level.players_waiting_for_callback.size ; i++ )
        {
            player = level.players_waiting_for_callback[ i ];
            
            if ( isdefined( player ) )
            {
                level notify( #"connected", player );
                player notify( #"connected_continue" );
                level.players_waiting_for_callback[ i ] = undefined;
                break;
            }
        }
        
        temparray = function_5713d46873b29625( level.players_waiting_for_callback );
        level.players_waiting_for_callback = temparray;
        waitframe();
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x9668656f, Offset: 0xb56b
// Size: 0x41
function initsegmentstats()
{
    level endon( #"game_ended" );
    level thread recordplayersegmentdata();
    
    while ( true )
    {
        level waittill( #"connected", player );
        level thread createplayersegmentstats( player );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xffea2be6, Offset: 0xb5b4
// Size: 0xed
function recordplayersegmentdata()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    wait 4;
    var_bb83ea67c648abba = 5;
    
    while ( true )
    {
        processedplayers = 0;
        wait 1;
        players = level.players;
        
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.canrecordsegmentstats )
            {
                player thread updateplayersegmentdata();
            }
            
            processedplayers++;
            processedplayers %= var_bb83ea67c648abba;
            
            if ( processedplayers == 0 )
            {
                waitframe();
            }
        }
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0x4ce57bf2, Offset: 0xb6a9
// Size: 0xd8
function createplayersegmentstats( player )
{
    player endon( #"disconnect" );
    player waittill( #"spawned_player" );
    
    if ( !isdefined( player.pers[ "distanceTotal" ] ) )
    {
        player.pers[ "distanceTotal" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "movingTotal" ] ) )
    {
        player.pers[ "movingTotal" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "movementUpdateCount" ] ) )
    {
        player.pers[ "movementUpdateCount" ] = 0;
    }
    
    player.savedsegmentposition = player.origin;
    player.positionptm = player.origin;
    player.canrecordsegmentstats = 1;
}

// Namespace playerlogic
// Params 0
// Checksum 0x8322c62e, Offset: 0xb789
// Size: 0x5a
function function_f7c2c4a64d5b928()
{
    self.pers[ "movementUpdateCount" ] = 0;
    self.pers[ "distanceTotal" ] = 0;
    self.pers[ "movingTotal" ] = 0;
    self.savedsegmentposition = undefined;
    self.positionptm = undefined;
    self.haslanded = 0;
    function_6ea87ad28b31cae1();
}

// Namespace playerlogic
// Params 0
// Checksum 0x91344d25, Offset: 0xb7eb
// Size: 0xc7
function function_f4c385c8fd5c2e8f()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    wait 4;
    
    while ( !isdefined( level.players ) || level.players.size < 1 )
    {
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        if ( player.canrecordsegmentstats )
        {
            player function_f7c2c4a64d5b928();
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x9adce315, Offset: 0xb8ba
// Size: 0x3ba
function updateplayersegmentdata()
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.savedsegmentposition ) )
    {
        self.savedsegmentposition = self.origin;
        self.positionptm = self.origin;
    }
    
    if ( utility::isusingremote() )
    {
        self waittill( #"stopped_using_remote" );
        self.savedsegmentposition = self.origin;
        self.positionptm = self.origin;
        return;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "movementUpdateCount" ] ) )
        {
            self.leaderboarddata[ "movementUpdateCount" ] = self.leaderboarddata[ "movementUpdateCount" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "movementUpdateCount" ] ) )
        {
            [[ level.leaderboardfunc[ "movementUpdateCount" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x198>" );
        
        if ( isdefined( self.pers[ "movementUpdateCount" ] ) )
        {
            self.pers[ "movementUpdateCount" ] = self.pers[ "movementUpdateCount" ] + 1;
        }
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "distanceTotal" ] ) )
        {
            self.leaderboarddata[ "distanceTotal" ] = self.leaderboarddata[ "distanceTotal" ] + distance2d( self.savedsegmentposition, self.origin );
        }
        
        if ( isdefined( level.leaderboardfunc[ "distanceTotal" ] ) )
        {
            [[ level.leaderboardfunc[ "distanceTotal" ] ]]( self, distance2d( self.savedsegmentposition, self.origin ) );
        }
        
        assert( isint( distance2d( self.savedsegmentposition, self.origin ) ) || isfloat( distance2d( self.savedsegmentposition, self.origin ) ), "<dev string:x198>" );
        
        if ( isdefined( self.pers[ "distanceTotal" ] ) )
        {
            self.pers[ "distanceTotal" ] = self.pers[ "distanceTotal" ] + distance2d( self.savedsegmentposition, self.origin );
        }
    }
    
    self.savedsegmentposition = self.origin;
    
    if ( self.pers[ "movementUpdateCount" ] % 5 == 0 )
    {
        distancetraveled = distance2d( self.positionptm, self.origin );
        self.positionptm = self.origin;
        
        if ( distancetraveled > 16 )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "movingTotal" ] ) )
                {
                    self.leaderboarddata[ "movingTotal" ] = self.leaderboarddata[ "movingTotal" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "movingTotal" ] ) )
                {
                    [[ level.leaderboardfunc[ "movingTotal" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x198>" );
                
                if ( isdefined( self.pers[ "movingTotal" ] ) )
                {
                    self.pers[ "movingTotal" ] = self.pers[ "movingTotal" ] + 1;
                }
            }
        }
    }
}

/#

    // Namespace playerlogic
    // Params 0
    // Checksum 0xa195892b, Offset: 0xbc7c
    // Size: 0xa2, Type: dev
    function function_9d76ec8c8a33a47c()
    {
        if ( level.splitscreen || isdefined( self.pers[ "<dev string:x333>" ] ) )
        {
            return;
        }
        
        var_2fd5d183329d890 = 0;
        var_10a0ae80a78e1b0e = getmatchrulesdata( "<dev string:x339>", "<dev string:x346>" );
        
        if ( var_10a0ae80a78e1b0e > 0 )
        {
            if ( isdefined( level.starttime ) )
            {
                timepassed = ( gettime() - level.starttime ) / 1000;
                
                if ( timepassed <= var_10a0ae80a78e1b0e )
                {
                    var_2fd5d183329d890 = 1;
                }
            }
            else
            {
                var_2fd5d183329d890 = 1;
            }
        }
        
        if ( !var_2fd5d183329d890 )
        {
            iprintln( &"mp/connected", self );
        }
    }

#/

// Namespace playerlogic
// Params 1
// Checksum 0x9ec4ebbe, Offset: 0xbd26
// Size: 0x60, Type: bool
function shouldshowwidemapshot( normalizedtimepassed )
{
    if ( level.var_693302e6ea51684f || getdvarint( @"scr_shoulddisablemapflyin", 1 ) )
    {
        return false;
    }
    
    return !isbrgamemode() && normalizedtimepassed < level.prematchperiod && !self.btestclient && !flags::gameflag( "infil_will_run" );
}

// Namespace playerlogic
// Params 3
// Checksum 0x993469ca, Offset: 0xbd8f
// Size: 0x162
function setuipregamefadeup( waitmsg, messagelistener, keepui )
{
    self endon( #"disconnect" );
    
    if ( keepui )
    {
        game_utility::fadetoblackforplayerkeepui( self, 1, 0 );
    }
    else
    {
        game_utility::fadetoblackforplayer( self, 1, 0 );
    }
    
    if ( ( flags::gameflag( "infil_will_run" ) || flags::gameflag( "loadout_will_run" ) ) && !flags::gameflag( "prematch_done" ) )
    {
        thread function_70f5e0a0db89d386( keepui );
    }
    
    starttime = gettime();
    
    if ( isdefined( messagelistener ) && isdefined( waitmsg ) )
    {
        messagelistener waittill( waitmsg );
    }
    
    streamhint::playerwaittillstreamhintcomplete();
    action_park_utility::function_fd32c02a56ebd02d( self );
    mintime = getdvarfloat( @"hash_d91436487f90e63c", level.gametypebundle.var_c967b6c085dda42f ?? 0 );
    
    if ( mintime > 0 )
    {
        waited = ( gettime() - starttime ) / 1000;
        
        if ( waited < mintime )
        {
            wait mintime - waited;
        }
    }
    
    fadetime = getdvarfloat( @"hash_1b65b5ed4995fe92", level.gametypebundle.var_b2d6d9133c9d8f6b ?? 0.5 );
    level utility::flag_set( "pregame_fadeup_begin" );
    
    if ( keepui )
    {
        game_utility::fadetoblackforplayerkeepui( self, 0, fadetime );
        return;
    }
    
    game_utility::fadetoblackforplayer( self, 0, fadetime );
}

// Namespace playerlogic
// Params 1
// Checksum 0xf012b2d9, Offset: 0xbef9
// Size: 0x139
function function_70f5e0a0db89d386( keepui )
{
    self endon( #"disconnect" );
    level endon( #"hash_b1e2f5600e4e8b88" );
    level waittill( #"hash_bd6935872ca1b8ee" );
    spawnpoints = getentarray( "mp_global_intermission", #classname );
    
    if ( spawnpoints.size > 0 )
    {
        intermissionspawn = function_47c86977a18df38b( spawnpoints, self.origin );
        
        if ( isdefined( intermissionspawn ) )
        {
            cameraentity = spawn( "script_model", intermissionspawn.origin );
            
            if ( isdefined( cameraentity ) )
            {
                cameraentity setmodel( "tag_origin" );
                cameraentity.angles = intermissionspawn.angles;
                cameraentity.data = intermissionspawn;
                self cameralinkto( cameraentity, "tag_origin", 1, 1 );
            }
            else
            {
                assert( isdefined( cameraentity ), "<dev string:x35c>" );
            }
        }
        else
        {
            assert( isdefined( intermissionspawn ), "<dev string:x38a>" );
        }
    }
    else
    {
        assert( spawnpoints.size, "<dev string:x213>" );
    }
    
    if ( keepui )
    {
        game_utility::fadetoblackforplayerkeepui( self, 0, 0.5 );
        return;
    }
    
    game_utility::fadetoblackforplayer( self, 0, 0.5 );
}

// Namespace playerlogic
// Params 0
// Checksum 0x8f8d56b3, Offset: 0xc03a
// Size: 0xbf
function callback_playeractive()
{
    self.pers[ "streamSyncComplete" ] = 1;
    self notify( #"player_active" );
    utility::ent_flag_set( "player_active" );
    
    if ( team_utility::isgameplayteam( self.team ) && !self.var_968376be0223dc14 )
    {
        customization = operator::getoperatorcustomization();
        operator::function_44f7d464da13e4f6( self.operatorcustomization.operatorref, self.operatorcustomization.skinref );
        viewmodelname = self getcustomizationviewmodel();
        self setviewmodel( viewmodelname );
    }
    
    game_utility::function_f3b8c430e6514f98( 1 );
    self clearpredictedstreampos();
    
    if ( !isbrgamemode() )
    {
        self clearadditionalstreampos();
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x6daeef3d, Offset: 0xc101
// Size: 0x13
function getmaxnumplayerslogging()
{
    if ( !isbrgamemode() )
    {
        return 30;
    }
    
    return 200;
}

// Namespace playerlogic
// Params 2
// Checksum 0xca0bdec3, Offset: 0xc11c
// Size: 0x77
function tempspawncamera( origin, angles )
{
    cament = spawn( "script_model", origin );
    cament setmodel( "tag_origin" );
    cament.angles = angles;
    player::updatesessionstate( "spectator" );
    self cameralinkto( cament, "tag_origin" );
    utility::waittill_any( "death_or_disconnect", "spawned_player" );
    cament delete();
}

// Namespace playerlogic
// Params 1
// Checksum 0xb13a2f13, Offset: 0xc19b
// Size: 0x29
function function_164bad72d3d50876( text )
{
    logstring( "*****DEBUG***** " + self.name + ":" + text );
}

// Namespace playerlogic
// Params 0
// Checksum 0xaf1c3a49, Offset: 0xc1cc
// Size: 0x1428
function callback_playerconnect()
{
    self.versusdone = 0;
    function_164bad72d3d50876( "connected" );
    self.statusicon = "hud_status_connecting";
    self waittill( #"begin" );
    self.statusicon = "";
    self.loadoutdata = level.loadoutdata;
    self.connecttime = gettime();
    utility::function_d43a7e1cc86b52b0();
    thread callback::callback( #"player_connect_start", {} );
    
    if ( isai( self ) || getdvarint( @"unattended", 0 ) == 1 )
    {
        callback_playeractive();
    }
    
    dospawnspectator = 1;
    
    if ( isdefined( level.onplayerconnectstream ) )
    {
        profilestart();
        dospawnspectator = self thread [[ level.onplayerconnectstream ]]();
        profilestop();
    }
    
    thread function_93974da1b47d69f();
    
    if ( spawncamera::function_7e5668ce5be4b48e() && isdefined( self.sessionteam ) && team_utility::isgameplayteam( self.sessionteam ) )
    {
        spawncamera::function_769148f8af5f7546();
    }
    
    self visionsetfadetoblackforplayer( "bw", 0 );
    normalizedtimepassed = game_utility::gettimepassed() / 1000 + 6;
    params = { #messagelistener:self, #keepui:0, #waitmsg:"connected_continue" };
    
    if ( isdefined( level.var_376a6cf0ec67d7d0 ) )
    {
        params = self [[ level.var_376a6cf0ec67d7d0 ]]( params );
    }
    
    if ( game[ "roundsPlayed" ] > 0 && isdefined( level.var_7cb9fe30089f39e0 ) )
    {
        params = self [[ level.var_7cb9fe30089f39e0 ]]( params );
    }
    
    if ( !isdefined( self.pers[ "streamSyncComplete" ] ) && shouldshowwidemapshot( normalizedtimepassed ) )
    {
        var_9ebd5d8856246063 = function_1c192fb84f87316d();
        streamhint::playerstreamhintlocation( var_9ebd5d8856246063[ 0 ].origin );
        params.waitmsg = "player_active";
    }
    
    if ( !level.gametypebundle.var_17c42b34bb63e935 )
    {
        thread setuipregamefadeup( params.waitmsg, params.messagelistener, params.keepui );
    }
    
    level.players_waiting_for_callback[ level.players_waiting_for_callback.size ] = self;
    self waittill( #"connected_continue" );
    self.connected = 1;
    
    if ( !isdefined( level.uniqueplayersconnected ) )
    {
        level.uniqueplayersconnected = 1;
    }
    else
    {
        level.uniqueplayersconnected++;
    }
    
    self setclientomnvar( "ui_scoreboard_freeze", 0 );
    
    if ( self ishost() )
    {
        level.player = self;
    }
    
    /#
        function_9d76ec8c8a33a47c();
    #/
    
    self.usingonlinedataoffline = self isusingonlinedataoffline();
    initclientdvars();
    initplayerstats();
    thread function_49df7b3b8b7a279f();
    accolades::applyaccoladestructtoplayerpers();
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        level waittill( #"eternity" );
    }
    
    self.guid = player::getuniqueid();
    firstconnect = 0;
    isuibot = manager::isuibot();
    
    if ( !isdefined( self.pers[ "clientid" ] ) )
    {
        firstconnect = 1;
        self.pers[ "clientid" ] = game[ "clientid" ];
        
        if ( !isuibot )
        {
            game[ "clientid" ]++;
            maxplayers = getmaxnumplayerslogging();
            
            if ( game[ "clientid" ] >= maxplayers )
            {
                game[ "clientid" ] = maxplayers - 1;
                self.pers[ "clientid" ] = maxplayers - 1;
            }
            
            setomnvar( "ui_infofeed_connection_player", self getentitynumber() );
            setomnvar( "ui_infofeed_connection_status", 1 );
            setomnvar( "ui_infofeed_connection_notify", gettime() );
        }
        
        self.pers[ "matchdataWeaponStats" ] = [];
        self.pers[ "matchdataScoreEventCounts" ] = [];
        self.pers[ "xpAtLastDeath" ] = 0;
        self.pers[ "scoreAtLastDeath" ] = 0;
        self.pers[ "weaponStats" ] = [];
        
        if ( isbrgamemode() )
        {
            var_a0a7729a6a2969e9 = getdvarint( @"hash_ed901443dea302d4", 0 );
            
            if ( var_a0a7729a6a2969e9 > 0 )
            {
                thread function_1ce1d94092b605f4( var_a0a7729a6a2969e9 );
                playerachievements::getstate( self, var_a0a7729a6a2969e9 );
            }
        }
    }
    
    codcasterclientmatchdata::function_d0c3d53ea5c5f1b2();
    
    /#
        if ( !isuibot )
        {
            println( "<dev string:x3b3>" + self.name + "<dev string:x3bf>" + self.pers[ "<dev string:x3dc>" ] );
        }
    #/
    
    if ( level.flashpointactive )
    {
        thread flashpoint::flashpoint_trackplayerevents( self );
    }
    
    if ( firstconnect )
    {
        persistence::statsetchildbuffered( "round", "timePlayed", 0, 1 );
        self setplayerdata( "common", "round", "totalXp", 0 );
        game_utility::startkeyearning();
        
        if ( !isdefined( game[ "uniquePlayerCount" ] ) )
        {
            game[ "uniquePlayerCount" ] = 1;
        }
        else
        {
            game[ "uniquePlayerCount" ]++;
        }
        
        thread callback::callback( #"player_first_connect", {} );
    }
    
    self.clientid = self.pers[ "clientid" ];
    self.pers[ "teamKillPunish" ] = 0;
    logprint( "J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n" );
    
    if ( analyticsstreamerislogfilestreamingenabled() )
    {
        analyticsstreamerlogfilewritetobuffer( "J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n" );
    }
    
    self logstatmatchguid();
    
    if ( getdvarint( @"online_matchdata_enabled" ) != 0 )
    {
        if ( firstconnect && !isuibot )
        {
            playercount = getmatchdata( "commonMatchData", "player_count" );
            playercount++;
            setmatchdata( "commonMatchData", "player_count", playercount );
        }
        
        if ( isbot( self ) || istestclient( self ) || isai( self ) )
        {
            connectedbot = 1;
        }
        else
        {
            connectedbot = 0;
        }
        
        if ( game_utility_mp::matchmakinggame() && !game_utility_mp::denysystemicteamchoice() && !connectedbot )
        {
            /#
                println( "<dev string:x3e5>" + gettime() );
                println( "<dev string:x3f9>" + getdvarint( @"hash_ff213c5a6a5e05e4", 0 ) );
                println( "<dev string:x40f>" + istrue( level.multiteambased ) );
                println( "<dev string:x426>" + istrue( level.teambased ) );
                println( "<dev string:x438>" + self.sessionteam );
            #/
            
            assert( getdvarint( @"hash_ff213c5a6a5e05e4", 0 ) == 1 || level.multiteambased || level.teambased && ( team_utility::isgameplayteam( self.sessionteam ) || isdevmap() ) || !level.teambased && self.sessionteam == "<dev string:x134>" || level.gametypebundle.var_f5242bb1aa8222f8 && self.sessionteam == "<dev string:x134>" );
        }
    }
    
    if ( firstconnect && !isuibot )
    {
        telemetry_utils::function_af2d366f9522f76f( "callback_on_player_first_connect", self );
        
        if ( function_a114ccb7faef09e1( self ) )
        {
            self.pers[ "streaming" ] = 1;
        }
    }
    
    telemetry_utils::function_af2d366f9522f76f( "callback_on_player_connect", self );
    
    if ( level.uniqueplayersconnected <= getmaxnumplayerslogging() )
    {
        if ( firstconnect && !isuibot && isdefined( level.matchrecording_logeventplayername ) )
        {
            [[ level.matchrecording_logeventplayername ]]( self.clientid, self.team, self.name );
        }
    }
    
    if ( firstconnect )
    {
        rejoin_utility::function_15fb2aded9cc3a03();
    }
    
    if ( !level.teambased )
    {
        game[ "roundsWon" ][ self.guid ] = 0;
    }
    
    if ( !isdefined( self.pers[ "cur_kill_streak" ] ) )
    {
        self.pers[ "cur_kill_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "cur_death_streak" ] ) )
    {
        self.pers[ "cur_death_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "killstreaks_earned" ] ) )
    {
        self.pers[ "killstreaks_earned" ] = 0;
    }
    
    if ( level.onlinestatsenabled )
    {
        self.bestlifetimekillstreak = playerstats_interface::getplayerstat( "bestStats", "killStreak" );
    }
    
    self.lastgrenadesuicidetime = -1;
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.wasaliveatmatchstart = 0;
    self.movespeedscaler = 1;
    
    if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    self.objectivescaler = 1;
    self.killcountthislife = 0;
    resetuidvarsonconnect();
    self.lifeid = 0;
    
    if ( isdefined( self.pers[ "deaths" ] ) )
    {
        self.lifeid = self.pers[ "deaths" ];
    }
    
    waittillframeend();
    
    /#
        foreach ( player in level.players )
        {
            assert( player != self );
        }
    #/
    
    level.players[ level.players.size ] = self;
    level.playersbyentitynumber[ self getentitynumber() ] = self;
    game_utility_common::addtoparticipantsarray();
    game_utility_common::addtocharactersarray();
    player_utility::addtodismembermentlist();
    
    if ( game_utility_mp::getgamestate( self ) == "postgame" )
    {
        self.connectedpostgame = 1;
        self setclientdvars( @"cg_drawspectatormessages", 0 );
        self visionsetfadetoblackforplayer( "", 0.25 );
        var_ec3555220d1eb3bc = getdvarint( @"hash_1460bb86622c3fba", 1 );
        
        if ( firstconnect && var_ec3555220d1eb3bc == 1 )
        {
            menus::bypassclasschoice();
        }
        
        spawnintermission();
        
        if ( firstconnect && var_ec3555220d1eb3bc == 2 )
        {
            menus::bypassclasschoice();
        }
        
        self.pers[ #"hash_8434265d61ebdad3" ] = 1;
        return;
    }
    
    if ( self.pers[ #"hash_8434265d61ebdad3" ] )
    {
        firstconnect = 1;
        self.pers[ #"hash_8434265d61ebdad3" ] = undefined;
    }
    
    if ( firstconnect && !isuibot && ( game_utility::gettimepassed() >= 60000 || game[ "roundsPlayed" ] > 0 ) )
    {
        self.joinedinprogress = 1;
    }
    
    /#
        if ( getdvarint( @"hash_a91f736779a57bef" ) )
        {
            self.pers[ "<dev string:x44b>" ] = "<dev string:x451>";
            self.class = "<dev string:x451>";
            
            if ( self.sessionteam != "<dev string:x452>" && self.sessionteam != "<dev string:x45c>" )
            {
                self.pers[ "<dev string:x466>" ] = self.sessionteam;
            }
            
            self.team = "<dev string:x46b>";
        }
    #/
    
    if ( isai( self ) )
    {
        thread bots::bot_think();
    }
    
    level endon( #"game_ended" );
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        thread hostmigration::hostmigrationtimerthink();
    }
    
    if ( isdefined( level.onplayerconnectaudioinit ) )
    {
        [[ level.onplayerconnectaudioinit ]]();
    }
    
    if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
    {
        if ( prestige_challenge_utility::function_ba46581a84b1edac() )
        {
            self.loadoutdata = prestige_challenge_utility::function_1f8e46a325f962ce();
        }
    }
    
    thread vehicle_interact::function_f3db94c7cb6b6461( self );
    thread battle_tracks::function_4d496ad4a720fdd5( self );
    thread vehicle_interact::function_bba2522f3d5de6e9( self );
    meatshield::meatshield_initplayer();
    thread perkfunctions::markedentities_think();
    
    if ( firstconnect )
    {
        function_164bad72d3d50876( "first connect" );
        normalizedtimepassed = game_utility::gettimepassed() / 1000 + 6;
        
        if ( shouldshowwidemapshot( normalizedtimepassed ) )
        {
            streamhint::playerwaittillstreamhintcomplete();
            spawnspectatormapcam();
            self lerpfovbypreset( "default" );
            self setclientomnvar( "ui_mapshot_camera", 0 );
            initclientdvarssplitscreenspecific();
            self.pers[ "team" ] = "";
            self.team = "free";
        }
        else
        {
            self visionsetfadetoblackforplayer( "", 0.5 );
        }
        
        connect_validateplayerteam();
        
        if ( !isuibot && isplayer( self ) && isbrgamemode() && isdefined( self.clientid ) )
        {
            dlog_recordevent( "dlog_event_br_player_connect", [ "player_id", self.clientid, "player_name", self.name, "connect_time", int( gettime() / 1000 ) ] );
        }
        
        if ( self iscodcaster() )
        {
            thread menus::function_c01531e8bc7f1011();
        }
        else if ( ( isintournament() || game_utility_mp::privatematch() ) && ( self.sessionteam == "spectator" || self.sessionteam == "codcaster" ) )
        {
            self.pers[ "team" ] = self.sessionteam;
            self.team = self.sessionteam;
            thread spawnspectator();
        }
        else if ( ( game_utility_mp::matchmakinggame() || game_utility_mp::lobbyteamselectenabled() ) && self.sessionteam != "none" )
        {
            if ( dospawnspectator )
            {
                thread spawnspectator();
            }
            
            gametype = game_utility::getgametype();
            
            if ( ( gametype == "dmz" || gametype == "plunder" || gametype == "risk" ) && getdvarint( @"scr_br_manual_team_assignment", 0 ) == 1 )
            {
                thread teams::persistantgametypeteamassign();
            }
            else
            {
                thread menus::setteam( self.sessionteam, firstconnect );
            }
            
            if ( !flags::gameflag( "infil_will_run" ) && !flags::gameflag( "loadout_will_run" ) && getdvarint( @"hash_7958073a99a0d67e", 1 ) == 1 && game_utility::getgametype() == "gwtdm" )
            {
                thread spawncamera::startspawncamera();
            }
            else if ( ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" ) && level.var_693302e6ea51684f )
            {
                if ( isdefined( level.spawnselectionlocations ) && isdefined( level.var_76c4dc73f6b30344[ self.team ] ) )
                {
                    streampos = level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ self.team ] ][ self.team ].origin;
                    thread streamhint::playerstreamhintlocation( streampos, 0, undefined, undefined, -1 );
                }
            }
            
            if ( game_utility_mp::allowclasschoice() || game_utility_mp::showfakeloadout() && !isai( self ) )
            {
                if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && isbrgamemode() && game_utility::getgametype() != "dmz" && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "sandbox" )
                {
                    classchoicefunc = isdefined( level.allowclasschoicefunc ) && self [[ level.allowclasschoicefunc ]]();
                    script::demoforcesre( "Callback_PlayerConnect() elseif MMG " + self.name + " ui_open_menu_from_script = 2, allowClassChoiceFunc = " + classchoicefunc );
                }
                
                if ( !self.var_c7ad15df404c5ded && getdvarint( @"hash_89556297eaab6b6a", 0 ) == 0 )
                {
                    self setclientomnvar( "ui_open_menu_from_script", 2 );
                }
            }
            
            if ( !game_utility_mp::runleanthreadmode() && game_utility_mp::matchmakinggame() && !getdvarint( @"hash_9b383028dfd6542d", 0 ) )
            {
                thread kickifdontspawn();
            }
            
            clearpinnedobjectives();
            return;
        }
        else
        {
            /#
                if ( getdvarint( @"hash_c90bde85e15978ef", 0 ) == 1 && !game[ "<dev string:x470>" ] && !game_utility_mp::matchmakinggame() && !game_utility_mp::denysystemicteamchoice() && game_utility_mp::doesmodesupportplayerteamchoice() )
                {
                    menus::menuspectator();
                    menus::beginteamchoice();
                    function_164bad72d3d50876( "<dev string:x452>" );
                    return;
                }
            #/
            
            if ( dospawnspectator )
            {
                thread spawnspectator();
            }
            
            menus::autoassign( firstconnect );
            
            if ( !flags::gameflag( "infil_will_run" ) && getdvarint( @"hash_7958073a99a0d67e", 1 ) == 1 && game_utility::getgametype() == "gwtdm" )
            {
                thread spawncamera::startspawncamera();
            }
            else if ( ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" ) && level.var_693302e6ea51684f )
            {
                if ( isdefined( level.spawnselectionlocations ) && isdefined( level.var_76c4dc73f6b30344[ self.team ] ) )
                {
                    streampos = level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ self.team ] ][ self.team ].origin;
                    thread streamhint::playerstreamhintlocation( streampos, 0, undefined, undefined, -1 );
                }
            }
            
            if ( game_utility_mp::allowclasschoice() || game_utility_mp::showfakeloadout() && !isai( self ) )
            {
                if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && isbrgamemode() && game_utility::getgametype() != "dmz" && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "sandbox" )
                {
                    classchoicefunc = isdefined( level.allowclasschoicefunc ) && self [[ level.allowclasschoicefunc ]]();
                    script::demoforcesre( "Callback_PlayerConnect() else " + self.name + " ui_open_menu_from_script = 2, allowClassChoiceFunc = " + classchoicefunc );
                }
                
                if ( !self.var_c7ad15df404c5ded && getdvarint( @"hash_89556297eaab6b6a", 0 ) == 0 )
                {
                    self setclientomnvar( "ui_open_menu_from_script", 2 );
                }
            }
            
            if ( !game_utility_mp::runleanthreadmode() && game_utility_mp::matchmakinggame() )
            {
                thread kickifdontspawn();
            }
            
            clearpinnedobjectives();
            return;
        }
    }
    else
    {
        function_164bad72d3d50876( "subsequent connect" );
        self visionsetfadetoblackforplayer( "", 0.5 );
        connect_validateplayerteam();
        playerteam = self.pers[ "team" ];
        
        if ( level.teambased && game_utility_mp::matchmakinggame() && !isbot( self ) && !istestclient( self ) && !self iscodcaster() && getdvarint( @"team_consistency_fix" ) )
        {
            playerteam = self.sessionteam;
        }
        
        if ( isdefined( level.forceteamassignmentoverride ) )
        {
            params = { #firstconnect:firstconnect, #selectedteam:playerteam };
            playerteam = self [[ level.forceteamassignmentoverride ]]( params );
        }
        
        menus::addtoteam( playerteam, 1 );
        thread squads::setsquad( playerteam );
        
        if ( self iscodcaster() )
        {
            thread spawnspectator();
            clearpinnedobjectives();
            return;
        }
        
        if ( class::isvalidclass( self.pers[ "class" ] ) && playerteam != "spectator" )
        {
            function_164bad72d3d50876( "has class and is spawning" );
            thread spawnclient();
            clearpinnedobjectives();
            return;
        }
        
        if ( class::isvalidclass( self.pers[ "class" ] ) )
        {
            function_164bad72d3d50876( "has class and NOT is spawning" );
        }
        else
        {
            function_164bad72d3d50876( "NO class and NOT is spawning" );
        }
        
        if ( playerteam == "spectator" )
        {
            function_164bad72d3d50876( "playerTeam spectator and NOT is spawning" );
        }
        else
        {
            function_164bad72d3d50876( "playerTeam not spectator and NOT is spawning" );
        }
        
        thread spawnspectator();
        
        if ( self.pers[ "team" ] == "spectator" )
        {
            if ( game_utility_mp::doesmodesupportplayerteamchoice() && !self.pers[ "playerChoseSpectatorTeam" ] )
            {
                menus::beginteamchoice();
            }
        }
        else
        {
            menus::beginclasschoice();
        }
    }
    
    clearpinnedobjectives();
}

// Namespace playerlogic
// Params 0
// Checksum 0x4cdd2ef, Offset: 0xd5fc
// Size: 0x93
function function_93974da1b47d69f()
{
    projectname = getprojectname();
    
    if ( projectname == "JUP" )
    {
        if ( isdefined( self ) )
        {
            self setsoundsubmix( "jup_global_ingame", 0.05 );
            
            if ( game_utility::getgametype() != "ob" )
            {
                self setsoundsubmix( "jup_global_mp", 0.05 );
                
                if ( level.snowballfight )
                {
                    self setsoundsubmix( "jup_mp_snowball", 0.05 );
                }
            }
            
            if ( !isdefined( game_utility::getmapname() ) || game_utility::getmapname() == "mp_jup_bigmap" || game_utility::islargemap() )
            {
                return;
            }
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x985e926d, Offset: 0xd697
// Size: 0xb1
function callback_playermigrated()
{
    println( "<dev string:x47e>" + self.name + "<dev string:x486>" + gettime() );
    
    if ( isdefined( self.connected ) && self.connected )
    {
        game_utility_mp::updateobjectivetext();
    }
    
    if ( self ishost() )
    {
        initclientdvarssplitscreenspecific();
    }
    
    humanplayercount = function_6983bfc77f3edf01();
    
    if ( !isbot( self ) && !istestclient( self ) )
    {
        level.hostmigrationreturnedplayercount++;
        
        if ( level.hostmigrationreturnedplayercount >= humanplayercount * 2 / 3 )
        {
            println( "<dev string:x4a3>" );
            level notify( #"hostmigration_enoughplayers" );
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xba4b3456, Offset: 0xd750
// Size: 0xa2
function function_6983bfc77f3edf01()
{
    humanplayercount = 0;
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && !istestclient( player ) && !player isplayerheadless() )
        {
            humanplayercount++;
        }
    }
    
    return humanplayercount;
}

// Namespace playerlogic
// Params 0
// Checksum 0xe6ed4f04, Offset: 0xd7fb
// Size: 0x42
function callback_playerconnectrejoin()
{
    println( "<dev string:x4d0>" + self.guid + "<dev string:x4ff>" + self getentitynumber() + "<dev string:x4ff>" + self.name + "<dev string:x501>" );
    thread rejoin_utility::function_ac16d309f31e42a();
}

// Namespace playerlogic
// Params 1
// Checksum 0xa8568195, Offset: 0xd845
// Size: 0x78
function function_eb57164fee20f297( reason )
{
    if ( !isdefined( self.connected ) )
    {
        return;
    }
    
    println( "<dev string:x503>" + self.guid + "<dev string:x4ff>" + self getentitynumber() + "<dev string:x4ff>" + self.name + "<dev string:x4ff>" + reason + "<dev string:x501>" );
    rejoin_utility::rejoin_ondisconnect( reason, 1 );
    disconnect_event_aggregator::function_589bed54937d9441( self );
    game_utility::function_f3b8c430e6514f98( 0 );
}

// Namespace playerlogic
// Params 2
// Checksum 0x15718a16, Offset: 0xd8c5
// Size: 0xc2
function function_b69d00f730747014( achievementid, progressdata )
{
    rejoin_utility::function_ad8206146833a442( achievementid, progressdata );
    common::function_34d520dd8ca5ec48( achievementid, progressdata );
    personal_bests::function_d706af903e23c561( achievementid, progressdata );
    player_progression_achievements::function_f9c086937d2a8eb2( achievementid, progressdata );
    utility::callsharedfunc( #"hash_3ac9ab20c49792f2", #"hash_ccd8bef4e302e3ce", achievementid, progressdata );
    utility::callsharedfunc( #"biometricscan", #"hash_86e51a6d5eee9268", achievementid, progressdata );
    utility::callsharedfunc( #"sierra_weapon_case", #"hash_8f8d14a0a9d71e36", achievementid, progressdata );
    callback::callback( #"hash_22fdd0c3eb081084", { #progressdata:progressdata, #achievementid:achievementid, #player:self } );
}

// Namespace playerlogic
// Params 1
// Checksum 0x68377aa6, Offset: 0xd98f
// Size: 0x87
function function_d748b5fff3953d0c( params )
{
    switch ( params.messagetype ?? -1 )
    {
        case 1:
            callback::callback( #"hash_66c054d5a487b8bf", params );
            break;
        case 3:
            callback::callback( #"player_challenge_complete", params );
            break;
        case 4:
            callback::callback( #"hash_8bf7ff85041541f4", params );
            break;
    }
}

// Namespace playerlogic
// Params 2
// Checksum 0x2b54056f, Offset: 0xda1e
// Size: 0xda
function addlevelstoexperience( experience, levels )
{
    rank = progression_utility::getrankforxp( experience );
    minxp = progression_utility::getrankinfominxp( rank );
    xpamt = progression_utility::getrankinfoxpamt( rank );
    rank += ( experience - minxp ) / xpamt;
    rank += levels;
    
    if ( rank < 0 )
    {
        rank = 0;
        fractionalpart = 0;
    }
    else if ( rank >= level.maxrank + 1 )
    {
        rank = level.maxrank;
        fractionalpart = 1;
    }
    else
    {
        fractionalpart = rank - floor( rank );
        rank = int( floor( rank ) );
    }
    
    minxp = progression_utility::getrankinfominxp( rank );
    xpamt = progression_utility::getrankinfoxpamt( rank );
    return int( fractionalpart * xpamt ) + minxp;
}

// Namespace playerlogic
// Params 0
// Checksum 0xb2a6983c, Offset: 0xdb01
// Size: 0xac
function forcespawn()
{
    self endon( #"death_or_disconnect" );
    self endon( #"spawned" );
    wait 60;
    
    if ( self.hasspawned )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == "spectator" || self.pers[ "team" ] == "codcaster" )
    {
        return;
    }
    
    if ( !class::isvalidclass( self.pers[ "class" ] ) )
    {
        self.pers[ "class" ] = "CLASS/CUSTOM1";
        self.class = self.pers[ "class" ];
    }
    
    thread spawnclient();
}

// Namespace playerlogic
// Params 0
// Checksum 0x64bc3619, Offset: 0xdbb5
// Size: 0x164
function kickifdontspawn()
{
    if ( getdvarint( @"debug_stopafkcheck", 0 ) == 1 )
    {
        return;
    }
    
    if ( self.spawnedasspectator && !mayspawn() )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"spawned" );
    self endon( #"attempted_spawn" );
    wait_time = getdvarfloat( @"scr_kick_time", 90 );
    min_time = getdvarfloat( @"scr_kick_mintime", 45 );
    host_wait_time = getdvarfloat( @"hash_ebb6b541d00c0665", 120 );
    starttime = gettime();
    
    if ( self ishost() )
    {
        kickwait( host_wait_time );
    }
    else
    {
        kickwait( wait_time );
    }
    
    timepassed = ( gettime() - starttime ) / 1000;
    
    if ( timepassed < wait_time - 0.1 && timepassed < min_time )
    {
        return;
    }
    
    if ( self.hasspawned )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == "spectator" || self.pers[ "team" ] == "codcaster" )
    {
        return;
    }
    
    if ( self.spawnedasspectator )
    {
        return;
    }
    
    kick( self getentitynumber(), &"EXE/PLAYERKICKED_INACTIVE", 1 );
    level thread [[ level.updategameevents ]]();
}

// Namespace playerlogic
// Params 1
// Checksum 0x3d14c497, Offset: 0xdd21
// Size: 0x21
function kickwait( waittime )
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( waittime );
}

// Namespace playerlogic
// Params 0
// Checksum 0x45c362bf, Offset: 0xdd4a
// Size: 0x60
function monitorvotekick()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.votestokick = 0;
    
    while ( self.votestokick < 2 )
    {
        self waittill( #"hash_6e463fdeee2553a2" );
        self.votestokick++;
    }
    
    kick( self getentitynumber(), &"EXE/PLAYERKICKED_TEAMKILLS" );
}

// Namespace playerlogic
// Params 0
// Checksum 0x274ee099, Offset: 0xddb2
// Size: 0x38
function fakevote()
{
    wait 1;
    self notify( #"hash_6e463fdeee2553a2" );
    wait 3;
    self notify( #"hash_6e463fdeee2553a2" );
    wait 2;
    self notify( #"hash_6e463fdeee2553a2" );
}

// Namespace playerlogic
// Params 0
// Checksum 0x826a0d86, Offset: 0xddf2
// Size: 0x82
function function_9b598f56f6e13afe()
{
    if ( getdvarint( @"hash_62aef0bf73b3a0f", 0 ) == 0 )
    {
        return 2;
    }
    
    idealnexttime = gettime() + 2000;
    
    if ( level.var_9704616513dd2a63 < idealnexttime )
    {
        level.var_9704616513dd2a63 = idealnexttime;
    }
    
    timeout = ( level.var_9704616513dd2a63 - gettime() ) * 0.001;
    level.var_9704616513dd2a63 += level.frameduration;
    return timeout;
}

// Namespace playerlogic
// Params 1
// Checksum 0xe6b1176c, Offset: 0xde7d
// Size: 0x229
function totaldisttracking( spawnorigin )
{
    self notify( #"hash_e64585d812fe89ca" );
    self endon( #"hash_e64585d812fe89ca" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned" );
    self endon( #"hash_bf9e476bbaabf508" );
    self.var_11fdb6c972ee0ba9 = spawnorigin;
    
    if ( !isdefined( level.var_916baba1930e54af ) )
    {
        if ( isbrgamemode() )
        {
            level.var_916baba1930e54af = getdvarint( @"hash_a1f0eac17092b910", 240 );
        }
        else
        {
            level.var_916baba1930e54af = getdvarint( @"hash_35effe41515eb6d1", 120 );
        }
    }
    
    if ( !isdefined( level.var_6f755660e315d1ee ) )
    {
        level.var_6f755660e315d1ee = getdvarfloat( @"hash_dbca7dad12fdb6df", 100 );
    }
    
    if ( !isdefined( level.var_7cde453f4f476997 ) )
    {
        level.var_7cde453f4f476997 = getdvarint( @"hash_25b5baf9db6af062", 3000 );
    }
    
    if ( !isdefined( level.var_9306fa36fee119c8 ) )
    {
        level.var_9306fa36fee119c8 = utility::function_edc4cc03e9e60b3e( @"hash_b4a5f052be8479f8", 300, level.gametypebundle.var_a206b7075a54b924 );
    }
    
    if ( !isdefined( level.var_9704616513dd2a63 ) )
    {
        level.var_9704616513dd2a63 = gettime() + 2000;
    }
    
    if ( !isdefined( level.var_20ae801d59f03ed0 ) )
    {
        level.var_20ae801d59f03ed0 = function_558b081106d8c6e8();
    }
    
    if ( level.leagueplaymatch )
    {
        level.var_9306fa36fee119c8 = 50;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
        self.var_11fdb6c972ee0ba9 = self.origin;
    }
    
    if ( !isdefined( self.pers[ "totalDistTraveled" ] ) )
    {
        self.pers[ "totalDistTraveled" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "totalDistTraveledAFK" ] ) )
    {
        self.pers[ "totalDistTraveledAFK" ] = 0;
    }
    
    childthread function_17ad02ee25a30eed();
    
    while ( true )
    {
        wait function_9b598f56f6e13afe();
        
        if ( level.throttle_dist_tracking )
        {
            throttle::throttle_wait_in_queue( level.throttle_dist_tracking, self );
        }
        
        function_19b427d151411760();
    }
}

// Namespace playerlogic
// Params 0, eflags: 0x4
// Checksum 0xaa3ce538, Offset: 0xe0ae
// Size: 0x58d
function private function_19b427d151411760()
{
    if ( self.ignoreafkcheck || self.var_5875cc527b6de6cd )
    {
        return;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "averageAltitude" ] ) )
        {
            self.leaderboarddata[ "averageAltitude" ] = self.leaderboarddata[ "averageAltitude" ] + self.origin[ 2 ];
        }
        
        if ( isdefined( level.leaderboardfunc[ "averageAltitude" ] ) )
        {
            [[ level.leaderboardfunc[ "averageAltitude" ] ]]( self, self.origin[ 2 ] );
        }
        
        assert( isint( self.origin[ 2 ] ) || isfloat( self.origin[ 2 ] ), "<dev string:x198>" );
        
        if ( isdefined( self.pers[ "averageAltitude" ] ) )
        {
            self.pers[ "averageAltitude" ] = self.pers[ "averageAltitude" ] + self.origin[ 2 ];
        }
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "averageAltitudeCount" ] ) )
        {
            self.leaderboarddata[ "averageAltitudeCount" ] = self.leaderboarddata[ "averageAltitudeCount" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "averageAltitudeCount" ] ) )
        {
            [[ level.leaderboardfunc[ "averageAltitudeCount" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x198>" );
        
        if ( isdefined( self.pers[ "averageAltitudeCount" ] ) )
        {
            self.pers[ "averageAltitudeCount" ] = self.pers[ "averageAltitudeCount" ] + 1;
        }
    }
    
    if ( level.var_20ae801d59f03ed0 && self.pers[ "distTrackingPassedOrResetTime" ] )
    {
        var_f3b3b1290dddec17 = mp_afk::function_a10af3f5e26c28da();
        
        if ( var_f3b3b1290dddec17 - self.pers[ "distTrackingPassedOrResetTime" ] > level.var_916baba1930e54af )
        {
            self.pers[ "distTrackingPassed" ] = 0;
            self.pers[ "totalDistTraveledAFK" ] = 0;
            self.var_c38ca5641e393f49 = undefined;
        }
    }
    
    if ( !isdefined( self.var_11fdb6c972ee0ba9 ) )
    {
        self.var_11fdb6c972ee0ba9 = self.origin;
    }
    
    dist = distance( self.var_11fdb6c972ee0ba9, self.origin );
    
    if ( dist <= level.var_6f755660e315d1ee )
    {
        return;
    }
    
    self.var_11fdb6c972ee0ba9 = self.origin;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "totalDistTraveled" ] ) )
        {
            self.leaderboarddata[ "totalDistTraveled" ] = self.leaderboarddata[ "totalDistTraveled" ] + dist;
        }
        
        if ( isdefined( level.leaderboardfunc[ "totalDistTraveled" ] ) )
        {
            [[ level.leaderboardfunc[ "totalDistTraveled" ] ]]( self, dist );
        }
        
        assert( isint( dist ) || isfloat( dist ), "<dev string:x198>" );
        
        if ( isdefined( self.pers[ "totalDistTraveled" ] ) )
        {
            self.pers[ "totalDistTraveled" ] = self.pers[ "totalDistTraveled" ] + dist;
        }
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "totalDistTraveledAFK" ] ) )
        {
            self.leaderboarddata[ "totalDistTraveledAFK" ] = self.leaderboarddata[ "totalDistTraveledAFK" ] + dist;
        }
        
        if ( isdefined( level.leaderboardfunc[ "totalDistTraveledAFK" ] ) )
        {
            [[ level.leaderboardfunc[ "totalDistTraveledAFK" ] ]]( self, dist );
        }
        
        assert( isint( dist ) || isfloat( dist ), "<dev string:x198>" );
        
        if ( isdefined( self.pers[ "totalDistTraveledAFK" ] ) )
        {
            self.pers[ "totalDistTraveledAFK" ] = self.pers[ "totalDistTraveledAFK" ] + dist;
        }
    }
    
    if ( self.vehicle )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "distanceTraveledInVehicle" ] ) )
            {
                self.leaderboarddata[ "distanceTraveledInVehicle" ] = self.leaderboarddata[ "distanceTraveledInVehicle" ] + dist;
            }
            
            if ( isdefined( level.leaderboardfunc[ "distanceTraveledInVehicle" ] ) )
            {
                [[ level.leaderboardfunc[ "distanceTraveledInVehicle" ] ]]( self, dist );
            }
            
            assert( isint( dist ) || isfloat( dist ), "<dev string:x198>" );
            
            if ( isdefined( self.pers[ "distanceTraveledInVehicle" ] ) )
            {
                self.pers[ "distanceTraveledInVehicle" ] = self.pers[ "distanceTraveledInVehicle" ] + dist;
            }
        }
    }
    
    if ( self.pers[ "totalDistTraveledAFK" ] > level.var_9306fa36fee119c8 )
    {
        playerhasmoved();
        return;
    }
    
    self.var_186c72a9d88370e7 = gettime() + level.var_7cde453f4f476997;
}

// Namespace playerlogic
// Params 0, eflags: 0x4
// Checksum 0x6132773e, Offset: 0xe643
// Size: 0x2b2
function private function_17ad02ee25a30eed()
{
    isdriver = 0;
    
    for ( wasdriver = 0; true ; wasdriver = isdriver )
    {
        message = utility::waittill_any_return( "vehicle_enter", "vehicle_change_seat", "vehicle_exit", "afk_tracking_resume", "death" );
        
        if ( message == "death" )
        {
            function_19b427d151411760();
            continue;
        }
        
        if ( message == "afk_tracking_resume" )
        {
            self.var_11fdb6c972ee0ba9 = self.origin;
            continue;
        }
        
        var_2e0dc2a26ca862c5 = self.lastvehicleseatchangetime;
        
        if ( message == "vehicle_enter" )
        {
            isdriver = vehicle_occupancy::function_3080323254ba6900( self );
            self.lastvehicleseatchangetime = gettime();
        }
        
        if ( message == "vehicle_change_seat" )
        {
            isdriver = vehicle_occupancy::function_3080323254ba6900( self );
            self.lastvehicleseatchangetime = gettime();
        }
        
        if ( wasdriver != isdriver || message == "vehicle_exit" )
        {
            if ( var_2e0dc2a26ca862c5 )
            {
                time = ( gettime() - var_2e0dc2a26ca862c5 ) / 1000;
                
                if ( wasdriver )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "timeSpentAsDriver" ] ) )
                        {
                            self.leaderboarddata[ "timeSpentAsDriver" ] = self.leaderboarddata[ "timeSpentAsDriver" ] + time;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "timeSpentAsDriver" ] ) )
                        {
                            [[ level.leaderboardfunc[ "timeSpentAsDriver" ] ]]( self, time );
                        }
                        
                        assert( isint( time ) || isfloat( time ), "<dev string:x198>" );
                        
                        if ( isdefined( self.pers[ "timeSpentAsDriver" ] ) )
                        {
                            self.pers[ "timeSpentAsDriver" ] = self.pers[ "timeSpentAsDriver" ] + time;
                        }
                    }
                    
                    continue;
                }
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "timeSpentAsPassenger" ] ) )
                    {
                        self.leaderboarddata[ "timeSpentAsPassenger" ] = self.leaderboarddata[ "timeSpentAsPassenger" ] + time;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "timeSpentAsPassenger" ] ) )
                    {
                        [[ level.leaderboardfunc[ "timeSpentAsPassenger" ] ]]( self, time );
                    }
                    
                    assert( isint( time ) || isfloat( time ), "<dev string:x198>" );
                    
                    if ( isdefined( self.pers[ "timeSpentAsPassenger" ] ) )
                    {
                        self.pers[ "timeSpentAsPassenger" ] = self.pers[ "timeSpentAsPassenger" ] + time;
                    }
                }
            }
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xf0836103, Offset: 0xe8fd
// Size: 0x45
function playerhasmoved()
{
    self.pers[ "distTrackingPassed" ] = 1;
    self.pers[ "totalDistTraveledAFK" ] = 0;
    self.pers[ "distTrackingPassedOrResetTime" ] = mp_afk::function_a10af3f5e26c28da();
    self.var_186c72a9d88370e7 = undefined;
}

// Namespace playerlogic
// Params 0
// Checksum 0xcca52320, Offset: 0xe94a
// Size: 0x149
function initleanplayerstats()
{
    if ( !isdefined( self.pers[ "deaths" ] ) )
    {
        if ( !isdefined( self.pers[ "deaths" ] ) )
        {
            self.pers[ "deaths" ] = 0;
        }
        
        persistence::statsetchild( "round", "deaths", 0 );
    }
    
    self.deaths = self.pers[ "deaths" ];
    stats::initleaderboardstat( "deaths" );
    
    if ( !isdefined( self.pers[ "score" ] ) )
    {
        if ( !isdefined( self.pers[ "score" ] ) )
        {
            self.pers[ "score" ] = 0;
        }
        
        persistence::statsetchild( "round", "score", 0 );
    }
    
    self.score = self.pers[ "score" ];
    stats::initleaderboardstat( "score" );
    
    if ( !isdefined( self.pers[ "kills" ] ) )
    {
        if ( !isdefined( self.pers[ "kills" ] ) )
        {
            self.pers[ "kills" ] = 0;
        }
        
        persistence::statsetchild( "round", "kills", 0 );
    }
    
    self.kills = self.pers[ "kills" ];
    stats::initleaderboardstat( "kills" );
}

// Namespace playerlogic
// Params 0
// Checksum 0x1d6206e0, Offset: 0xea9b
// Size: 0x1743
function initplayerstats()
{
    if ( utility::issharedfuncdefined( #"player", #"hash_d89fce013242f931" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"hash_d89fce013242f931" ) ]]();
    }
    
    persistence::initbufferedstats();
    
    if ( !isdefined( self.leaderboarddata ) )
    {
        self.leaderboarddata = [];
    }
    
    initleanplayerstats();
    
    if ( !isdefined( self.pers[ "objectivescore" ] ) )
    {
        if ( !isdefined( self.pers[ "objectivescore" ] ) )
        {
            self.pers[ "objectivescore" ] = 0;
        }
        
        if ( level.gamemodebundle.var_ef398d9e813bb617 )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, "objectivescore", 0 );
            stats::initleaderboardstat( "objectivescore" );
        }
    }
    
    self.objectivescore = self.pers[ "objectivescore" ];
    
    if ( !isdefined( self.pers[ "shortestLife" ] ) )
    {
        self.pers[ "shortestLife" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "longestLife" ] ) )
    {
        self.pers[ "longestLife" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "suicides" ] ) )
    {
        self.pers[ "suicides" ] = 0;
    }
    
    stats::initleaderboardstat( "suicides" );
    
    if ( !isdefined( self.pers[ "headshots" ] ) )
    {
        self.pers[ "headshots" ] = 0;
    }
    
    stats::initleaderboardstat( "headshots" );
    
    if ( !isdefined( self.pers[ "executions" ] ) )
    {
        self.pers[ "executions" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "assists" ] ) )
    {
        if ( !isdefined( self.pers[ "assists" ] ) )
        {
            self.pers[ "assists" ] = 0;
        }
        
        persistence::statsetchild( "round", "assists", 0 );
    }
    
    self.assists = self.pers[ "assists" ];
    stats::initleaderboardstat( "assists" );
    
    if ( !isdefined( self.pers[ "captures" ] ) )
    {
        if ( !isdefined( self.pers[ "captures" ] ) )
        {
            self.pers[ "captures" ] = 0;
        }
        
        persistence::statsetchild( "round", "captures", 0 );
    }
    
    stats::initleaderboardstat( "captures", &challenges::function_a3678ff124a05f01 );
    
    if ( !isdefined( self.pers[ "returns" ] ) )
    {
        if ( !isdefined( self.pers[ "returns" ] ) )
        {
            self.pers[ "returns" ] = 0;
        }
        
        persistence::statsetchild( "round", "returns", 0 );
    }
    
    stats::initleaderboardstat( "returns" );
    
    if ( !isdefined( self.pers[ "defends" ] ) )
    {
        if ( !isdefined( self.pers[ "defends" ] ) )
        {
            self.pers[ "defends" ] = 0;
        }
        
        persistence::statsetchild( "round", "defends", 0 );
    }
    
    stats::initleaderboardstat( "defends" );
    
    if ( !isdefined( self.pers[ "plants" ] ) )
    {
        if ( !isdefined( self.pers[ "plants" ] ) )
        {
            self.pers[ "plants" ] = 0;
        }
        
        persistence::statsetchild( "round", "plants", 0 );
    }
    
    stats::initleaderboardstat( "plants" );
    
    if ( !isdefined( self.pers[ "defuses" ] ) )
    {
        if ( !isdefined( self.pers[ "defuses" ] ) )
        {
            self.pers[ "defuses" ] = 0;
        }
        
        persistence::statsetchild( "round", "defuses", 0 );
    }
    
    stats::initleaderboardstat( "defuses" );
    
    if ( !isdefined( self.pers[ "destructions" ] ) )
    {
        if ( !isdefined( self.pers[ "destructions" ] ) )
        {
            self.pers[ "destructions" ] = 0;
        }
        
        persistence::statsetchild( "round", "destructions", 0 );
    }
    
    stats::initleaderboardstat( "destructions" );
    
    if ( !isdefined( self.pers[ "confirmed" ] ) )
    {
        if ( !isdefined( self.pers[ "confirmed" ] ) )
        {
            self.pers[ "confirmed" ] = 0;
        }
        
        persistence::statsetchild( "round", "confirmed", 0 );
    }
    
    stats::initleaderboardstat( "confirmed", &challenges::function_a692499a9fdb1cd9 );
    
    if ( !isdefined( self.pers[ "denied" ] ) )
    {
        if ( !isdefined( self.pers[ "denied" ] ) )
        {
            self.pers[ "denied" ] = 0;
        }
        
        persistence::statsetchild( "round", "denied", 0 );
    }
    
    stats::initleaderboardstat( "denied" );
    
    if ( !isdefined( self.pers[ "rescues" ] ) )
    {
        if ( !isdefined( self.pers[ "rescues" ] ) )
        {
            self.pers[ "rescues" ] = 0;
        }
        
        persistence::statsetchild( "round", "rescues", 0 );
    }
    
    stats::initleaderboardstat( "rescues" );
    
    if ( !isdefined( self.pers[ "touchdowns" ] ) )
    {
        if ( !isdefined( self.pers[ "touchdowns" ] ) )
        {
            self.pers[ "touchdowns" ] = 0;
        }
        
        persistence::statsetchild( "round", "touchdowns", 0 );
    }
    
    stats::initleaderboardstat( "touchdowns" );
    
    if ( !isdefined( self.pers[ "fieldgoals" ] ) )
    {
        if ( !isdefined( self.pers[ "fieldgoals" ] ) )
        {
            self.pers[ "fieldgoals" ] = 0;
        }
        
        persistence::statsetchild( "round", "fieldgoals", 0 );
    }
    
    stats::initleaderboardstat( "fieldgoals" );
    
    if ( !isdefined( self.pers[ "killChains" ] ) )
    {
        if ( !isdefined( self.pers[ "killChains" ] ) )
        {
            self.pers[ "killChains" ] = 0;
        }
        
        persistence::statsetchild( "round", "killChains", 0 );
    }
    
    stats::initleaderboardstat( "killChains" );
    
    if ( !isdefined( self.pers[ "killsAsSurvivor" ] ) )
    {
        if ( !isdefined( self.pers[ "killsAsSurvivor" ] ) )
        {
            self.pers[ "killsAsSurvivor" ] = 0;
        }
        
        persistence::statsetchild( "round", "killsAsSurvivor", 0 );
    }
    
    stats::initleaderboardstat( "killsAsSurvivor" );
    
    if ( !isdefined( self.pers[ "killsAsInfected" ] ) )
    {
        if ( !isdefined( self.pers[ "killsAsInfected" ] ) )
        {
            self.pers[ "killsAsInfected" ] = 0;
        }
        
        persistence::statsetchild( "round", "killsAsInfected", 0 );
    }
    
    stats::initleaderboardstat( "killsAsInfected" );
    
    if ( !isdefined( self.pers[ "teamkills" ] ) )
    {
        if ( !isdefined( self.pers[ "teamkills" ] ) )
        {
            self.pers[ "teamkills" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "teamkills" );
    
    if ( !isdefined( self.pers[ "teamdamage" ] ) )
    {
        if ( !isdefined( self.pers[ "teamdamage" ] ) )
        {
            self.pers[ "teamdamage" ] = 0;
        }
    }
    
    if ( !isdefined( self.pers[ "extrascore0" ] ) )
    {
        if ( !isdefined( self.pers[ "extrascore0" ] ) )
        {
            self.pers[ "extrascore0" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "extrascore0" );
    
    if ( !isdefined( self.pers[ "extrascore1" ] ) )
    {
        if ( !isdefined( self.pers[ "extrascore1" ] ) )
        {
            self.pers[ "extrascore1" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "extrascore1" );
    
    if ( !isdefined( self.pers[ "extrascore2" ] ) )
    {
        if ( !isdefined( self.pers[ "extrascore2" ] ) )
        {
            self.pers[ "extrascore2" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "extrascore2" );
    
    if ( !isdefined( self.pers[ "extrascore3" ] ) )
    {
        if ( !isdefined( self.pers[ "extrascore3" ] ) )
        {
            self.pers[ "extrascore3" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "extrascore3" );
    
    if ( !isdefined( self.pers[ "extrascore4" ] ) )
    {
        if ( !isdefined( self.pers[ "extrascore4" ] ) )
        {
            self.pers[ "extrascore4" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "extrascore4" );
    
    if ( !isdefined( self.pers[ "extrascore5" ] ) )
    {
        if ( !isdefined( self.pers[ "extrascore5" ] ) )
        {
            self.pers[ "extrascore5" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "extrascore5" );
    
    if ( !isdefined( self.pers[ "stabs" ] ) )
    {
        if ( !isdefined( self.pers[ "stabs" ] ) )
        {
            self.pers[ "stabs" ] = 0;
        }
        
        persistence::statsetchild( "round", "stabs", 0 );
    }
    
    stats::initleaderboardstat( "stabs" );
    
    if ( !isdefined( self.pers[ "setbacks" ] ) )
    {
        if ( !isdefined( self.pers[ "setbacks" ] ) )
        {
            self.pers[ "setbacks" ] = 0;
        }
        
        persistence::statsetchild( "round", "setbacks", 0 );
    }
    
    stats::initleaderboardstat( "setbacks" );
    
    if ( !isdefined( self.pers[ "objTime" ] ) )
    {
        if ( !isdefined( self.pers[ "objTime" ] ) )
        {
            self.pers[ "objTime" ] = 0;
        }
        
        persistence::statsetchild( "round", "objTime", 0 );
    }
    
    stats::initleaderboardstat( "objTime" );
    
    if ( !isdefined( self.pers[ "gamemodeScore" ] ) )
    {
        if ( !isdefined( self.pers[ "gamemodeScore" ] ) )
        {
            self.pers[ "gamemodeScore" ] = 0;
        }
        
        persistence::statsetchild( "round", "gamemodeScore", 0 );
    }
    
    stats::initleaderboardstat( "gamemodeScore" );
    
    if ( !isdefined( self.pers[ "damage" ] ) )
    {
        if ( !isdefined( self.pers[ "damage" ] ) )
        {
            self.pers[ "damage" ] = 0;
        }
        
        persistence::statsetchild( "round", "damage", 0 );
    }
    
    if ( !isdefined( self.pers[ "damageTaken" ] ) )
    {
        if ( !isdefined( self.pers[ "damageTaken" ] ) )
        {
            self.pers[ "damageTaken" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "damage", &challenges::function_cc68cea76d430189 );
    
    if ( !isdefined( self.pers[ "supersEarned" ] ) )
    {
        self.pers[ "supersEarned" ] = 0;
    }
    
    stats::initleaderboardstat( "supersEarned" );
    
    if ( !isdefined( self.pers[ "downs" ] ) )
    {
        if ( !isdefined( self.pers[ "downs" ] ) )
        {
            self.pers[ "downs" ] = 0;
        }
        
        persistence::statsetchild( "round", "downs", 0 );
    }
    
    stats::initleaderboardstat( "downs" );
    
    if ( !isdefined( self.pers[ "contracts" ] ) )
    {
        if ( !isdefined( self.pers[ "contracts" ] ) )
        {
            self.pers[ "contracts" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "contracts" );
    
    if ( !isdefined( self.pers[ "cur_kill_streak" ] ) )
    {
        if ( !isdefined( self.pers[ "cur_kill_streak" ] ) )
        {
            self.pers[ "cur_kill_streak" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "cur_kill_streak" );
    
    if ( !isdefined( self.pers[ "killstreaks_earned" ] ) )
    {
        if ( !isdefined( self.pers[ "killstreaks_earned" ] ) )
        {
            self.pers[ "killstreaks_earned" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "killstreaks_earned" );
    
    if ( !isdefined( self.pers[ "survived_rounds" ] ) )
    {
        if ( !isdefined( self.pers[ "survived_rounds" ] ) )
        {
            self.pers[ "survived_rounds" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "survived_rounds" );
    
    if ( !isdefined( self.pers[ "gold_secure" ] ) )
    {
        if ( !isdefined( self.pers[ "gold_secure" ] ) )
        {
            self.pers[ "gold_secure" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "gold_secure" );
    
    if ( !isdefined( self.pers[ "gold_collected" ] ) )
    {
        if ( !isdefined( self.pers[ "gold_collected" ] ) )
        {
            self.pers[ "gold_collected" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "gold_collected" );
    
    if ( !isdefined( self.pers[ "objective_kills" ] ) )
    {
        if ( !isdefined( self.pers[ "objective_kills" ] ) )
        {
            self.pers[ "objective_kills" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "objective_kills" );
    
    if ( !self.pers[ "cookie_collected" ] )
    {
        if ( !isdefined( self.pers[ "cookie_collected" ] ) )
        {
            self.pers[ "cookie_collected" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "cookie_collected" );
    
    if ( !self.pers[ "cookie_deposited" ] )
    {
        if ( !isdefined( self.pers[ "cookie_deposited" ] ) )
        {
            self.pers[ "cookie_deposited" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "cookie_deposited" );
    
    if ( !self.pers[ "objective_kills" ] )
    {
        if ( !isdefined( self.pers[ "objective_kills" ] ) )
        {
            self.pers[ "objective_kills" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "objective_kills" );
    
    if ( !isdefined( self.pers[ "objectives_completed" ] ) )
    {
        if ( !isdefined( self.pers[ "objectives_completed" ] ) )
        {
            self.pers[ "objectives_completed" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "objectives_completed" );
    
    if ( !isdefined( self.pers[ "top_squad_kills" ] ) )
    {
        if ( !isdefined( self.pers[ "top_squad_kills" ] ) )
        {
            self.pers[ "top_squad_kills" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "top_squad_kills" );
    
    if ( !isdefined( self.pers[ "supplies_retrieved" ] ) )
    {
        if ( !isdefined( self.pers[ "supplies_retrieved" ] ) )
        {
            self.pers[ "supplies_retrieved" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "supplies_retrieved" );
    
    if ( !isdefined( self.pers[ "combo_score" ] ) )
    {
        if ( !isdefined( self.pers[ "combo_score" ] ) )
        {
            self.pers[ "combo_score" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "combo_score" );
    
    if ( !isdefined( self.pers[ "combo_high_score" ] ) )
    {
        if ( !isdefined( self.pers[ "combo_high_score" ] ) )
        {
            self.pers[ "combo_high_score" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "combo_high_score" );
    
    if ( !isdefined( self.pers[ "combo_action_count" ] ) )
    {
        if ( !isdefined( self.pers[ "combo_action_count" ] ) )
        {
            self.pers[ "combo_action_count" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "combo_action_count" );
    
    if ( !isdefined( self.pers[ "combo_heat_time" ] ) )
    {
        if ( !isdefined( self.pers[ "combo_heat_time" ] ) )
        {
            self.pers[ "combo_heat_time" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "combo_heat_time" );
    
    if ( !isdefined( self.pers[ "overcharge_count" ] ) )
    {
        if ( !isdefined( self.pers[ "overcharge_count" ] ) )
        {
            self.pers[ "overcharge_count" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "overcharge_count" );
    
    if ( !isdefined( self.pers[ "sabattack_obj_kill_count" ] ) )
    {
        if ( !isdefined( self.pers[ "sabattack_obj_kill_count" ] ) )
        {
            self.pers[ "sabattack_obj_kill_count" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "sabattack_obj_kill_count" );
    
    if ( !isdefined( self.pers[ "prop_obj_time" ] ) )
    {
        self.pers[ "prop_obj_time" ] = 0;
    }
    
    stats::initleaderboardstat( "prop_obj_time" );
    
    if ( !isdefined( self.pers[ "prop_survived" ] ) )
    {
        self.pers[ "prop_survived" ] = 0;
    }
    
    stats::initleaderboardstat( "prop_survived" );
    
    if ( !isdefined( self.pers[ "prop_decoys_destroyed" ] ) )
    {
        self.pers[ "prop_decoys_destroyed" ] = 0;
    }
    
    stats::initleaderboardstat( "prop_decoys_destroyed" );
    
    if ( !isdefined( self.pers[ "time" ] ) )
    {
        if ( !isdefined( self.pers[ "time" ] ) )
        {
            self.pers[ "time" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "time" );
    
    if ( !isdefined( self.pers[ "escortEnt_kills" ] ) )
    {
        self.pers[ "escortEnt_kills" ] = 0;
    }
    
    stats::initleaderboardstat( "escortEnt_kills" );
    
    if ( !isdefined( self.pers[ "placement" ] ) )
    {
        if ( !isdefined( self.pers[ "placement" ] ) )
        {
            self.pers[ "placement" ] = 0;
        }
    }
    
    stats::initleaderboardstat( "placement" );
    
    if ( !isdefined( self.pers[ "wins" ] ) )
    {
        self.pers[ "wins" ] = 0;
    }
    
    stats::initleaderboardstat( "wins" );
    
    if ( !isdefined( self.pers[ "losses" ] ) )
    {
        self.pers[ "losses" ] = 0;
    }
    
    stats::initleaderboardstat( "losses" );
    
    if ( !isdefined( self.pers[ "topFive" ] ) )
    {
        self.pers[ "topFive" ] = 0;
    }
    
    stats::initleaderboardstat( "topFive" );
    
    if ( !isdefined( self.pers[ "topTen" ] ) )
    {
        self.pers[ "topTen" ] = 0;
    }
    
    stats::initleaderboardstat( "topTen" );
    
    if ( !isdefined( self.pers[ "topTwentyFive" ] ) )
    {
        self.pers[ "topTwentyFive" ] = 0;
    }
    
    stats::initleaderboardstat( "topTwentyFive" );
    
    if ( !isdefined( self.pers[ "gamesPlayed" ] ) )
    {
        self.pers[ "gamesPlayed" ] = 0;
    }
    
    stats::initleaderboardstat( "gamesPlayed" );
    
    if ( !isdefined( self.pers[ "cash" ] ) )
    {
        self.pers[ "cash" ] = 0;
    }
    
    stats::initleaderboardstat( "cash" );
    
    if ( !isdefined( self.pers[ "eliteStarted" ] ) )
    {
        self.pers[ "eliteStarted" ] = 0;
    }
    
    stats::initleaderboardstat( "eliteStarted" );
    
    if ( !isdefined( self.pers[ "eliteCompleted" ] ) )
    {
        self.pers[ "eliteCompleted" ] = 0;
    }
    
    stats::initleaderboardstat( "eliteCompleted" );
    
    if ( !isdefined( self.pers[ "eliteBlocked" ] ) )
    {
        self.pers[ "eliteBlocked" ] = 0;
    }
    
    stats::initleaderboardstat( "eliteBlocked" );
    
    if ( !isdefined( self.pers[ "secondaryVictories" ] ) )
    {
        self.pers[ "secondaryVictories" ] = 0;
    }
    
    stats::initleaderboardstat( "secondaryVictories" );
    
    if ( !isdefined( self.pers[ "weaponCaseExfils" ] ) )
    {
        self.pers[ "weaponCaseExfils" ] = 0;
    }
    
    stats::initleaderboardstat( "weaponCaseExfils" );
    
    if ( !isdefined( self.pers[ "weaponCaseWins" ] ) )
    {
        self.pers[ "weaponCaseWins" ] = 0;
    }
    
    stats::initleaderboardstat( "weaponCaseWins" );
    
    if ( !isdefined( self.pers[ "contribution" ] ) )
    {
        self.pers[ "contribution" ] = 0;
    }
    
    stats::initleaderboardstat( "contribution" );
    
    if ( !isdefined( self.pers[ "kioskRevives" ] ) )
    {
        self.pers[ "kioskRevives" ] = 0;
    }
    
    stats::initleaderboardstat( "kioskRevives" );
    
    if ( !isdefined( self.pers[ "goals" ] ) )
    {
        self.pers[ "goals" ] = 0;
    }
    
    stats::initleaderboardstat( "goals" );
    
    if ( !isdefined( self.pers[ "segmentCaptures" ] ) )
    {
        if ( !isdefined( self.pers[ "segmentCaptures" ] ) )
        {
            self.pers[ "segmentCaptures" ] = 0;
        }
        
        persistence::statsetchild( "round", "segmentCaptures", 0 );
    }
    
    stats::initleaderboardstat( "segmentCaptures" );
    
    if ( !isdefined( self.pers[ "highestMultikill" ] ) )
    {
        self.pers[ "highestMultikill" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "untradedDeaths" ] ) )
    {
        self.pers[ "untradedDeaths" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "tradedKills" ] ) )
    {
        self.pers[ "tradedKills" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "tradedDeaths" ] ) )
    {
        self.pers[ "tradedDeaths" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "wallbangs" ] ) )
    {
        self.pers[ "wallbangs" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "wallbangsdamage" ] ) )
    {
        self.pers[ "wallbangsdamage" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "hvtKills" ] ) )
    {
        self.pers[ "hvtKills" ] = 0;
    }
    
    stats::initleaderboardstat( "hvtKills" );
    
    if ( !isdefined( self.pers[ "zombieDeaths" ] ) )
    {
        self.pers[ "zombieDeaths" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "stolenCarePackages" ] ) )
    {
        self.pers[ "stolenCarePackages" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "reportedStolenCarePackages" ] ) )
    {
        self.pers[ "reportedStolenCarePackages" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "enemiesCrushedByCarePackages" ] ) )
    {
        self.pers[ "enemiesCrushedByCarePackages" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "teamKillPunish" ] ) )
    {
        self.pers[ "teamKillPunish" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "longestStreak" ] ) )
    {
        self.pers[ "longestStreak" ] = 0;
    }
    
    stats::initleaderboardstat( "longestStreak" );
    
    if ( !isdefined( self.pers[ "bonusScore" ] ) )
    {
        self.pers[ "bonusScore" ] = 0;
    }
    
    self.pers[ "lives" ] = game_utility_mp::getgametypenumlives();
    persistence::statsetchild( "round", "killStreak", 0 );
    persistence::statsetchild( "round", "loss", 0 );
    persistence::statsetchild( "round", "win", 0 );
    persistence::statsetchild( "round", "scoreboardType", "none" );
    stats::initleaderboardstat( "killStreak" );
    stats::initleaderboardstat( "loss" );
    stats::initleaderboardstat( "win" );
}

// Namespace playerlogic
// Params 1
// Checksum 0xe7eab39b, Offset: 0x101e6
// Size: 0x83
function addtoteamcount( addlives )
{
    assert( isplayer( self ) );
    assert( isdefined( self.team ) );
    assert( isdefined( self.pers[ "<dev string:x466>" ] ) );
    assert( self.team == self.pers[ "<dev string:x466>" ] );
    thread teams::addplayertoteam( self, self.team, addlives );
    [[ level.updategameevents ]]();
}

// Namespace playerlogic
// Params 0
// Checksum 0x6435a109, Offset: 0x10271
// Size: 0x6b
function removefromteamcount()
{
    assert( isplayer( self ) );
    assert( isdefined( self.team ) );
    assert( isdefined( self.pers[ "<dev string:x466>" ] ) );
    assert( self.team == self.pers[ "<dev string:x466>" ] );
    teams::removeplayerfromteam( self, self.team );
}

// Namespace playerlogic
// Params 2
// Checksum 0x56c2b6a8, Offset: 0x102e4
// Size: 0x12b
function addtoalivecount( context, var_901b91bb37898aba = 0 )
{
    assert( isplayer( self ) );
    teamadding = self.team;
    
    if ( !( isdefined( self.alreadyaddedtoalivecount ) && self.alreadyaddedtoalivecount ) )
    {
        teams::modifyteamdata( teamadding, "hasSpawned", 1 );
        incrementalivecount( teamadding, undefined, context );
    }
    
    self.alreadyaddedtoalivecount = undefined;
    
    if ( var_901b91bb37898aba )
    {
        return;
    }
    
    alivecounttotal = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        alivecounttotal += teams::getteamdata( entry, "aliveCount" );
    }
    
    if ( alivecounttotal > level.maxplayercount )
    {
        level.maxplayercount = alivecounttotal;
    }
}

// Namespace playerlogic
// Params 3
// Checksum 0xc367db13, Offset: 0x10417
// Size: 0x36
function incrementalivecount( teamadding, var_68e08a7602d95dd9, context )
{
    teams::addtoteamlives( self, teamadding, var_68e08a7602d95dd9, context );
    [[ level.updategameevents ]]();
}

// Namespace playerlogic
// Params 3
// Checksum 0xe7678cca, Offset: 0x10455
// Size: 0x169
function removefromalivecount( disconnected, context, needupdategameevents )
{
    assert( isplayer( self ) );
    lives = self.pers[ "lives" ];
    var_68e08a7602d95dd9 = game_utility_mp::getgametypenumlives() != 0 && lives == 0 && !level.skipplaybodycountsound && !self.skipplaybodycountsound;
    self notify( #"remove_from_alive_count" );
    var_f592219b5a2e310c = self.switching_teams && self.joining_team == self.team ? self.leaving_team : self.team;
    
    if ( isdefined( disconnected ) && game_utility_mp::getbasegametype() != "control" )
    {
        removeallfromlivescount();
        
        if ( self.gulag )
        {
            level.var_bb25c34ae28e413f--;
        }
    }
    else if ( isdefined( self.switching_teams ) )
    {
        if ( !level.ingraceperiod || self.hasdonecombat )
        {
            teams::modifyteamdata( var_f592219b5a2e310c, "hasSpawned", -1 );
            
            if ( lives && game_utility_mp::getbasegametype() != "control" )
            {
                self.pers[ "lives" ]--;
            }
        }
    }
    
    decrementalivecount( var_f592219b5a2e310c, var_68e08a7602d95dd9, context, needupdategameevents );
}

// Namespace playerlogic
// Params 2
// Checksum 0x3df17c75, Offset: 0x105c6
// Size: 0x49
function function_f50f2e6bc47756b7( team, player )
{
    if ( !isarray( level.teamdata[ team ][ "alivePlayers" ] ) )
    {
        return 0;
    }
    
    return arraycontains( level.teamdata[ team ][ "alivePlayers" ], player );
}

// Namespace playerlogic
// Params 4
// Checksum 0xecc277e0, Offset: 0x10618
// Size: 0x4d
function decrementalivecount( var_f592219b5a2e310c, var_68e08a7602d95dd9, context, needupdategameevents = 1 )
{
    teams::removefromteamlives( self, var_f592219b5a2e310c, var_68e08a7602d95dd9, context );
    
    if ( needupdategameevents )
    {
        [[ level.updategameevents ]]();
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xcba47034, Offset: 0x1066d
// Size: 0x33
function addtolivescount()
{
    assert( isplayer( self ) );
    teams::modifyteamdata( self.team, "livesCount", self.pers[ "lives" ] );
}

// Namespace playerlogic
// Params 0
// Checksum 0x51c9737b, Offset: 0x106a8
// Size: 0x44
function removefromlivescount()
{
    assert( isplayer( self ) );
    teams::setteamdata( self.team, "livesCount", int( max( 0, teams::getteamdata( self.team, "livesCount" ) - 1 ) ) );
}

// Namespace playerlogic
// Params 0
// Checksum 0x7232f83e, Offset: 0x106f4
// Size: 0x51
function removeallfromlivescount()
{
    assert( isplayer( self ) );
    teams::setteamdata( self.team, "livesCount", int( max( 0, teams::getteamdata( self.team, "livesCount" ) - self.pers[ "lives" ] ) ) );
}

// Namespace playerlogic
// Params 0
// Checksum 0x86804ba9, Offset: 0x1074d
// Size: 0x64
function resetuiomnvarscommon()
{
    if ( isdefined( level.resetuiomnvargamemode ) )
    {
        [[ level.resetuiomnvargamemode ]]();
    }
    
    self setclientomnvar( "ui_objective_pinned_text_param", 0 );
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_reviver_id", -1 );
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self setclientomnvar( "ui_edge_glow", 0 );
    self setclientomnvar( "ui_life_kill_count", 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0xda59bde7, Offset: 0x107b9
// Size: 0x6c
function resetuidvarsonconnect()
{
    resetuiomnvarscommon();
    self setclientdvar( @"ui_eyes_on_end_milliseconds", 0 );
    hud_message::function_ef4318a0090caa0f( #"hide_match_hint" );
    
    if ( !self.var_b660cc1baffd76e8 )
    {
        self setclientomnvar( "post_game_state", 0 );
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        self setclientomnvar( "ui_match_in_progress", 1 );
        return;
    }
    
    self setclientomnvar( "ui_match_in_progress", 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0x217ebafc, Offset: 0x1082d
// Size: 0x19
function resetuidvarsonspectate()
{
    resetuiomnvarscommon();
    self setclientdvar( @"ui_eyes_on_end_milliseconds", 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0x29d26859, Offset: 0x1084e
// Size: 0x155
function clearpinnedobjectives()
{
    if ( isbot( self ) )
    {
        return;
    }
    
    if ( isdefined( level.objectives ) )
    {
        foreach ( objective in level.objectives )
        {
            if ( isdefined( objective.objidnum ) )
            {
                objidpoolmanager::objective_unpin_player( objective.objidnum, self, objective.showoncompass );
            }
        }
    }
    
    if ( isdefined( level.uncapturableobjectives ) )
    {
        foreach ( objective in level.uncapturableobjectives )
        {
            if ( isdefined( objective.objidnum ) )
            {
                objidpoolmanager::objective_unpin_player( objective.objidnum, self, objective.showoncompass );
            }
        }
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x4b37ae1c, Offset: 0x109ab
// Size: 0xcf
function showgamemodeobjectivetext()
{
    if ( self.hasspawned )
    {
        return;
    }
    
    if ( !showmatchhint() )
    {
        return;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    self endon( #"disconnect" );
    wait 1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "team" ] ) )
    {
        return;
    }
    
    player_team = self.pers[ "team" ];
    hintmessage = game_utility_mp::getobjectivehinttext( player_team );
    
    if ( isdefined( hintmessage ) )
    {
        idx = 0;
        
        if ( game[ "defenders" ] == player_team )
        {
            idx = 1;
        }
        
        self setclientomnvar( "ui_objective_text", idx );
        wait 6;
        self setclientomnvar( "ui_objective_text", -1 );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x2dbe3cbe, Offset: 0x10a82
// Size: 0x2e
function function_7376357a50f8c839()
{
    self notify( #"hash_b390e807b97e629a" );
    self endon( #"hash_b390e807b97e629a" );
    flags::gameflagwait( "prematch_done" );
    damage_effects::onexitdeathsdoor( 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0xde589caa, Offset: 0x10ab8
// Size: 0x3b
function function_ccdd146f3e6e3c82()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_fade_done" );
    
    if ( outofbounds::isoob( self ) )
    {
        self.var_65c6b1940f2e9d1f = 1;
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0xf569b853, Offset: 0x10afb
// Size: 0x58, Type: bool
function showmatchhint()
{
    gametype = game_utility::getgametype();
    
    switch ( gametype )
    {
        case #"hash_5ff8e011d5b9d1c8":
            if ( isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] > 0 )
            {
                return false;
            }
            
            break;
        default:
            break;
    }
    
    return true;
}

// Namespace playerlogic
// Params 0
// Checksum 0xc65d3950, Offset: 0x10b5c
// Size: 0x61
function trydisableminimap()
{
    if ( isbrgamemode() && game[ "inLiveLobby" ] )
    {
        return;
    }
    
    if ( player::alwaysshowminimap() )
    {
        return;
    }
    
    if ( !self.showuavminimaponspawn && !isdefined( self.perks[ "specialty_always_minimap" ] ) )
    {
        player::hideminimap( 1 );
    }
    
    self.showuavminimaponspawn = 0;
    
    /#
        level.devminimapvisible = 0;
    #/
}

// Namespace playerlogic
// Params 2
// Checksum 0xaec9321d, Offset: 0x10bc5
// Size: 0x1e4
function managerespawnfade( fadedownduration, fadeupduration )
{
    self endon( #"disconnect" );
    
    if ( self.respawnfade )
    {
        return;
    }
    
    self.respawnfade = 1;
    self notify( #"fadedown_start" );
    
    if ( !isdefined( fadedownduration ) )
    {
        fadedownduration = 0;
    }
    
    fadeduration = fadedownduration;
    
    if ( fadeduration > 0 )
    {
        var_bbb8bb827b4d548b = 0;
        framecount = fadeduration / level.framedurationseconds;
        var_fb561b1f5305f2a0 = 1 / framecount;
        currentframe = 0;
        
        while ( currentframe < framecount )
        {
            currentframe++;
            var_bbb8bb827b4d548b += var_fb561b1f5305f2a0;
            var_bbb8bb827b4d548b = clamp( var_bbb8bb827b4d548b, 0, 1 );
            self setclientomnvar( "ui_world_fade", var_bbb8bb827b4d548b );
            waitframe();
        }
    }
    else
    {
        self setclientomnvar( "ui_world_fade", 1 );
    }
    
    self notify( #"fadedown_complete" );
    restorehud = 0;
    
    if ( !player::isreallyalive( self ) )
    {
        self waittill( #"spawned_player" );
        restorehud = 1;
    }
    
    flags::gameflagwait( "prematch_done" );
    
    if ( restorehud )
    {
        utility::hidehudenable();
    }
    
    wait 2;
    self notify( #"fadeup_start" );
    
    if ( !isdefined( fadeupduration ) )
    {
        fadeupduration = 0;
    }
    
    fadeduration = fadeupduration;
    
    if ( fadeduration > 0 )
    {
        var_bbb8bb827b4d548b = 1;
        framecount = fadeduration / level.framedurationseconds;
        var_fb561b1f5305f2a0 = 1 / framecount;
        currentframe = 0;
        
        while ( currentframe < framecount )
        {
            currentframe++;
            var_bbb8bb827b4d548b -= var_fb561b1f5305f2a0;
            var_bbb8bb827b4d548b = clamp( var_bbb8bb827b4d548b, 0, 1 );
            self setclientomnvar( "ui_world_fade", var_bbb8bb827b4d548b );
            waitframe();
        }
    }
    else
    {
        self setclientomnvar( "ui_world_fade", 0 );
    }
    
    if ( restorehud )
    {
        utility::hidehuddisable();
    }
    
    self.respawnfade = undefined;
    self notify( #"fadeup_complete" );
}

// Namespace playerlogic
// Params 0
// Checksum 0x76ffc6fb, Offset: 0x10db1
// Size: 0x1d
function function_558b081106d8c6e8()
{
    if ( isdefined( level.var_d0594eb464c4d6ee ) )
    {
        return [[ level.var_d0594eb464c4d6ee ]]();
    }
    
    return 1;
}

// Namespace playerlogic
// Params 1, eflags: 0x4
// Checksum 0xdd2a59fe, Offset: 0x10dd7
// Size: 0xeb
function private function_1ce1d94092b605f4( var_a0a7729a6a2969e9 )
{
    self endon( #"disconnect" );
    self waittillmatch( #"challengeprogress", var_a0a7729a6a2969e9 );
    challenges::initgameflags( var_a0a7729a6a2969e9 );
    
    if ( challenges::function_7e5184c2a3117516( #"game_flags_user", #"has_premium" ) )
    {
        println( "<dev string:x538>" );
    }
    
    if ( challenges::function_7e5184c2a3117516( #"game_flags_user", #"has_battlepass" ) )
    {
        println( "<dev string:x55f>" );
    }
    
    if ( challenges::function_7e5184c2a3117516( #"game_flags_user", #"has_blackcell" ) )
    {
        println( "<dev string:x58c>" );
    }
    
    if ( challenges::function_7e5184c2a3117516( #"hash_4a7f024e87253788", #"secondary_victory_carryover" ) )
    {
        println( "<dev string:x5b8>" );
        challenges::function_79cc4302a65cff47( #"hash_4a7f024e87253788", #"secondary_victory_carryover" );
    }
}

// Namespace playerlogic
// Params 0
// Checksum 0x2b4ca1ef, Offset: 0x10eca
// Size: 0xff
function function_85ec963075a77a92()
{
    if ( level.gameended )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self endon( #"hash_4a0590e04aac48c9" );
    level endon( #"game_ended" );
    self.currentspectatetarget = undefined;
    self.var_993ed3af20851563 = undefined;
    self.var_78eccdb92a3a3896 = undefined;
    
    /#
        thread debugcommands();
    #/
    
    while ( true )
    {
        self waittill( #"spectating_cycle_start", playertospectate );
        
        if ( self.spectatekillcam || self.var_6db12e4862ea2427 )
        {
            level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
            continue;
        }
        
        if ( isdefined( playertospectate ) )
        {
            if ( !isdefined( self.var_78eccdb92a3a3896 ) )
            {
                function_b399929b69e34ba0( 1 );
                thread removespectateblackonspawn();
                thread function_deac50631b68263d();
            }
            
            if ( !player::isreallyalive( playertospectate ) )
            {
                function_b399929b69e34ba0( 1 );
                continue;
            }
            
            thread removespectateblackonspectatecycle( playertospectate );
        }
    }
}

// Namespace playerlogic
// Params 1
// Checksum 0xec793ffb, Offset: 0x10fd1
// Size: 0xb2
function removespectateblackonspectatecycle( playertospectate )
{
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self endon( #"hash_4a0590e04aac48c9" );
    level endon( #"game_ended" );
    playertospectate endon( #"death_or_disconnect" );
    self notify( #"removespectateblackonspectatecycle" );
    self endon( #"removespectateblackonspectatecycle" );
    self.currentspectatetarget = playertospectate;
    self waittill( #"spectating_cycle" );
    
    if ( !isdefined( self.var_993ed3af20851563 ) )
    {
        level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0.25 );
    }
    
    self.currentspectatetarget = undefined;
    self.var_993ed3af20851563 = playertospectate;
    thread watchforcurrentspectateclientdeathordisconnect();
}

// Namespace playerlogic
// Params 0
// Checksum 0xeaf49244, Offset: 0x1108b
// Size: 0x93
function watchforcurrentspectateclientdeathordisconnect()
{
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self endon( #"hash_4a0590e04aac48c9" );
    level endon( #"game_ended" );
    self notify( #"watchforcurrentspectateclientdeathordisconnect" );
    self endon( #"watchforcurrentspectateclientdeathordisconnect" );
    self.var_993ed3af20851563 waittill( #"death_or_disconnect" );
    function_b399929b69e34ba0( 0 );
    params = spawnstruct();
    params.spectatingplayer = self;
    level callback::callback( "spectating_target_death_or_disconnect", params );
}

// Namespace playerlogic
// Params 1
// Checksum 0xe7b32cd, Offset: 0x11126
// Size: 0x56
function function_b399929b69e34ba0( instant )
{
    self.currentspectatetarget = undefined;
    self.var_993ed3af20851563 = undefined;
    self.var_78eccdb92a3a3896 = 1;
    fadeduration = instant ? 0 : 1;
    level thread game_utility::fadetoblackforplayerkeepui( self, 1, fadeduration );
}

// Namespace playerlogic
// Params 0
// Checksum 0x99da883b, Offset: 0x11184
// Size: 0x4e
function removespectateblackonspawn()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"removespectateblackonspawn" );
    self endon( #"removespectateblackonspawn" );
    self waittill( #"spawned_player" );
    level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0x4f289f24, Offset: 0x111da
// Size: 0x2a
function function_deac50631b68263d()
{
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
}

// Namespace playerlogic
// Params 0
// Checksum 0x88a9ecb8, Offset: 0x1120c
// Size: 0x68
function initglobalautopilot()
{
    if ( getdvarint( @"scr_globalautopilot", 0 ) == 1 || getdvarint( @"hash_636cff6350e5f626", 0 ) == 1 )
    {
        level callback::add( #"player_spawned", &function_1aea56e25cfb40f8 );
    }
    
    if ( getdvarint( @"scr_globalautopilot", 0 ) == 1 )
    {
        setdvarifuninitialized( @"hash_876e1130767adf57", 30 );
    }
}

// Namespace playerlogic
// Params 1, eflags: 0x4
// Checksum 0x36c8c084, Offset: 0x1127c
// Size: 0x53
function private function_1aea56e25cfb40f8( params )
{
    if ( self.var_f188ea8f251285a0 == 0 )
    {
        return;
    }
    
    if ( getdvarint( @"scr_globalautopilot", 0 ) == 1 || self isplayerheadless() && getdvarint( @"hash_636cff6350e5f626", 0 ) == 1 )
    {
        self function_ffb0711adb6d8d0d();
    }
}

// Namespace playerlogic
// Params 5
// Checksum 0x14ac96aa, Offset: 0x112d7
// Size: 0xf8
function spawnpoint_setspawnpoint( pos, angles, overrideent, isti, var_18b7235092c7464 )
{
    spawnpoint_clearspawnpoint();
    spawnpoint = undefined;
    
    if ( isdefined( overrideent ) )
    {
        spawnpoint = overrideent;
    }
    else
    {
        spawnpoint = spawn( "script_model", pos );
    }
    
    spawnpoint.playerspawnpos = pos;
    spawnpoint.playerspawnangles = angles;
    spawnpoint.notti = !isti;
    spawnpoint.issuper = istrue( overrideent.issuper );
    spawnpoint.var_18b7235092c7464 = var_18b7235092c7464;
    
    if ( var_18b7235092c7464 )
    {
        zoffset = getdvarint( @"hash_aae1c46aed802dea", 30 );
        spawnpoint.playerspawnpos += ( 0, 0, zoffset * -1 );
    }
    
    self.setspawnpoint = spawnpoint;
}

// Namespace playerlogic
// Params 3
// Checksum 0x15cc80bb, Offset: 0x113d7
// Size: 0x95
function spawnpoint_clearspawnpoint( wasdestroyed, var_5644e579357ab063, hidefeedback )
{
    if ( isdefined( self.setspawnpoint ) )
    {
        if ( self.setspawnpoint.notti )
        {
            self.setspawnpoint delete();
            return;
        }
        
        if ( utility::issharedfuncdefined( #"tac_insert", #"destroy" ) )
        {
            self.setspawnpoint [[ utility::getsharedfunc( #"tac_insert", #"destroy" ) ]]( wasdestroyed, var_5644e579357ab063, hidefeedback );
        }
    }
}

// Namespace playerlogic
// Params 2
// Checksum 0xed1106fe, Offset: 0x11474
// Size: 0x97
function function_8d15c151f143de4e( ent, isti )
{
    if ( !isdefined( ent ) )
    {
        self notify( #"hash_28a7bf6591914550" );
        return;
    }
    
    spawnpoint = ent;
    spawnpoint.playerspawnpos = ent.origin;
    spawnpoint.playerspawnangles = ent.angles;
    spawnpoint.notti = !isti;
    spawnpoint.issuper = istrue( ent.issuper );
    self.setspawnpoint = spawnpoint;
}

/#

    // Namespace playerlogic
    // Params 0
    // Checksum 0x1734bed1, Offset: 0x11513
    // Size: 0x8c, Type: dev
    function debugcommands()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_ebeff7f31e599ecb", 0 ) != 0 )
            {
                setdvar( @"hash_ebeff7f31e599ecb", 0 );
                
                if ( isdefined( self.currentspectatetarget ) )
                {
                    self.currentspectatetarget damage::_suicide();
                }
            }
            
            if ( getdvarint( @"hash_1bc12e3cf57a5f09", 0 ) != 0 )
            {
                setdvar( @"hash_1bc12e3cf57a5f09", 0 );
                
                if ( isdefined( self.var_993ed3af20851563 ) )
                {
                    self.var_993ed3af20851563 damage::_suicide();
                }
            }
            
            waitframe();
        }
    }

#/
