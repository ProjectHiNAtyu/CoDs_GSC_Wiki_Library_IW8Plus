// scripts\mp\accolades.gsc  (hash_13d14023c67003bf.gscc) (size: 19457 Bytes / 0x4c01 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1ae4bf8 (4054731768)
// size ...... 19457 (0x4c01)
// includes .. 5   (offset: 0x3fb1)
// strings ... 188 (offset: 0x3fd9)
// dev strs .. 11  (offset: 0x4b71)
// exports ... 36  (offset: 0x3051)
// cseg ...... 0xe69 + 0x21e8 (0x3051)
// imports ... 53  (offset: 0x35f1)
// animtree1 . 0   (offset: 0x4c01)
// animtree2 . 0   (offset: 0x4c01)
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dogtag;

#namespace accolades;

// Namespace accolades
// Params 0
// Checksum 0x8be34ac0, Offset: 0xe87
// Size: 0x136a
function init()
{
    level.accolades = [];
    
    if ( !isdefined( level.disableaccolades ) )
    {
        if ( getdvarint( @"hash_609906ade74f653e", 0 ) )
        {
            level.disableaccolades = 1;
        }
        else if ( level.gamemodebundle.disableaccolades )
        {
            level.disableaccolades = 1;
        }
        else
        {
            level.disableaccolades = 0;
        }
    }
    
    if ( level.disableaccolades )
    {
        return;
    }
    
    registeraccolade( "adsKills", [ "adsKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "hipfireKills", [ "hipfireKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "lowerRankedKills", [ "lowerRankedKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "higherRankedKills", [ "higherRankedKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "highestRankedKills", [ "highestRankedKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "reloads", [ "reloads" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "weaponPickups", [ "weaponPickups" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "shotsFired", [ "shotsFired" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "classChanges", [ "classChanges" ], 0, 0, &isclasschoiceallowed, undefined, undefined );
    registeraccolade( "headshots", [ "headshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "timeWatchingKillcams", [ "timeWatchingKillcams" ], 0, 0, &arekillcamsenabled, undefined, undefined );
    registeraccolade( "skippedKillcams", [ "skippedKillcams" ], 0, 0, &arekillcamsenabled, undefined, undefined );
    registeraccolade( "longestStreak", [ "longestStreak" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "mostKills", [ "kills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "leastKills", [ "kills" ], 0, 1, undefined, undefined, &scoreminimum );
    registeraccolade( "mostAssists", [ "assists" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "leastAssists", [ "assists" ], 0, 1, undefined, undefined, &scoreminimum );
    registeraccolade( "mostDeaths", [ "deaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "leastDeaths", [ "deaths" ], 0, 1, undefined, undefined, &scoreminimum );
    registeraccolade( "suicides", [ "suicides" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "noKillsWithDeath", [ "kills", "deaths" ], 0, 0, undefined, undefined, &nokillswithdeath_evaluate );
    registeraccolade( "noKillNoDeath", [ "kills", "deaths" ], 0, 0, undefined, undefined, &nokillnodeath_evaluate );
    registeraccolade( "noKill10Deaths", [ "kills", "deaths" ], 0, 0, undefined, undefined, &nokill10deaths_evaluate );
    registeraccolade( "mostKillsLeastDeaths", [ "kills", "deaths" ], 0, 0, undefined, undefined, &mostkillsleastdeaths_evaluate );
    registeraccolade( "mostKillsMostHeadshots", [ "kills", "headshots" ], 0, 0, undefined, undefined, &mostkillsmostheadshots_evaluate );
    registeraccolade( "mostKillsLongestStreak", [ "kills", "longestStreak" ], 0, 0, undefined, undefined, &mostkillslongeststreak_evaluate );
    registeraccolade( "kills10NoDeaths", [ "kills", "deaths" ], 0, 0, undefined, undefined, &kills10nodeaths_evaluate );
    registeraccolade( "deathsFromBehind", [ "deathsFromBehind" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "killsFromBehind", [ "killsFromBehind" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "noDeathsFromBehind", [ "deathsFromBehind" ], 0, 1, undefined, undefined, &nodeathsfrombehind_evaluate );
    registeraccolade( "shortestLife", [ "shortestLife" ], 0, 0, undefined, undefined, &scoreminimum );
    registeraccolade( "longestLife", [ "longestLife" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "damageDealt", [ "damage" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "damageTaken", [ "damageTaken" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "highestMultikill", [ "highestMultikill" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "mostMultikills", [ "mostMultikills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "revives", [ "revives" ], 0, 0, &isreviveenabled, undefined, undefined );
    registeraccolade( "penetrationKills", [ "penetrationKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "revengeKills", [ "revengeKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "avengerKills", [ "avengerKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "defenderKills", [ "defenderKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "longshotKills", [ "longshotKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "pointBlankKills", [ "pointBlankKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "oneShotOneKills", [ "oneShotOneKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "executionKills", [ "executionKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "comebackKills", [ "comebackKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "explosionsSurvived", [ "explosionsSurvived" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "killEnemyTeam", [ "killEnemyTeam" ], 0, 0, &function_325b5e18c053a0a6, undefined, undefined );
    registeraccolade( "timeCrouched", [ "timeCrouched" ], 0, 0, &isnotleanthreadmode, undefined, undefined );
    registeraccolade( "timeProne", [ "timeProne" ], 0, 0, &isnotleanthreadmode, undefined, undefined );
    registeraccolade( "distanceTravelled", [ "totalDistTraveled" ], 0, 0, &isnotleanthreadmode, undefined, undefined );
    registeraccolade( "highestAvgAltitude", [ "averageAltitude", "averageAltitudeCount" ], 0, 0, &isnotleanthreadmode, undefined, &highestavgaltitude_evaluate );
    registeraccolade( "lowestAvgAltitude", [ "averageAltitude", "averageAltitudeCount" ], 0, 0, &isnotleanthreadmode, undefined, &lowestavgaltitude_evaluate );
    registeraccolade( "meleeKills", [ "meleeKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "pistolKills", [ "pistolKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "launcherKills", [ "launcherKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "shotgunKills", [ "shotgunKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "smgKills", [ "smgKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "arKills", [ "arKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "lmgKills", [ "lmgKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "sniperKills", [ "sniperKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "pistolHeadshots", [ "pistolHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "launcherHeadshots", [ "launcherHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "shotgunHeadshots", [ "shotgunHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "smgHeadshots", [ "smgHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "arHeadshots", [ "arHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "lmgHeadshots", [ "lmgHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "sniperHeadshots", [ "sniperHeadshots" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "meleeDeaths", [ "meleeDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "pistolPeaths", [ "pistolPeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "launcherDeaths", [ "launcherDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "shotgunDeaths", [ "shotgunDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "smgDeaths", [ "smgDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "arDeaths", [ "arDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "lmgDeaths", [ "lmgDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "sniperDeaths", [ "sniperDeaths" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "riotShieldDamageAbsorbed", [ "riotShieldDamageAbsorbed" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "killstreakPersonalUAVKills", [ "killstreakPersonalUAVKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakShieldTurretKills", [ "killstreakShieldTurretKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakUAVAssists", [ "killstreakUAVAssists" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakCUAVAssists", [ "killstreakCUAVAssists" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakFalseFlagAssists", [ "killstreakFalseFlagAssists" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakCarePackageUsed", [ "killstreakCarePackageUsed" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakCluserStrikeKills", [ "killstreakCluserStrikeKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakCruiseMissileKills", [ "killstreakCruiseMissileKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakAirstrikeKills", [ "killstreakAirstrikeKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakTankKills", [ "killstreakTankKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakSentryGunKills", [ "killstreakSentryGunKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakWheelsonKills", [ "killstreakWheelsonKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakEmergencyAirdropUsed", [ "killstreakEmergencyAirdropUsed" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakVTOLJetKills", [ "killstreakVTOLJetKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakWhitePhosphorousKillsAssists", [ "killstreakWhitePhosphorousKillsAssists" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakChopperGunnerKills", [ "killstreakChopperGunnerKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakChopperSupportKills", [ "killstreakChopperSupportKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakGunshipKills", [ "killstreakGunshipKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakAUAVAssists", [ "killstreakAUAVAssists" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakJuggernautKills", [ "killstreakJuggernautKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakKills", [ "killstreakKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakAirKills", [ "killstreakAirKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakGroundKills", [ "killstreakGroundKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "destroyedKillstreaks", [ "destroyedKillstreaks" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "killstreakRemoteTurretKills", [ "killstreakRemoteTurretKills" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "fragKills", [ "fragKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "semtexKills", [ "semtexKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "molotovKills", [ "molotovKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "claymoreKills", [ "claymoreKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "throwingKnifeKills", [ "throwingKnifeKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "c4LethalKills", [ "c4Kills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "thermiteKills", [ "thermiteKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "proximityMineKills", [ "proximityMineKills" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "flashbangHits", [ "flashbangHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "smokesUsed", [ "smokesUsed" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "stunHits", [ "stunHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "stimDamageHealed", [ "stimDamageHealed" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "decoyHits", [ "decoyHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "gasHits", [ "gasHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "snapshotHits", [ "snapshotHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "trackerGrenadeHits", [ "trackerGrenadeHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "butterflyMineHits", [ "butterflyMineHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "thermobaricGrenadeHits", [ "thermobaricGrenadeHits" ], 0, 0, undefined, undefined, undefined );
    registeraccolade( "ammoBoxUsed", [ "ammoBoxUsed" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "reconDroneMarks", [ "reconDroneMarks" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "empDroneHits", [ "empDroneHits" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "stoppingPowerKills", [ "stoppingPowerKills" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "trophySystemHits", [ "trophySystemHits" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "deadSilenceKills", [ "deadSilenceKills" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "tacticalInsertionSpawns", [ "tacticalInsertionSpawns" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "deployableCoverUsed", [ "deployableCoverUsed" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "munitionsBoxUsed", [ "munitionsBoxUsed" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "blastshieldBoxUsed", [ "blastshieldBoxUsed" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "selfReviveBoxUsed", [ "selfReviveBoxUsed" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
    registeraccolade( "defends", [ "defends" ], 0, 0, &isobjectivegametype, undefined, undefined );
    registeraccolade( "assaults", [ "assaults" ], 0, 0, &isobjectivegametype, undefined, undefined );
    registeraccolade( "pickups", [ "pickups" ], 0, 0, &iscarrygametype, undefined, undefined );
    registeraccolade( "captures", [ "captures" ], 0, 0, &iscapturegametype, undefined, undefined );
    registeraccolade( "returns", [ "returns" ], 0, 0, &isctf, undefined, undefined );
    registeraccolade( "carrierKills", [ "carrierKills" ], 0, 0, &iscarrygametype, undefined, undefined );
    registeraccolade( "bombPlanted", [ "plants" ], 0, 0, &isbombgametype, undefined, undefined );
    registeraccolade( "bombDefused", [ "defuses" ], 0, 0, &isbombgametype, undefined, undefined );
    registeraccolade( "bombDetonated", [ "destructions" ], 0, 0, &isbombgametype, undefined, undefined );
    registeraccolade( "clutch", [ "clutch" ], 0, 0, &game_utility_mp::islifelimited, undefined, undefined );
    registeraccolade( "clutchRevives", [ "clutchRevives" ], 0, 0, &isreviveenabled, undefined, undefined );
    registeraccolade( "tagsCaptured", [ "confirmed" ], 0, 0, &aretagsenabled, undefined, undefined );
    registeraccolade( "tagsDenied", [ "denied" ], 0, 0, &aretagsenabled, undefined, undefined );
    registeraccolade( "tagsMegaBanked", [ "tagsMegaBanked" ], 0, 0, &isgrind, undefined, undefined );
    registeraccolade( "tagsLargestBank", [ "tagsLargestBank" ], 0, 0, &isgrind, undefined, undefined );
    registeraccolade( "firstInfected", [ "firstInfected" ], 0, 0, &isinfected, undefined, undefined );
    registeraccolade( "survivorKills", [ "killsAsSurvivor" ], 0, 0, &isinfected, undefined, undefined );
    registeraccolade( "infectedKills", [ "killsAsInfected" ], 0, 0, &isinfected, undefined, undefined );
    registeraccolade( "lastSurvivor", [ "lastSurvivor" ], 0, 0, &isinfected, undefined, undefined );
    registeraccolade( "setbacks", [ "setbacks" ], 0, 0, &isgungame, undefined, undefined );
    registeraccolade( "longestTimeSpentOnWeapon", [ "longestTimeSpentOnWeapon" ], 0, 0, &isgungame, undefined, undefined );
    registeraccolade( "carepackagesCaptured", [ "carepackagesCaptured" ], 0, 0, &arekillstreaksallowed, undefined, undefined );
    registeraccolade( "spawnSelectSquad", [ "spawnSelectSquad" ], 0, 0, &isspawnselectionenabled, undefined, undefined );
    registeraccolade( "spawnSelectVehicle", [ "spawnSelectVehicle" ], 0, 0, &isspawnselectionenabled, undefined, undefined );
    registeraccolade( "spawnSelectFlag", [ "spawnSelectFlag" ], 0, 0, &isspawnselectionenabled, undefined, undefined );
    registeraccolade( "spawnSelectBase", [ "spawnSelectBase" ], 0, 0, &isspawnselectionenabled, undefined, undefined );
    registeraccolade( "timesSelectedAsSquadLeader", [ "timesSelectedAsSquadLeader" ], 0, 0, &isspawnselectionenabled, undefined, undefined );
    registeraccolade( "timeSpentAsDriver", [ "timeSpentAsDriver" ], 0, 0, &arevehiclesenabled, undefined, undefined );
    registeraccolade( "timeSpentAsPassenger", [ "timeSpentAsPassenger" ], 0, 0, &arevehiclesenabled, undefined, undefined );
    registeraccolade( "distanceTraveledInVehicle", [ "distanceTraveledInVehicle" ], 0, 0, &arevehiclesenabled, undefined, undefined );
    registeraccolade( "timeOnPoint", [ "objTime" ], 0, 0, &ishardpoint, undefined, undefined );
    registeraccolade( "armorBoxUsed", [ "armorBoxUsed" ], 0, 0, &arefieldupgradesallowed, undefined, undefined );
}

// Namespace accolades
// Params 7
// Checksum 0x298d61af, Offset: 0x21f9
// Size: 0xfa
function registeraccolade( ref, datapoints, priority, var_f8fda58686e8f277, validatefunc, updatefunc, evaluatefunc )
{
    if ( level.disableaccolades )
    {
        return;
    }
    
    assert( !isdefined( level.accolades[ ref ] ), "<dev string:x24>" + ref + "<dev string:x3c>" );
    data = spawnstruct();
    data.datapoints = datapoints;
    data.priority = priority;
    data.intialvalueisvalid = var_f8fda58686e8f277;
    data.evaluatefunc = evaluatefunc;
    data.winners = [];
    data.isactive = !isdefined( validatefunc ) || [[ validatefunc ]]();
    level.accolades[ ref ] = data;
    
    if ( isdefined( updatefunc ) )
    {
        level thread [[ updatefunc ]]();
    }
}

// Namespace accolades
// Params 0
// Checksum 0xf244b022, Offset: 0x22fb
// Size: 0x15e
function applyaccoladestructtoplayerpers()
{
    if ( level.disableaccolades )
    {
        return;
    }
    
    if ( !level.rankedmatch )
    {
        return;
    }
    
    isbotplayer = isbot( self );
    
    foreach ( ref, accolade in level.accolades )
    {
        if ( !isbotplayer )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchAccolades", ref, 0 );
        }
        
        if ( !isdefined( accolade.datapoints ) )
        {
            continue;
        }
        
        foreach ( datapoint in accolade.datapoints )
        {
            if ( !isdefined( self.pers[ datapoint ] ) )
            {
                self.pers[ datapoint ] = 0;
            }
        }
    }
}

// Namespace accolades
// Params 0
// Checksum 0xa4ce07eb, Offset: 0x2461
// Size: 0x3c6
function evaluateallaccolades()
{
    if ( !level.challengesallowed )
    {
        return;
    }
    
    if ( level.disableaccolades )
    {
        return;
    }
    
    foreach ( ref, accolade in level.accolades )
    {
        if ( !accolade.isactive )
        {
            continue;
        }
        
        level evaluateaccolade( ref );
    }
    
    foreach ( ref, accolade in level.accolades )
    {
        if ( !accolade.isactive )
        {
            continue;
        }
        
        foreach ( winner in accolade.winners )
        {
            if ( !isdefined( winner ) )
            {
                continue;
            }
            
            if ( isbot( winner ) )
            {
                continue;
            }
            
            oldval = winner getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "accoladeStats", ref );
            winner setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "accoladeStats", ref, oldval + 1 );
            winner setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchAccolades", ref, 1 );
        }
    }
    
    /#
        println( "<dev string:x4d>" );
        println( "<dev string:x92>" );
        println( "<dev string:x4d>" );
        
        foreach ( ref, accolade in level.accolades )
        {
            if ( !accolade.isactive )
            {
                continue;
            }
            
            println( ref );
            
            foreach ( winner in accolade.winners )
            {
                playervalue = 0;
                
                if ( isdefined( level.accolades[ ref ].evaluatefunc ) )
                {
                    playervalue = winner [[ level.accolades[ ref ].evaluatefunc ]]( ref );
                }
                else
                {
                    assert( level.accolades[ ref ].datapoints.size == 1, "<dev string:xd7>" + ref + "<dev string:xe1>" );
                    playervalue = winner.pers[ level.accolades[ ref ].datapoints[ 0 ] ];
                }
                
                println( "<dev string:x11a>" + playervalue + "<dev string:x11c>" + winner.name );
            }
            
            println( "<dev string:x11e>" );
        }
    #/
}

// Namespace accolades
// Params 1
// Checksum 0xd4f07b87, Offset: 0x282f
// Size: 0x1b3
function evaluateaccolade( ref )
{
    highestvalue = undefined;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        refdata = level.accolades[ ref ];
        playervalue = player.pers[ ref ];
        
        if ( isdefined( refdata.evaluatefunc ) )
        {
            playervalue = player [[ refdata.evaluatefunc ]]( ref );
        }
        else
        {
            assert( refdata.datapoints.size == 1, "<dev string:xd7>" + ref + "<dev string:xe1>" );
            playervalue = player.pers[ refdata.datapoints[ 0 ] ];
        }
        
        if ( !isdefined( playervalue ) || !refdata.intialvalueisvalid && playervalue == 0 )
        {
            continue;
        }
        
        if ( !isdefined( highestvalue ) || playervalue > highestvalue )
        {
            highestvalue = playervalue;
            
            if ( !isdefined( refdata.winners ) )
            {
                refdata.winners = [];
            }
            
            refdata.winners[ refdata.winners.size ] = player;
            continue;
        }
        
        if ( playervalue == highestvalue )
        {
            refdata.winners[ refdata.winners.size ] = player;
        }
    }
}

// Namespace accolades
// Params 0
// Checksum 0x35071266, Offset: 0x29ea
// Size: 0xc, Type: bool
function arekillcamsenabled()
{
    return istrue( level.killcam );
}

// Namespace accolades
// Params 0
// Checksum 0x94151af2, Offset: 0x29ff
// Size: 0x9, Type: bool
function isnotleanthreadmode()
{
    return !game_utility_mp::runleanthreadmode();
}

// Namespace accolades
// Params 0
// Checksum 0x5c000ed0, Offset: 0x2a11
// Size: 0x14
function isclasschoiceallowed()
{
    flags::gameflagwait( "infil_setup_complete" );
    return game_utility_mp::allowclasschoice();
}

// Namespace accolades
// Params 0
// Checksum 0x8e979f63, Offset: 0x2a2e
// Size: 0xc, Type: bool
function isreviveenabled()
{
    return istrue( level.numrevives );
}

// Namespace accolades
// Params 0
// Checksum 0xa5607269, Offset: 0x2a43
// Size: 0x7, Type: bool
function function_325b5e18c053a0a6()
{
    return !isbrgamemode();
}

// Namespace accolades
// Params 0
// Checksum 0xcd28d87, Offset: 0x2a53
// Size: 0xc, Type: bool
function arekillstreaksallowed()
{
    return istrue( level.allowkillstreaks );
}

// Namespace accolades
// Params 0
// Checksum 0x502ccf48, Offset: 0x2a68
// Size: 0xc, Type: bool
function arefieldupgradesallowed()
{
    return istrue( level.allowsupers );
}

// Namespace accolades
// Params 0
// Checksum 0x2608a737, Offset: 0x2a7d
// Size: 0x42
function isobjectivegametype()
{
    if ( isbrgamemode() )
    {
        return 0;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_7485fa6c474ec865":
        case #"hash_fa0ed9f6bd4f4e9a":
            return 0;
        default:
            return 1;
    }
}

// Namespace accolades
// Params 0
// Checksum 0x8b0998f6, Offset: 0x2ac7
// Size: 0x8
function isbombgametype()
{
    return gameobjects::isbombmode();
}

// Namespace accolades
// Params 0
// Checksum 0x45d51c2a, Offset: 0x2ad8
// Size: 0x45
function iscarrygametype()
{
    if ( gameobjects::isbombmode() )
    {
        return 1;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_1a5d186c17c00d3c":
        case #"hash_3a17de6e294210d2":
            return 1;
        default:
            return 0;
    }
}

// Namespace accolades
// Params 0
// Checksum 0x7054f891, Offset: 0x2b25
// Size: 0xb1
function iscapturegametype()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_2f5af599c5c220d3":
        case #"hash_53825b446469ac4c":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_6efb0f59a62300fb":
        case #"hash_7f9c384a34cc392f":
        case #"hash_cf3000550ee7e8b3":
        case #"hash_dd5b900f435d3f36":
        case #"hash_ec24570718a340f5":
        case #"hash_ec72fd25bbbac99e":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa34c5f6bd6d4432":
            return 1;
        default:
            return 0;
    }
}

// Namespace accolades
// Params 0
// Checksum 0xdc735aac, Offset: 0x2bde
// Size: 0xe, Type: bool
function isctf()
{
    return game_utility::getgametype() == "ctf";
}

// Namespace accolades
// Params 0
// Checksum 0xaafd05f3, Offset: 0x2bf5
// Size: 0xc, Type: bool
function isspawnselectionenabled()
{
    return istrue( level.usespawnselection );
}

// Namespace accolades
// Params 0
// Checksum 0x6ac13e9a, Offset: 0x2c0a
// Size: 0x8
function aretagsenabled()
{
    return obj_dogtag::dogtagsenabled();
}

// Namespace accolades
// Params 0
// Checksum 0x97085d59, Offset: 0x2c1b
// Size: 0xe, Type: bool
function isgrind()
{
    return game_utility::getgametype() == "grind";
}

// Namespace accolades
// Params 0
// Checksum 0x1f85dada, Offset: 0x2c32
// Size: 0x8
function isinfected()
{
    return game_utility::isinfectedgametype();
}

// Namespace accolades
// Params 0
// Checksum 0xbe8e0319, Offset: 0x2c43
// Size: 0xe, Type: bool
function isgungame()
{
    return game_utility::getgametype() == "gun";
}

// Namespace accolades
// Params 0
// Checksum 0xc9d935f2, Offset: 0x2c5a
// Size: 0x51
function ishardpoint()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_6efb0f59a62300fb":
        case #"hash_cf3000550ee7e8b3":
        case #"hash_dd5b900f435d3f36":
        case #"hash_ec72fd25bbbac99e":
            return 1;
        default:
            return 0;
    }
}

// Namespace accolades
// Params 0
// Checksum 0x12751269, Offset: 0x2cb3
// Size: 0x10
function arevehiclesenabled()
{
    return getmatchrulesdata( "commonOption", "allowVehicles" );
}

// Namespace accolades
// Params 1
// Checksum 0xec1963c5, Offset: 0x2ccc
// Size: 0x61
function scoreminimum( ref )
{
    assert( level.accolades[ ref ].datapoints.size == 1, "<dev string:x120>" + ref + "<dev string:x12e>" );
    return self.pers[ level.accolades[ ref ].datapoints[ 0 ] ] * -1;
}

// Namespace accolades
// Params 1
// Checksum 0x12b3354e, Offset: 0x2d36
// Size: 0x3b
function nokillswithdeath_evaluate( ref )
{
    return self.pers[ "kills" ] == 0 && self.pers[ "deaths" ] > 0 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0x38112d63, Offset: 0x2d7a
// Size: 0x3b
function nokillnodeath_evaluate( ref )
{
    return self.pers[ "kills" ] == 0 && self.pers[ "deaths" ] == 0 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0xfad2b52b, Offset: 0x2dbe
// Size: 0x3c
function nokill10deaths_evaluate( ref )
{
    return self.pers[ "kills" ] == 0 && self.pers[ "deaths" ] >= 10 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0x71821c2c, Offset: 0x2e03
// Size: 0x6f
function mostkillsleastdeaths_evaluate( ref )
{
    check1 = arraycontains( level.accolades[ "mostKills" ].winners, self );
    check2 = arraycontains( level.accolades[ "leastDeaths" ].winners, self );
    return check1 && check2 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0xb3823829, Offset: 0x2e7b
// Size: 0x6f
function mostkillsmostheadshots_evaluate( ref )
{
    check1 = arraycontains( level.accolades[ "mostKills" ].winners, self );
    check2 = arraycontains( level.accolades[ "headshots" ].winners, self );
    return check1 && check2 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0xa8a0d8d8, Offset: 0x2ef3
// Size: 0x6f
function mostkillslongeststreak_evaluate( ref )
{
    check1 = arraycontains( level.accolades[ "mostKills" ].winners, self );
    check2 = arraycontains( level.accolades[ "longestStreak" ].winners, self );
    return check1 && check2 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0x7aa417f4, Offset: 0x2f6b
// Size: 0x3c
function kills10nodeaths_evaluate( ref )
{
    return self.pers[ "kills" ] >= 10 && self.pers[ "deaths" ] == 0 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0xa5d001c, Offset: 0x2fb0
// Size: 0x35
function nodeathsfrombehind_evaluate( ref )
{
    return isdefined( self.pers ) && self.pers[ "deathsFromBehind" ] == 10 ? 1 : 0;
}

// Namespace accolades
// Params 1
// Checksum 0xa787b144, Offset: 0x2fee
// Size: 0x42
function highestavgaltitude_evaluate( ref )
{
    averageAltitudeCount = self.pers[ "averageAltitudeCount" ];
    
    if ( averageAltitudeCount > 0 )
    {
        return ( self.pers[ "averageAltitude" ] / averageAltitudeCount );
    }
    
    return 0;
}

// Namespace accolades
// Params 1
// Checksum 0x61a39f5e, Offset: 0x3039
// Size: 0x17
function lowestavgaltitude_evaluate( ref )
{
    return highestavgaltitude_evaluate( ref ) * -1;
}

