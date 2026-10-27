// script_3cb3908b3094b567  (hash_3cb3908b3094b567.gscc) (size: 12036 Bytes / 0x2f04 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa405d6bc (2751846076)
// size ...... 12036 (0x2f04)
// includes .. 14  (offset: 0x2a6c)
// strings ... 63  (offset: 0x2adc)
// dev strs .. 10  (offset: 0x2e8c)
// exports ... 19  (offset: 0x1e4c)
// cseg ...... 0x577 + 0x18d5 (0x1e4c)
// imports ... 74  (offset: 0x2144)
// animtree1 . 0   (offset: 0x2f04)
// animtree2 . 0   (offset: 0x2f04)
#using script_1f7a0c4a27e7e186;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\persistence;

#namespace mp_afk;

// Namespace mp_afk
// Params 0, eflags: 0x5
// Checksum 0xe46d4fa4, Offset: 0x595
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_afk", undefined, undefined, &post_main );
}

// Namespace mp_afk
// Params 0, eflags: 0x4
// Checksum 0xcc77292f, Offset: 0x5b6
// Size: 0x4e
function private post_main()
{
    if ( game_utility_mp::matchmakinggame() && !isintournament() && !getdvarint( @"hash_9b383028dfd6542d", 0 ) )
    {
        level thread watchafk();
        return;
    }
    
    /#
        if ( getdvarint( @"hash_14b345d46f1e9d77", 0 ) > 0 )
        {
            level thread watchafk();
        }
    #/
}

// Namespace mp_afk
// Params 0, eflags: 0xc
// Checksum 0xf3002094, Offset: 0x60c
// Size: 0x34c
function private watchafk()
{
    self notify( #"hash_e141d09052fa4d43" );
    self endon( #"hash_e141d09052fa4d43" );
    
    if ( getdvarint( @"debug_stopafkcheck", 0 ) == 1 )
    {
        return;
    }
    
    function_1723f8502c68d87b();
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    level.afkthresholds = { #var_66603405b103d2da:level.gametypebundle.var_66603405b103d2da ?? getdvarint( @"hash_dd0bcad4d12f8993", 1 ), #var_2031abebf5b5ebc9:level.gametypebundle.var_2031abebf5b5ebc9 ?? getdvarint( @"hash_8eee933f8b6a65ec", 1 ), #var_5b03ca1a65fdf8b4:level.gametypebundle.var_5b03ca1a65fdf8b4 ?? getdvarint( @"hash_dc406362e8a37974", 60 ), #var_6b0326acd4acfec3:getdvarint( @"hash_f6abc159163cdafa", 60 ), #var_db053f414032aaff:level.gametypebundle.var_db053f414032aaff ?? getdvarint( @"hash_eb6378a8e84c183", 60 ), #var_ae60efb8868dc896:getdvarint( @"hash_2ea000db61daba7b", 30 ), #var_f21903a24e3d5816:level.gametypebundle.var_f21903a24e3d5816 ?? 60, #var_3d4a54de01d5136c:level.gametypebundle.var_3d4a54de01d5136c ?? 30, #var_e006dc78a1655643:level.gametypebundle.var_de40626b694232a0 ?? getdvarfloat( @"hash_444f3c8b2a24404e", 35 ), #afkcheckstarttime:gettime(), #infirstround:isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] == 0 };
    level.var_4dd914bb587df856 = utility::function_48f723fdc612ec65( @"hash_213cadd687024445", 15, level.gametypebundle.var_4dd914bb587df856 );
    level.var_36aef689aae59c39 = utility::function_edc4cc03e9e60b3e( @"hash_be4deedc03e3accc", 0, level.gametypebundle.var_36aef689aae59c39 ) == 1;
    namespace_69870d3a29bda576::function_6b1acbf1e055f37f();
    function_2c599582c9f8a9d3();
    previousplayercount = level.players.size;
    nexttoupdate = 0;
    
    while ( true )
    {
        nexttoupdate++;
        
        if ( nexttoupdate >= level.players.size )
        {
            nexttoupdate = 0;
            
            if ( previousplayercount != level.players.size )
            {
                function_2c599582c9f8a9d3();
                previousplayercount = level.players.size;
            }
        }
        
        if ( isdefined( level.players[ nexttoupdate ] ) )
        {
            if ( isai( level.players[ nexttoupdate ] ) || isautopilot( level.players[ nexttoupdate ] ) )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.var_5bbfdd7562b793 ) )
            {
                level.players[ nexttoupdate ] [[ level.var_5bbfdd7562b793 ]]();
            }
            else
            {
                level.players[ nexttoupdate ] checkforafk();
            }
        }
        
        if ( isdefined( level.var_955f57de18620d4b ) )
        {
            var_f23cf60087986b81 = spawnstruct();
            throttle::throttle_wait_in_queue( level.var_955f57de18620d4b, var_f23cf60087986b81 );
        }
        else
        {
            waitframe();
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace mp_afk
// Params 0, eflags: 0x4
// Checksum 0x704b67f, Offset: 0x960
// Size: 0x17
function private function_1723f8502c68d87b()
{
    callback::add( #"stance_changed", &function_40fa9fdecdc31942 );
}

// Namespace mp_afk
// Params 0, eflags: 0x4
// Checksum 0x3556f151, Offset: 0x97f
// Size: 0x134, Type: bool
function private function_2c599582c9f8a9d3()
{
    if ( getdvarint( @"hash_11e4f85d7c35874e", 0 ) && level.players.size > 0 )
    {
        var_532a2a163fd8dfb7 = getdvarfloat( @"hash_ec95630806957d09", level.framedurationseconds );
        var_f7de7310fd9f1805 = var_532a2a163fd8dfb7 / level.players.size;
        
        if ( var_f7de7310fd9f1805 > level.framedurationseconds )
        {
            if ( isdefined( level.var_955f57de18620d4b ) )
            {
                throttle::throttle_destroy( level.var_955f57de18620d4b );
            }
            
            level.var_955f57de18620d4b = throttle::throttle_initialize( "teams_afk_player", 1, var_f7de7310fd9f1805 );
            println( "<dev string:x24>" + 1 + "<dev string:x4f>" + var_f7de7310fd9f1805 + "<dev string:x69>" + level.players.size + "<dev string:x79>" + gettime() + "<dev string:x7d>" );
            return true;
        }
        
        if ( isdefined( level.var_955f57de18620d4b ) )
        {
            println( "<dev string:x7f>" );
            level.var_955f57de18620d4b = undefined;
        }
        
        println( "<dev string:x11b>" + var_532a2a163fd8dfb7 + "<dev string:x155>" + level.framedurationseconds + "<dev string:x184>" + level.players.size );
    }
    
    return false;
}

// Namespace mp_afk
// Params 1, eflags: 0x4
// Checksum 0x26c803a7, Offset: 0xabc
// Size: 0x24
function private function_40fa9fdecdc31942( params )
{
    self.pers[ #"hash_11bd841fd224e960" ] = gettime();
}

// Namespace mp_afk
// Params 0
// Checksum 0xfcaf1d24, Offset: 0xae8
// Size: 0xf0
function function_a10af3f5e26c28da()
{
    /#
        if ( !isdefined( level.var_5ab0498cf1ac995e ) )
        {
            level.var_5ab0498cf1ac995e = getdvarint( @"hash_14b345d46f1e9d77", 0 ) == 1;
        }
    #/
    
    timeplayed = persistence::statgetchildbuffered( "round", "timePlayed", level.var_5ab0498cf1ac995e ) ?? 0;
    timedead = self.pers[ "timeDead" ] ?? 0;
    timeplayed = int( max( timeplayed - timedead, 0 ) );
    
    if ( isbrgamemode() )
    {
        timeplayed -= self.timeplayed[ "gulag" ] ?? 0;
        timeplayed -= self.timeplayed[ "resurgenceRespawn" ] ?? 0;
        timeplayed -= self.timeplayed[ "infil" ] ?? 0;
    }
    
    var_a4d774e3ac364c = self.pers[ "timePlayedOnFirstSpawn" ] ?? 0;
    return timeplayed - var_a4d774e3ac364c;
}

// Namespace mp_afk
// Params 3
// Checksum 0x900edd16, Offset: 0xbe1
// Size: 0x47
function function_3a77ec8a437459f( time, maxthreshold, warningtime )
{
    if ( time >= maxthreshold )
    {
        return 2;
    }
    else if ( warningtime > 0 && maxthreshold > warningtime )
    {
        if ( time >= maxthreshold - warningtime )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace mp_afk
// Params 0
// Checksum 0x943e1833, Offset: 0xc31
// Size: 0x62
function function_7d37470e35348dd4()
{
    if ( !isdefined( level.var_95022f01f0efbd1f ) )
    {
        level.var_95022f01f0efbd1f = isdefined( level.gametypebundle ) && level.gametypebundle.var_95022f01f0efbd1f;
        level.var_95022f01f0efbd1f = getdvarint( @"hash_ab58e70549e60c02", level.var_95022f01f0efbd1f );
    }
    
    return level.var_95022f01f0efbd1f;
}

// Namespace mp_afk
// Params 0
// Checksum 0x49d13b7a, Offset: 0xc9c
// Size: 0x51, Type: bool
function dontconsiderafk()
{
    if ( function_7d37470e35348dd4() )
    {
        return true;
    }
    
    if ( level.gameended || !self.hasspawned )
    {
        return true;
    }
    
    if ( callback::response( 0, #"hash_57a74c8771bf7e7", {} ) )
    {
        return true;
    }
    
    /#
        if ( self isnoclip() )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace mp_afk
// Params 0
// Checksum 0xdab664b5, Offset: 0xcf6
// Size: 0xaa9
function checkforafk()
{
    if ( dontconsiderafk() )
    {
        function_a710eba86b2e3782( self, "default", 0, 0 );
        return;
    }
    
    if ( !isdefined( self.var_90534cd58b6798f9 ) )
    {
        self.var_90534cd58b6798f9 = 0;
    }
    else if ( self.var_90534cd58b6798f9 > 0 )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "timePlayedOnFirstSpawn" ] ) )
    {
        return;
    }
    
    var_2c85c490d93da8ef = level.var_4dd914bb587df856;
    
    if ( !isdefined( self.pers[ "killsSinceLastAFKCheck" ] ) )
    {
        function_9592b6d120cfac02();
    }
    
    kills = self.pers[ "kills" ] - self.pers[ "killsSinceLastAFKCheck" ];
    assists = self.pers[ "assists" ] - self.pers[ "assistsSinceLastAFKCheck" ];
    downs = self.pers[ "downs" ] - self.pers[ "downsSinceLastAFKCheck" ] ?? 0;
    nokillsorassists = kills == 0 && assists == 0 && downs == 0;
    recentdamagestate = 2;
    
    if ( isdefined( self.pers[ "lastDamageTime" ] ) )
    {
        recentdamagestate = function_3a77ec8a437459f( gettime() - self.pers[ "lastDamageTime" ], 60000, var_2c85c490d93da8ef * 1000 );
    }
    
    var_7a373ccddb98427a = 2;
    
    if ( isdefined( self.pers[ #"hash_11bd841fd224e960" ] ) )
    {
        var_7a373ccddb98427a = function_3a77ec8a437459f( gettime() - self.pers[ #"hash_11bd841fd224e960" ], 11000, var_2c85c490d93da8ef * 1000 );
    }
    
    var_38d91eb1e4d2bc6a = function_a10af3f5e26c28da();
    lastdisttrackingpassedtime = self.pers[ "distTrackingPassedOrResetTime" ] ?? 0;
    timesincelastpasseddistcheck = var_38d91eb1e4d2bc6a - lastdisttrackingpassedtime;
    afkdisttimethreshold = 60;
    afknokillsorassists = nokillsorassists && timesincelastpasseddistcheck > 120;
    hasrecentmovementimmunity = ( self.var_186c72a9d88370e7 ?? 0 ) > gettime();
    distrackingpassed = self.pers[ "distTrackingPassed" ] || hasrecentmovementimmunity;
    
    if ( isbrgamemode() )
    {
        if ( self.brkickedfromplane )
        {
            afkdisttimethreshold = getdvarint( @"hash_613644ac82dead59", 60 );
        }
        else
        {
            afkdisttimethreshold = getdvarint( @"hash_a6a8cfe5f012e87a", 180 );
        }
    }
    else
    {
        if ( !isdefined( level.afkdisttimethreshold ) )
        {
            if ( game_utility::getgametype() == "arena" )
            {
                level.afkdisttimethreshold = getdvarint( @"hash_7f596f03ab14d1b4", 15 );
            }
            else if ( game_utility_mp::isroundbased() )
            {
                level.afkdisttimethreshold = getdvarint( @"hash_208180e807d0093b", 60 );
            }
            else
            {
                level.afkdisttimethreshold = getdvarint( @"hash_a6a8cfe5f012e87a", 60 );
            }
        }
        
        afkdisttimethreshold = level.afkdisttimethreshold;
    }
    
    if ( !isdefined( level.var_94a85d76034dbb18 ) )
    {
        level.var_94a85d76034dbb18 = getdvarint( @"hash_498399b2b9a609ad", 1 ) == 1;
    }
    
    if ( level.leagueplaymatch && isdefined( var_2c85c490d93da8ef ) && var_2c85c490d93da8ef > 0 && level.var_916baba1930e54af > afkdisttimethreshold - var_2c85c490d93da8ef )
    {
        level.var_916baba1930e54af = afkdisttimethreshold - var_2c85c490d93da8ef;
    }
    
    self.afkstate = 0;
    kickreason = "default";
    var_9fc0495c9e3638d2 = !nokillsorassists && level.var_94a85d76034dbb18;
    
    if ( level.var_6efaf96150acaafa )
    {
        self.afkstate = function_3a77ec8a437459f( timesincelastpasseddistcheck, afkdisttimethreshold, var_2c85c490d93da8ef );
        
        if ( self iscommandinputstale() && self.sessionstate == "playing" && !distrackingpassed )
        {
            kickreason = "checkForAFK() TRUE, IsCommandInputStale() - " + self.name + "timeSinceLastPassedDistCheck (" + timesincelastpasseddistcheck + ") > afkDistTimeThreshold(" + afkdisttimethreshold + "), lastDistTrackingPassedTime: " + lastdisttrackingpassedtime;
        }
        else if ( self.var_952d105ca1c0d4fe && self.afkstate == 0 )
        {
            self.var_952d105ca1c0d4fe = 0;
            self notify( #"quit_afk" );
        }
    }
    else if ( self iscommandinputstale() && self.sessionstate == "playing" && nokillsorassists && !distrackingpassed && !var_9fc0495c9e3638d2 )
    {
        self.afkstate = function_3a77ec8a437459f( timesincelastpasseddistcheck, afkdisttimethreshold, var_2c85c490d93da8ef );
        kickreason = "checkForAFK() TRUE, IsCommandInputStale() - " + self.name + "timeSinceLastPassedDistCheck (" + timesincelastpasseddistcheck + ") > afkDistTimeThreshold(" + afkdisttimethreshold + "), lastDistTrackingPassedTime: " + lastdisttrackingpassedtime;
    }
    
    if ( self iscommandinputrepetitive() && !isdefined( self.vehicle ) && !var_9fc0495c9e3638d2 )
    {
        self.afkstate = 2;
        kickreason = "checkForAFK() TRUE, IsCommandInputRepetitive() - " + self.name + "timeSinceLastPassedDistCheck ( " + timesincelastpasseddistcheck + " ), lastDistTrackingPassedTime: " + lastdisttrackingpassedtime;
    }
    
    islonground = game_utility::getgametype() == "ctf" || game_utility::getgametype() == "wm";
    
    if ( game_utility_mp::isroundbased() && !islonground )
    {
        checkdistancetravelled = nokillsorassists || level.gametype == "arena";
        
        if ( level.gametype != "arena" )
        {
            if ( nokillsorassists )
            {
                if ( recentdamagestate != 0 )
                {
                    switch ( level.gametype )
                    {
                        case #"hash_fb5b5e6c07253005":
                            if ( level.kick_afk_check )
                            {
                                self.afkstate = maxint( self.afkstate, recentdamagestate );
                            }
                            
                            break;
                    }
                }
            }
        }
        
        if ( checkdistancetravelled && !distrackingpassed )
        {
            var_ec16d68eb91e0ca7 = function_3a77ec8a437459f( timesincelastpasseddistcheck, afkdisttimethreshold, var_2c85c490d93da8ef );
            
            if ( game_utility::isinfectedgametype() )
            {
                if ( self.team == "axis" )
                {
                    self.afkstate = maxint( self.afkstate, var_ec16d68eb91e0ca7 );
                }
            }
            else if ( level.gametype == "ballmode" )
            {
                hasgoal = self.pers[ "goals" ] > 0;
                hasassist = self.pers[ "assists" ] > 0;
                var_29cc13babfa8329 = 2;
                
                if ( isdefined( self.pers[ "lastTouchTime" ] ) )
                {
                    function_3a77ec8a437459f( timesincelastpasseddistcheck - self.pers[ "lastTouchTime" ], 60, var_2c85c490d93da8ef );
                }
                
                var_6ea7394a14de0250 = 2;
                
                if ( isdefined( self.pers[ "lastRamTime" ] ) )
                {
                    var_6ea7394a14de0250 = function_3a77ec8a437459f( timesincelastpasseddistcheck - self.pers[ "lastRamTime" ], 60, var_2c85c490d93da8ef );
                }
                
                if ( !hasgoal && !hasassist )
                {
                    var_568c1a659868c4a0 = minint( minint( var_29cc13babfa8329, var_6ea7394a14de0250 ), var_ec16d68eb91e0ca7 );
                    self.afkstate = maxint( self.afkstate, var_568c1a659868c4a0 );
                }
            }
            else
            {
                var_568c1a659868c4a0 = minint( var_ec16d68eb91e0ca7, var_7a373ccddb98427a );
                self.afkstate = maxint( self.afkstate, var_568c1a659868c4a0 );
                kickreason = "checkForAFK() TRUE, " + self.name + "timeSinceLastPassedDistCheck ( " + timesincelastpasseddistcheck + " ), disTrackingPassed: " + distrackingpassed;
            }
        }
        
        if ( !isdefined( self.pers[ "roundsAFK" ] ) )
        {
            self.pers[ "roundsAFK" ] = 0;
        }
        
        if ( self.afkstate == 2 && !self.afkroundcounted )
        {
            self.afkroundcounted = 1;
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "roundsAFK" ] ) )
                {
                    self.leaderboarddata[ "roundsAFK" ] = self.leaderboarddata[ "roundsAFK" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "roundsAFK" ] ) )
                {
                    [[ level.leaderboardfunc[ "roundsAFK" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x19d>" );
                
                if ( isdefined( self.pers[ "roundsAFK" ] ) )
                {
                    self.pers[ "roundsAFK" ] = self.pers[ "roundsAFK" ] + 1;
                }
            }
            
            if ( self.pers[ "roundsAFK" ] >= level.gametypebundle.var_4b2e0a10cb24f590 )
            {
                allowkick = 1;
            }
        }
        
        function_a710eba86b2e3782( self, kickreason, self.afkstate, allowkick );
        return;
    }
    else
    {
        if ( !isdefined( self.var_c38ca5641e393f49 ) || self.var_c38ca5641e393f49 < 3 )
        {
            if ( nokillsorassists )
            {
                var_e31740eb94f7ace5 = function_3a77ec8a437459f( timesincelastpasseddistcheck, afkdisttimethreshold, var_2c85c490d93da8ef );
                var_568c1a659868c4a0 = minint( var_e31740eb94f7ace5, recentdamagestate );
                
                if ( !distrackingpassed )
                {
                    if ( game_utility::isinfectedgametype() )
                    {
                        if ( self.team == "axis" )
                        {
                            self.afkstate = maxint( self.afkstate, var_568c1a659868c4a0 );
                        }
                    }
                    else
                    {
                        self.afkstate = maxint( self.afkstate, var_568c1a659868c4a0 );
                        kickreason = "checkForAFK() TRUE, Non Round Based " + self.name + "( noKillsOrAssists(" + nokillsorassists + ") && !recentDamageState(" + recentdamagestate + ") && timeSinceLastPassedDistCheck(" + timesincelastpasseddistcheck + ") >= afkDistTimeThreshold(" + afkdisttimethreshold + "), lastDistTrackingPassedTime: " + lastdisttrackingpassedtime;
                    }
                }
            }
        }
        
        if ( getdvarint( @"hash_b42e148f11d9d225", 0 ) == 1 )
        {
            if ( isdefined( self.pers[ "passedAFKActions" ] ) && !self.pers[ "passedAFKActions" ] )
            {
                var_da247f3c5edfb54 = afkdisttimethreshold;
                timeplayed = function_a10af3f5e26c28da();
                var_f6f9c024d1b11413 = function_3a77ec8a437459f( timeplayed, afkdisttimethreshold, var_2c85c490d93da8ef );
                self.afkstate = maxint( self.afkstate, var_f6f9c024d1b11413 );
                
                if ( var_f6f9c024d1b11413 == 2 )
                {
                    kickreason = "checkForAFK() TRUE, Non Round Based " + self.name + "timePlayed(" + timeplayed + ") >= afkActionTimeThreshold(" + var_da247f3c5edfb54 + "), timeSinceLastPassedDistCheck: " + timesincelastpasseddistcheck;
                }
            }
        }
        
        if ( afknokillsorassists )
        {
            if ( recentdamagestate != 0 )
            {
                switch ( level.gametype )
                {
                    case #"hash_fb5b5e6c07253005":
                        if ( level.kick_afk_check )
                        {
                            self.afkstate = maxint( self.afkstate, recentdamagestate );
                        }
                        
                        break;
                }
            }
        }
    }
    
    function_69dd57f722895615( self );
    function_a710eba86b2e3782( self, kickreason, self.afkstate, 1 );
}

// Namespace mp_afk
// Params 0
// Checksum 0x772ae687, Offset: 0x17a7
// Size: 0xc1
function function_6de2d08143a6b2db()
{
    if ( !isdefined( level.var_69178ae7080b5242 ) )
    {
        level.var_69178ae7080b5242 = getdvarint( @"hash_9ffca4bff65ca226", 0 );
        
        if ( game_utility_mp::isroundbased() && level.initialtimelimit < 300 )
        {
            level.var_69178ae7080b5242 = 1;
        }
    }
    
    if ( level.var_69178ae7080b5242 )
    {
        return 0;
    }
    
    if ( !isdefined( self.var_868ce02bf8809dd7 ) )
    {
        self.var_868ce02bf8809dd7 = gettime();
    }
    
    if ( gettime() - self.var_868ce02bf8809dd7 < 5000 )
    {
        return 0;
    }
    
    self.var_868ce02bf8809dd7 = gettime();
    var_abe6b4b6376cdd55 = gettime() - function_f3fb78a10ad35c8d();
    
    if ( var_abe6b4b6376cdd55 > 120000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace mp_afk
// Params 0
// Checksum 0x2db99156, Offset: 0x1870
// Size: 0x6b
function function_9592b6d120cfac02()
{
    self.pers[ "killsSinceLastAFKCheck" ] = self.pers[ "kills" ] ?? 0;
    self.pers[ "assistsSinceLastAFKCheck" ] = self.pers[ "assists" ] ?? 0;
    self.pers[ "downsSinceLastAFKCheck" ] = self.pers[ "downs" ] ?? 0;
}

// Namespace mp_afk
// Params 0
// Checksum 0x960b4345, Offset: 0x18e3
// Size: 0xcc
function function_f3fb78a10ad35c8d()
{
    gainedkill = self.pers[ "kills" ] - self.pers[ "killsSinceLastAFKCheck" ] > 0;
    gainedassist = self.pers[ "assists" ] - self.pers[ "killsSinceLastAFKCheck" ] > 0;
    gaineddown = self.pers[ "downs" ] - self.pers[ "downsSinceLastAFKCheck" ] > 0;
    
    if ( !isdefined( self.var_50949e884b8ae439 ) )
    {
        self.var_50949e884b8ae439 = gettime();
    }
    
    if ( gainedkill || gainedassist || gaineddown )
    {
        self.var_50949e884b8ae439 = gettime();
        function_9592b6d120cfac02();
    }
    
    return self.var_50949e884b8ae439;
}

// Namespace mp_afk
// Params 2
// Checksum 0xdf170616, Offset: 0x19b8
// Size: 0x127
function kickafkplayer( player, reason )
{
    player endon( #"disconnect" );
    
    if ( player.var_3ac39ef107e8744a )
    {
        return;
    }
    
    if ( getdvarint( @"hash_5fe08edb9d760660", 1 ) )
    {
        if ( player.var_79d7cc3d8fac4049 )
        {
            return;
        }
        
        player.var_79d7cc3d8fac4049 = 1;
        
        if ( !player.var_e9aae5c3052b7ddc )
        {
            function_451f15b5f0c68de2( player );
            warningtime = level.var_4dd914bb587df856 ?? 15;
            
            if ( warningtime > 0 )
            {
                wait warningtime;
            }
            
            if ( !player )
            {
                return;
            }
            
            if ( !player.var_e9aae5c3052b7ddc )
            {
                player.var_79d7cc3d8fac4049 = 0;
                return;
            }
        }
    }
    
    if ( isstring( reason ) )
    {
        logstring( reason );
        player dlog_recordplayerevent( "dlog_event_player_afk_kicked", [ "reason", reason ] );
    }
    
    player notify( #"hash_8acc9ce5403b2d9e" );
    player.var_3ac39ef107e8744a = 1;
    wait 1;
    
    if ( !player )
    {
        return;
    }
    
    kick( player getentitynumber(), &"EXE/PLAYERKICKED_INACTIVE", 1 );
}

// Namespace mp_afk
// Params 2
// Checksum 0x913344bd, Offset: 0x1ae7
// Size: 0xb5
function function_69dd57f722895615( player, var_1e552a9ca33a0b95 )
{
    var_1e552a9ca33a0b95 = getdvarint( @"hash_bcb3490a1a9ba927", int( level.gametypebundle.var_1e552a9ca33a0b95 ?? 0 ) );
    
    if ( var_1e552a9ca33a0b95 > 0 )
    {
        timeplayed = function_a10af3f5e26c28da();
        lastactivetime = self.pers[ "distTrackingPassedOrResetTime" ];
        
        if ( isdefined( timeplayed ) && isdefined( lastactivetime ) )
        {
            var_3d10f557780e179d = timeplayed - lastactivetime;
        }
        
        if ( var_3d10f557780e179d > var_1e552a9ca33a0b95 )
        {
            player val::set( "afkScaleXP", "xp_scale", 0 );
            return;
        }
    }
    
    player val::reset_all( "afkScaleXP" );
}

// Namespace mp_afk
// Params 4
// Checksum 0x3eb55824, Offset: 0x1ba4
// Size: 0x11b
function function_a710eba86b2e3782( player, reason, afkstate, allowkick )
{
    switch ( afkstate )
    {
        case 0:
            if ( player.var_e9aae5c3052b7ddc && !level.var_36aef689aae59c39 )
            {
                player.var_e9aae5c3052b7ddc = 0;
                player setclientomnvar( "ui_afk_warning", 0 );
            }
            
            break;
        case 1:
            if ( !player.var_e9aae5c3052b7ddc )
            {
                function_451f15b5f0c68de2( player );
            }
            
            break;
        case 2:
            if ( allowkick )
            {
                if ( utility::issharedfuncdefined( #"zm_afk_check", #"afk_timer" ) )
                {
                    if ( !player.var_952d105ca1c0d4fe )
                    {
                        player.var_952d105ca1c0d4fe = 1;
                        player thread utility::callsharedfunc( #"zm_afk_check", #"afk_timer" );
                    }
                }
                else
                {
                    level thread kickafkplayer( player, reason ?? "default" );
                }
            }
            
            break;
    }
}

// Namespace mp_afk
// Params 1
// Checksum 0x896c4f1c, Offset: 0x1cc7
// Size: 0x185
function function_451f15b5f0c68de2( player )
{
    player.var_e9aae5c3052b7ddc = 1;
    
    if ( level.var_36aef689aae59c39 )
    {
        aliveteammates = function_5713d46873b29625( teams::getteamdata( player.team, "alivePlayers" ) );
        
        foreach ( p in aliveteammates )
        {
            if ( p br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( p == player )
            {
                p hud_message::function_ccbbac80e736b9f9( "popup_afk_warning", undefined, undefined, undefined, 1 );
                continue;
            }
            
            p hud_message::function_ccbbac80e736b9f9( "popup_afk_warning_teammate", undefined, player, undefined, 1 );
        }
    }
    else
    {
        player setclientomnvar( "ui_afk_warning", 1 );
    }
    
    player dlog_recordplayerevent( "dlog_event_player_afk_warning", [ "server_time", int( gettime() / 1000 ), "map_name", level.mapname ?? "", "playlist_name", getplaylistname() ?? "", "circle_index", level.br_circle.circleindex ?? -1 ] );
}

