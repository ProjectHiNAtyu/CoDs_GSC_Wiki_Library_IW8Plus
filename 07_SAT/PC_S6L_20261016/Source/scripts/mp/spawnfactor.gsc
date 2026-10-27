// scripts\mp\spawnfactor.gsc  (hash_4590a825a33e1804.gscc) (size: 24672 Bytes / 0x6060 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x212e0f30 (556666672)
// size ...... 24672 (0x6060)
// includes .. 12  (offset: 0x5b38)
// strings ... 75  (offset: 0x5b98)
// dev strs .. 10  (offset: 0x5fd4)
// exports ... 80  (offset: 0x42dc)
// cseg ...... 0x6bc + 0x3c20 (0x42dc)
// imports ... 86  (offset: 0x4f5c)
// animtree1 . 0   (offset: 0x6060)
// animtree2 . 0   (offset: 0x6060)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\spawn_frontline;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;

#namespace spawnfactor;

// Namespace spawnfactor
// Params 0
// Checksum 0xcfc6bf04, Offset: 0x6da
// Size: 0x385
function init_spawn_factors()
{
    if ( !isdefined( level.spawn_closeenemydistsq ) )
    {
        level.spawn_closeenemydistsq = 250000;
    }
    
    if ( !isdefined( level.enemyspawninfluencedistsq ) )
    {
        level.enemyspawninfluencedistsq = 810000;
    }
    
    registerfactor( "preferOptimalTTLOS", undefined, 0, undefined );
    registerfactor( "avoidShortTimeToEnemySight", undefined, 0, undefined );
    registerfactor( "preferAlliesByDistance", undefined, 0, undefined );
    registerfactor( "preferCloseToAlly", undefined, 0, undefined );
    registerfactor( "avoidRecentlyUsedByEnemies", undefined, 0, undefined );
    registerfactor( "avoidEnemiesByDistance", undefined, 0, undefined );
    registerfactor( "avoidEnemyInfluence", undefined, 0, undefined );
    registerfactor( "avoidLastDeathLocation", undefined, 0, undefined );
    registerfactor( "avoidLastAttackerLocation", undefined, 0, undefined );
    registerfactor( "avoidShortTimeToJumpingEnemySight", undefined, 0, undefined );
    registerfactor( "avoidVeryShortTimeToJumpingEnemySight", undefined, 0, undefined );
    registerfactor( "avoidSameSpawn", undefined, 0, undefined );
    registerfactor( "avoidRecentlyUsedByAnyone", undefined, 0, undefined );
    registerfactor( "avoidUsedByAnyoneEver", undefined, 0, undefined );
    registerfactor( "randomSpawnScore", undefined, 0, undefined );
    registerfactor( "preferNearLastTeamSpawn", undefined, 0, undefined );
    registerfactor( "preferNearGroupsOfTeamMates", undefined, 0, undefined );
    registerfactor( "avoidClosestEnemy", undefined, 0, undefined );
    registerfactor( "scriptOnlyTest", &scriptonlytest, 1, [ "test" ] );
    registerfactor( "avoidClosestEnemyByDistance", &avoidclosestenemybydistance, 1, [ "closestEnemyInfluenceDistSq" ] );
    registerfactor( "preferNearSinglePoint", &prefernearsinglepoint, 1, [ "singlePointPos", "minDistToSinglePointSq", "maxDistToSinglePointSq", "distRangeToSinglePointSq" ] );
    registerfactor( "avoidCurrentSpawnTraps", &avoidcurrentspawntraps, 1, undefined );
    registerfactor( "preferDomPoints", &preferdompoints, 1, [ "preferredDomPoints", "secondaryDomPoints" ] );
    registerfactor( "preferShortestDistToZone", &prefershortestdisttozone, 1, [ #"hash_6eb7aa82908790d4", #"hash_ff12ea926c094dde" ] );
    registerfactor( "avoidCloseToZone", &avoidclosetozone, 1, [ #"hash_6eb7aa82908790d4", #"zonedeadzonedistsq" ] );
    registerfactor( "preferClosePoints", &preferclosepoints, 1, [ "closestPoints" ] );
    registerfactor( "avoidRugbyOffsides", &avoidrugbyoffsides, 1, [ "juggPos", "rugbyFieldDir2D" ] );
    registerfactor( "oneUseSpawns", &oneusespawns, 1, undefined );
    registerfactor( "avoidCloseToDefenderFlag", &avoidclosetodefenderflag, 1, [ "activeCarrierPosition", "defenderFlagPosition", "avoidDefenderFlagDeadZoneDistSq" ] );
    registerfactor( "avoidCloseToDefenderFlagSpawn", &avoidclosetodefenderflagspawn, 1, [ "avoidDefenderFlagDeadZoneDistSq" ] );
    registerfactor( "avoidFrontlineOffsides", &avoidfrontlineoffsides, 1, undefined );
    registerfactor( "preferOptimalFrontlineDist", &preferoptimalfrontlinedist, 1, undefined );
    registerfactor( "preferUnoccupiedLanes", &preferunoccupiedlanes, 1, undefined );
    registerfactor( "sprintChooseStartSpawn", &sprintChooseStartSpawn, 1, undefined );
    initfrontline();
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"player_damaged", &on_player_damaged );
    callback::add( #"player_death", &on_player_death );
}

// Namespace spawnfactor
// Params 0
// Checksum 0x456a7e67, Offset: 0xa67
// Size: 0x6e
function init_critical_factors()
{
    function_cb21aef74637c075( "avoidCloseEnemies" );
    function_cb21aef74637c075( "avoidCornerVisibleEnemies" );
    function_cb21aef74637c075( "avoidEnemySpawn" );
    function_cb21aef74637c075( "avoidFullVisibleEnemies" );
    function_cb21aef74637c075( "avoidTelefrag" );
    function_cb21aef74637c075( "considerInfluencePoints" );
    function_cb21aef74637c075( "respectFrontline" );
    function_cb21aef74637c075( "avoidSpawnTrap" );
    function_cb21aef74637c075( "scriptCriticalFactor" );
}

// Namespace spawnfactor
// Params 1
// Checksum 0xede4027f, Offset: 0xadd
// Size: 0x5e, Type: bool
function usingfactor( factorname )
{
    if ( function_42b0c947e4ef8f6e( factorname ) )
    {
        return true;
    }
    
    if ( !function_42b0c947e4ef8f6e( "script" ) )
    {
        return false;
    }
    
    if ( level.spawnglobals.factors[ factorname ] && level.spawnglobals.activescriptfactors[ factorname ] )
    {
        return true;
    }
    
    return false;
}

// Namespace spawnfactor
// Params 4
// Checksum 0x19519477, Offset: 0xb44
// Size: 0xc3
function registerfactor( factorname, factorfunction, isscriptonly, paramreflist )
{
    if ( !isdefined( level.spawnglobals.factors ) )
    {
        level.spawnglobals.factors = [];
    }
    
    assert( !isfactorregistered( factorname ), "<dev string:x24>" + factorname + "<dev string:x51>" );
    factorinfo = spawnstruct();
    level.spawnglobals.factors[ factorname ] = factorinfo;
    factorinfo.function = factorfunction;
    factorinfo.paramreflist = paramreflist;
    factorinfo.isscriptonly = isscriptonly;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xf648e9df, Offset: 0xc0f
// Size: 0x6f
function function_cb21aef74637c075( factorname )
{
    if ( !isdefined( level.spawnglobals.criticalfactors ) )
    {
        level.spawnglobals.criticalfactors = [];
    }
    
    assert( !function_23289b73822af6f4( factorname ), "<dev string:x53>" + factorname + "<dev string:x51>" );
    level.spawnglobals.criticalfactors[ factorname ] = 1;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x21bc0bc, Offset: 0xc86
// Size: 0x23, Type: bool
function isfactorregistered( factorname )
{
    return isdefined( level.spawnglobals.factors[ factorname ] );
}

// Namespace spawnfactor
// Params 1
// Checksum 0xae8beb9b, Offset: 0xcb2
// Size: 0x23, Type: bool
function function_23289b73822af6f4( factorname )
{
    return isdefined( level.spawnglobals.criticalfactors[ factorname ] );
}

// Namespace spawnfactor
// Params 1
// Checksum 0x12b9d098, Offset: 0xcde
// Size: 0x4a
function isfactorscriptonly( factorname )
{
    assert( isfactorregistered( factorname ), "<dev string:x89>" + factorname + "<dev string:x51>" );
    return level.spawnglobals.factors[ factorname ].isscriptonly;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xa7f2ebe9, Offset: 0xd31
// Size: 0x4a
function getfactorfunction( factorname )
{
    assert( isfactorregistered( factorname ), "<dev string:xc0>" + factorname + "<dev string:x51>" );
    return level.spawnglobals.factors[ factorname ].function;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xe5e5ffd0, Offset: 0xd84
// Size: 0x4a
function getfactorparamreflist( factorname )
{
    assert( isfactorregistered( factorname ), "<dev string:xf6>" + factorname + "<dev string:x51>" );
    return level.spawnglobals.factors[ factorname ].paramreflist;
}

// Namespace spawnfactor
// Params 3
// Checksum 0x92888ce, Offset: 0xdd7
// Size: 0x262
function calculatefactorscore( spawnpoint, factorname, weight )
{
    if ( !isfactorregistered( factorname ) )
    {
        return 0;
    }
    
    factorfunction = getfactorfunction( factorname );
    factorparamreflist = getfactorparamreflist( factorname );
    spawncontext = level.spawnglobals.activespawncontext;
    
    if ( isdefined( factorparamreflist ) )
    {
        if ( !isdefined( spawncontext.factorparams ) )
        {
            assertmsg( "<dev string:x130>" + factorname + "<dev string:x13f>" );
        }
        
        /#
            outputparams = [];
            
            foreach ( paramref in factorparamreflist )
            {
                foreach ( var_a121ee91cf88efb0, var_1c0f804a6a7799f4 in spawncontext.factorparams )
                {
                    if ( var_a121ee91cf88efb0 == paramref )
                    {
                        outputparams[ paramref ] = var_1c0f804a6a7799f4;
                        break;
                    }
                }
                
                assert( isdefined( outputparams[ paramref ] ), "<dev string:x130>" + factorname + "<dev string:x186>" + paramref + "<dev string:x1a4>" );
            }
        #/
    }
    
    score = [[ factorfunction ]]( spawnpoint );
    score = clamp( score, 0, 100 );
    score *= weight;
    spawnpoint.totalpossiblescore += 100 * weight;
    spawnpoint.lastscore[ self.team ] += score;
    spawnpoint.totalscore += score;
    
    /#
        spawnpoint.debugscoredata[ factorname ] = score;
        spawnpoint.var_5e99fe457d74f39d[ factorname ] = 100 * weight;
    #/
    
    return score;
}

// Namespace spawnfactor
// Params 2
// Checksum 0x4dac2f52, Offset: 0x1042
// Size: 0x60
function critical_factor( var_2c72b6219ece7772, spawnpoint )
{
    scorefactor = [[ var_2c72b6219ece7772 ]]( spawnpoint );
    scorefactor = clamp( scorefactor, 0, 100 );
    
    /#
        if ( isdefined( spawnpoint.var_5618820f8f5487f4 ) )
        {
            spawnpoint.var_5618820f8f5487f4[ spawnpoint.var_5618820f8f5487f4.size ] = scorefactor;
        }
    #/
    
    return scorefactor;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x1b6d7ddc, Offset: 0x10ab
// Size: 0xab
function avoidcarepackages( spawnpoint )
{
    foreach ( carepackage in level.carepackages )
    {
        if ( !isdefined( carepackage ) )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, carepackage.origin ) < 22500 )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x23743905, Offset: 0x115f
// Size: 0x157
function avoidbradleys( spawnpoint )
{
    if ( isdefined( level.bradley ) )
    {
        foreach ( bradley in level.bradley.activevehicles[ "total" ] )
        {
            if ( distancesquared( spawnpoint.origin, bradley.origin ) < 50625 )
            {
                return 0;
            }
        }
        
        foreach ( bradley in level.bradley.inactivevehicles[ "total" ] )
        {
            if ( distancesquared( spawnpoint.origin, bradley.origin ) < 50625 )
            {
                return 0;
            }
        }
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xaefc3211, Offset: 0x12bf
// Size: 0xca
function function_234c5bb0b629ba36( spawnpoint )
{
    foreach ( grenade in level.grenades )
    {
        if ( !isdefined( grenade ) || !grenade isexplosivedangeroustoplayer( self ) || grenade.shouldnotblockspawns )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, grenade.origin ) < 122500 )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xe00bd028, Offset: 0x1392
// Size: 0xf3
function function_1346227861145279( spawnpoint )
{
    explosivearray = weapon::function_3aafcaf7ff6dea9e();
    
    if ( level.traps.size > 0 )
    {
        explosivearray = arraycombine( explosivearray, level.traps );
    }
    
    foreach ( explosive in explosivearray )
    {
        if ( !isdefined( explosive ) || !explosive isexplosivedangeroustoplayer( self ) || explosive.shouldnotblockspawns )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, explosive.origin ) < 122500 )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xf4fd5030, Offset: 0x148e
// Size: 0x99
function isexplosivedangeroustoplayer( player )
{
    if ( !level.teambased || level.friendlyfire || !isdefined( player.team ) )
    {
        return 1;
    }
    
    explosiveteam = undefined;
    
    if ( isdefined( self.owner ) )
    {
        if ( player == self.owner )
        {
            return 1;
        }
        
        explosiveteam = self.owner.team;
    }
    
    if ( isdefined( explosiveteam ) )
    {
        return ( explosiveteam != player.team );
    }
    
    return 1;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x41763b9d, Offset: 0x152f
// Size: 0x67
function function_ee2557d42e1f1f2a( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    
    if ( spawnpoint.cornersights[ enemyteam ] > 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x75474146, Offset: 0x159f
// Size: 0x67
function function_9458c22d717552de( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    
    if ( spawnpoint.fullsights[ enemyteam ] > 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x2c478d1a, Offset: 0x160f
// Size: 0x171
function function_e48a260b1ebcccf( spawnpoint )
{
    enemyteams = [];
    var_9d6911866fea5d9e = [];
    assert( spawnpoint.hasdistdata );
    
    if ( level.teambased )
    {
        enemyteams[ 0 ] = team_utility::getotherteam( self.team );
    }
    else
    {
        enemyteams[ enemyteams.size ] = "all";
    }
    
    foreach ( enemyteam in enemyteams )
    {
        if ( spawnpoint.totalplayers[ enemyteam ] == 0 )
        {
            continue;
        }
        
        var_9d6911866fea5d9e[ var_9d6911866fea5d9e.size ] = enemyteam;
    }
    
    if ( var_9d6911866fea5d9e.size == 0 )
    {
        return 100;
    }
    
    foreach ( enemyteam in var_9d6911866fea5d9e )
    {
        if ( spawnpoint.mindistsquared[ enemyteam ] < level.spawn_closeenemydistsq )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x8bb99085, Offset: 0x1789
// Size: 0xe
function avoidtelefrag( spawnpoint )
{
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x7248868d, Offset: 0x17a0
// Size: 0x1f
function avoidsamespawn_legacy( spawnpoint )
{
    if ( self.lastspawnpoint == spawnpoint )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xbc4f9be0, Offset: 0x17c8
// Size: 0x78
function function_165bd49158282462( spawnpoint )
{
    if ( isdefined( self.team ) && isdefined( spawnpoint.lastspawnteam ) && ( !level.teambased || spawnpoint.lastspawnteam != self.team ) )
    {
        allowspawntime = spawnpoint.lastspawntime + 500;
        
        if ( gettime() < allowspawntime )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x2a7bde76, Offset: 0x1849
// Size: 0xae
function function_10012afeff57529( spawnpoint )
{
    var_3ef4bfd7b0bd4f85 = !level.teambased || isdefined( spawnpoint.lastspawnteam ) && self.team != spawnpoint.lastspawnteam;
    
    if ( var_3ef4bfd7b0bd4f85 && isdefined( spawnpoint.lastspawntime ) )
    {
        timepassed = gettime() - spawnpoint.lastspawntime;
        spawnpoint.analytics.spawnusedbyenemies = timepassed / 1000;
        
        if ( timepassed > 4000 )
        {
            return 100;
        }
        
        return ( timepassed / 4000 * 100 );
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x1225455c, Offset: 0x1900
// Size: 0x6b
function function_f68fd668ccedd2bd( spawnpoint )
{
    if ( isdefined( spawnpoint.lastspawntime ) )
    {
        timepassed = gettime() - spawnpoint.lastspawntime;
        spawnpoint.analytics.timesincelastspawn = timepassed / 1000;
        
        if ( timepassed > 4000 )
        {
            return 100;
        }
        
        return ( timepassed / 4000 * 100 );
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 0
// Checksum 0xe9e9944d, Offset: 0x1974
// Size: 0x4
function function_f376cffbb98b7981()
{
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xf41b260e, Offset: 0x1981
// Size: 0x66
function function_a3aa0235fbe6aef6( spawnpoint )
{
    if ( !isdefined( self.lastdeathpos ) )
    {
        return 100;
    }
    
    distsq = distancesquared( spawnpoint.origin, self.lastdeathpos );
    
    if ( distsq > 810000 )
    {
        return 100;
    }
    
    percentdist = distsq / 810000;
    return percentdist * 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x38a52faf, Offset: 0x19f0
// Size: 0x9d
function function_788836b5b732bbcf( spawnpoint )
{
    if ( !( isdefined( self.lastattacker ) && isdefined( self.lastattacker.origin ) ) )
    {
        return 100;
    }
    
    if ( !player::isreallyalive( self.lastattacker ) )
    {
        return 100;
    }
    
    distsq = distancesquared( spawnpoint.origin, self.lastattacker.origin );
    
    if ( distsq > 810000 )
    {
        return 100;
    }
    
    percentdist = distsq / 810000;
    return percentdist * 100;
}

// Namespace spawnfactor
// Params 0
// Checksum 0x53fa6eb2, Offset: 0x1a96
// Size: 0x360
function initfrontline()
{
    frontlineinfo = getglobalfrontlineinfo();
    
    if ( getdvarint( @"scr_ignore_frontline_anchor", 0 ) == 1 )
    {
        return;
    }
    
    anchorents = [];
    yaw = getdvarfloat( @"scr_frontline_heading", -1 );
    
    if ( yaw != -1 )
    {
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( ( 0, yaw, 0 ) );
        frontlineinfo.anchorrt = anglestoright( ( 0, yaw, 0 ) );
        
        if ( isdefined( level.mapcenter ) )
        {
            frontlineinfo.primaryanchorpos = ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], 0 );
        }
        else
        {
            frontlineinfo.primaryanchorpos = ( 0, 0, 0 );
        }
        
        return;
    }
    
    if ( level.testtdmanywhere )
    {
        y = getdvarfloat( @"hash_aa7892bb1de8f27d", randomfloatrange( 0, 359 ) );
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( ( 0, y, 0 ) );
        frontlineinfo.anchorrt = anglestoright( ( 0, y, 0 ) );
        frontlineinfo.heading = y;
        
        if ( isdefined( level.mapcenter ) )
        {
            frontlineinfo.primaryanchorpos = ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], 0 );
        }
        
        level.tdmanywherefrontline = frontlineinfo;
        return;
    }
    
    anchorents = getentarray( "mp_frontline_anchor", #classname );
    
    if ( isdefined( game_utility::getlocaleid() ) )
    {
        filteredents = [];
        
        foreach ( ent in anchorents )
        {
            if ( ent.script_noteworthy == level.localeid )
            {
                filteredents[ filteredents.size ] = ent;
                continue;
            }
            
            ent delete();
        }
        
        anchorents = filteredents;
    }
    else if ( anchorents.size != 1 )
    {
        var_4e79fe74a31fd6fa = [];
        
        foreach ( ent in anchorents )
        {
            if ( !isdefined( ent.script_noteworthy ) || !issubstr( ent.script_noteworthy, "locale" ) )
            {
                var_4e79fe74a31fd6fa[ var_4e79fe74a31fd6fa.size ] = ent;
                continue;
            }
            
            ent delete();
        }
        
        anchorents = var_4e79fe74a31fd6fa;
    }
    
    if ( anchorents.size != 0 )
    {
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( anchorents[ 0 ].angles );
        frontlineinfo.primaryanchorpos = ( anchorents[ 0 ].origin[ 0 ], anchorents[ 0 ].origin[ 1 ], 0 );
    }
}

// Namespace spawnfactor
// Params 1
// Checksum 0x99fc54cd, Offset: 0x1dfe
// Size: 0x27
function updatefrontline( team )
{
    if ( !updatefrontlineposition() )
    {
        return;
    }
    
    runfrontlinespawntrapchecks( team );
    updatefrontlinedebug();
}

// Namespace spawnfactor
// Params 0
// Checksum 0x159b997, Offset: 0x1e2d
// Size: 0x3ff, Type: bool
function updatefrontlineposition()
{
    if ( !currentspawnlogicsupportsfrontline() )
    {
        return false;
    }
    
    frontlineinfo = getglobalfrontlineinfo();
    curtime = gettime();
    
    if ( !isdefined( frontlineinfo.lastupdatetime ) )
    {
        frontlineinfo.lastupdatetime = curtime;
    }
    else if ( frontlineinfo.isactive[ "allies" ] && frontlineinfo.isactive[ "axis" ] )
    {
        frontlineinfo.uptime += frontlineinfo.lastupdatetimedelta;
    }
    else
    {
        frontlineinfo.downtime += frontlineinfo.lastupdatetimedelta;
    }
    
    updatetimedelta = ( curtime - frontlineinfo.lastupdatetime ) / 1000;
    frontlineinfo.lastupdatetime = curtime;
    frontlineinfo.lastupdatetimedelta = updatetimedelta;
    alliesaverage = getfrontlineteamcenter( "allies" );
    
    if ( !isdefined( alliesaverage ) )
    {
        return false;
    }
    
    alliesaverage = ( alliesaverage[ 0 ], alliesaverage[ 1 ], 0 );
    frontlineinfo.alliesaverage = alliesaverage;
    axisaverage = getfrontlineteamcenter( "axis" );
    
    if ( !isdefined( axisaverage ) )
    {
        return false;
    }
    
    axisaverage = ( axisaverage[ 0 ], axisaverage[ 1 ], 0 );
    frontlineinfo.axisaverage = axisaverage;
    
    if ( frontlineinfo.usinganchors )
    {
        var_decdb762f39cfc6f = alliesaverage - frontlineinfo.primaryanchorpos;
        var_c3fb6b84f4685978 = vectordot( frontlineinfo.anchordir, var_decdb762f39cfc6f );
        projectedalliescenter = frontlineinfo.anchordir * var_c3fb6b84f4685978 + frontlineinfo.primaryanchorpos;
        frontlineinfo.projectedalliescenter = projectedalliescenter;
        var_decdb762f39cfc6f = axisaverage - frontlineinfo.primaryanchorpos;
        var_105e340f626528a7 = vectordot( frontlineinfo.anchordir, var_decdb762f39cfc6f );
        projectedaxiscenter = frontlineinfo.anchordir * var_105e340f626528a7 + frontlineinfo.primaryanchorpos;
        frontlineinfo.projectedaxiscenter = projectedaxiscenter;
        centerseparation = abs( var_c3fb6b84f4685978 - var_105e340f626528a7 );
        
        if ( centerseparation < 600 && isdefined( frontlineinfo.teamdiffyaw ) )
        {
            frontlineinfo.contested = 1;
        }
        else
        {
            frontlineinfo.contested = 0;
            frontlineinfo.midpoint = projectedalliescenter + ( projectedaxiscenter - projectedalliescenter ) * 0.5;
            frontlinedir = projectedaxiscenter - projectedalliescenter;
            frontlineinfo.teamdiffyaw = vectortoyaw( frontlinedir );
        }
    }
    else
    {
        var_df23d19af242b179 = axisaverage - alliesaverage;
        var_5d921b9e5b44792c = vectortoyaw( var_df23d19af242b179 );
        frontlineinfo.teamdiffyaw = var_5d921b9e5b44792c;
        idealmidpoint = alliesaverage + var_df23d19af242b179 * 0.5;
        frontlineinfo.midpoint = idealmidpoint;
    }
    
    var_3c1518abbacd8dd5 = anglestoforward( ( 0, frontlineinfo.teamdiffyaw, 0 ) );
    spawnpoints = level.spawnpoints;
    spawnpoints = spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        var_a58550be32fe100 = frontlineinfo.midpoint - spawnpoint.origin;
        dotvalue = vectordot( var_a58550be32fe100, var_3c1518abbacd8dd5 );
        spawnpoint.frontlineteam = dotvalue > 0 ? "allies" : "axis";
    }
    
    return true;
}

// Namespace spawnfactor
// Params 0
// Checksum 0x3701a5c6, Offset: 0x2235
// Size: 0x241
function updatefrontlinedebug()
{
    matchrecordingenabled = isdefined( level.matchrecording_logevent ) && isdefined( level.matchrecording_generateid );
    
    if ( !matchrecordingenabled && !( level.var_dc61a9eb0da4d624 ?? analyticslog::function_f432eaae9387e0e4() ) )
    {
        return;
    }
    
    frontlineinfo = getglobalfrontlineinfo();
    
    if ( !isdefined( frontlineinfo.logids ) && isdefined( level.matchrecording_generateid ) )
    {
        frontlineinfo.logids = [];
        frontlineinfo.logids[ "alliesCenter" ] = [[ level.matchrecording_generateid ]]();
        frontlineinfo.logids[ "axisCenter" ] = [[ level.matchrecording_generateid ]]();
    }
    
    if ( !frontlineinfo.isactive[ "allies" ] && !frontlineinfo.isactive[ "axis" ] )
    {
        return;
    }
    
    drawmidpoint = ( frontlineinfo.midpoint[ 0 ], frontlineinfo.midpoint[ 1 ], level.mapcenter[ 2 ] );
    var_dd215731ac65a9ba = anglestoright( ( 0, frontlineinfo.teamdiffyaw, 0 ) );
    logfrontlinetomatchrecording( drawmidpoint, var_dd215731ac65a9ba, frontlineinfo.isactive[ "allies" ], frontlineinfo.isactive[ "axis" ] );
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        axisaverage = frontlineinfo.isactive[ "axis" ] ? frontlineinfo.axisaverage : ( 10000, 10000, 10000 );
        [[ level.matchrecording_logevent ]]( frontlineinfo.logids[ "axisCenter" ], "axis", "ANCHOR", axisaverage[ 0 ], axisaverage[ 1 ], gettime() );
        alliesaverage = frontlineinfo.isactive[ "allies" ] ? frontlineinfo.alliesaverage : ( 10000, 10000, 10000 );
        [[ level.matchrecording_logevent ]]( frontlineinfo.logids[ "alliesCenter" ], "allies", "ANCHOR", alliesaverage[ 0 ], alliesaverage[ 1 ], gettime() );
    }
}

// Namespace spawnfactor
// Params 4
// Checksum 0x689cdd68, Offset: 0x247e
// Size: 0xdd
function logfrontlinetomatchrecording( midpoint, direction, var_a7a46a0d5d37467d, var_598163c56f820c12 )
{
    if ( isdefined( level.matchrecording_logevent ) )
    {
        var_ab0622c6d4fd8421 = midpoint + direction * 5000;
        var_ab061fc6d4fd7d88 = midpoint - direction * 5000;
        
        if ( !isdefined( level.matchrecording_frontlinelogid ) )
        {
            level.matchrecording_frontlinelogid = [[ level.matchrecording_generateid ]]();
        }
        
        frontlinetag = undefined;
        
        if ( var_a7a46a0d5d37467d && var_598163c56f820c12 )
        {
            frontlinetag = "FRONT_LINE";
        }
        else
        {
            frontlinetag = var_a7a46a0d5d37467d ? "FRONT_LINE_ALLIES" : "FRONT_LINE_AXIS";
        }
        
        [[ level.matchrecording_logevent ]]( level.matchrecording_frontlinelogid, "allies", frontlinetag, var_ab0622c6d4fd8421[ 0 ], var_ab0622c6d4fd8421[ 1 ], gettime(), undefined, var_ab061fc6d4fd7d88[ 0 ], var_ab061fc6d4fd7d88[ 1 ] );
    }
}

// Namespace spawnfactor
// Params 1
// Checksum 0x64f147dd, Offset: 0x2563
// Size: 0xe9
function getfrontlineteamcenter( team )
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !player val::get( "player_for_spawn_logic" ) )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            players[ players.size ] = player;
        }
    }
    
    if ( players.size == 0 )
    {
        return;
    }
    
    playersorigin = entity::getaverageorigin( players );
    return playersorigin;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xb6cab909, Offset: 0x2655
// Size: 0x1d1
function runfrontlinespawntrapchecks( team )
{
    if ( !currentspawnlogicsupportsfrontline() )
    {
        return;
    }
    
    frontlineinfo = getglobalfrontlineinfo();
    frontlineinfo.isactive[ team ] = 1;
    
    if ( getdvarint( @"scr_frontline_trap_checks" ) == 0 )
    {
        return;
    }
    
    var_5f8d34040d7bd46e = getdvarint( @"scr_frontline_min_spawns", 0 );
    
    if ( var_5f8d34040d7bd46e == 0 )
    {
        var_5f8d34040d7bd46e = 4;
    }
    
    enemyteam = team_utility::getotherteam( team );
    var_8c23b45408598395 = 0;
    spawnpoints = level.spawnpoints;
    spawnpoints = spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( spawnpoint.frontlineteam != team )
        {
            continue;
        }
        
        assert( spawnpoint.hassightdata[ enemyteam ] );
        
        if ( !( isdefined( spawnpoint.fullsights ) && isdefined( spawnpoint.fullsights[ enemyteam ] ) ) || spawnpoint.fullsights[ enemyteam ] <= 0 )
        {
            var_8c23b45408598395++;
        }
    }
    
    var_85c28d4a78ca88ca = var_8c23b45408598395 / spawnpoints.size;
    
    if ( var_8c23b45408598395 < var_5f8d34040d7bd46e || var_85c28d4a78ca88ca < 0 )
    {
        if ( var_8c23b45408598395 < var_5f8d34040d7bd46e )
        {
            frontlineinfo.disabledreason[ team ] = 0;
        }
        else
        {
            frontlineinfo.disabledreason[ team ] = 1;
        }
        
        frontlineinfo.isactive[ team ] = 0;
    }
}

// Namespace spawnfactor
// Params 0
// Checksum 0xc0ab45a5, Offset: 0x282e
// Size: 0x2a, Type: bool
function currentspawnlogicsupportsfrontline()
{
    return istrue( level.spawnglobals.frontlinelogictypes[ level.spawnglobals.activespawnlogic ] );
}

// Namespace spawnfactor
// Params 0
// Checksum 0xfeb4d499, Offset: 0x2861
// Size: 0xcd
function getglobalfrontlineinfo()
{
    if ( !isdefined( level.frontlineinfo ) )
    {
        level.frontlineinfo = spawnstruct();
        level.frontlineinfo.isactive = [];
        level.frontlineinfo.isactive[ "allies" ] = 0;
        level.frontlineinfo.isactive[ "axis" ] = 0;
        level.frontlineinfo.uptime = 0;
        level.frontlineinfo.downtime = 0;
        level.frontlineinfo.contested = 0;
        level.frontlineinfo.usinganchors = 0;
    }
    
    return level.frontlineinfo;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x400b14fa, Offset: 0x2937
// Size: 0xb1
function function_67a121a82ec1b1e( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    
    if ( spawnpoint.totalplayers[ self.team ] == 0 )
    {
        return 0;
    }
    
    allyaveragedist = spawnpoint.distsumsquared[ self.team ] / spawnpoint.totalplayers[ self.team ];
    allyaveragedist = min( allyaveragedist, 3240000 );
    spawnpoint.analytics.allyaveragedist = allyaveragedist;
    scoringpercentage = 1 - allyaveragedist / 3240000;
    return scoringpercentage * 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x227270d2, Offset: 0x29f1
// Size: 0x63
function function_eee743462cd2d99f( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    allydist = min( spawnpoint.mindistsquared[ self.team ], 3240000 );
    scoringpercentage = 1 - allydist / 3240000;
    return scoringpercentage * 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xa2e0d532, Offset: 0x2a5d
// Size: 0x24e
function function_a2ac78d23092349f( spawnpoint )
{
    enemyteams = [];
    var_9d6911866fea5d9e = [];
    assert( spawnpoint.hasdistdata );
    
    if ( level.teambased )
    {
        enemyteams[ 0 ] = team_utility::getotherteam( self.team );
    }
    else
    {
        enemyteams[ enemyteams.size ] = "all";
    }
    
    foreach ( enemyteam in enemyteams )
    {
        if ( spawnpoint.totalplayers[ enemyteam ] == 0 )
        {
            continue;
        }
        
        var_9d6911866fea5d9e[ var_9d6911866fea5d9e.size ] = enemyteam;
    }
    
    if ( var_9d6911866fea5d9e.size == 0 )
    {
        return 100;
    }
    
    foreach ( enemyteam in var_9d6911866fea5d9e )
    {
        if ( spawnpoint.mindistsquared[ enemyteam ] < 250000 )
        {
            return 0;
        }
    }
    
    totaldistance = 0;
    totalenemies = 0;
    
    foreach ( enemyteam in var_9d6911866fea5d9e )
    {
        totaldistance += spawnpoint.distsumsquaredcapped[ enemyteam ];
        totalenemies += spawnpoint.totalplayers[ enemyteam ];
    }
    
    var_28c27ff95bcdeaac = totaldistance / totalenemies;
    var_28c27ff95bcdeaac = min( var_28c27ff95bcdeaac, 7290000 );
    scoringpercentage = var_28c27ff95bcdeaac / 7290000;
    spawnpoint.analytics.enemyaveragedist = var_28c27ff95bcdeaac;
    return scoringpercentage * 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x47540534, Offset: 0x2cb4
// Size: 0x72
function function_cff31e8b36062dfa( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    enemyteam = undefined;
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    else
    {
        enemyteam = "all";
    }
    
    if ( spawnpoint.mindistsquared[ enemyteam ] < level.enemyspawninfluencedistsq )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xce67e8c, Offset: 0x2d2f
// Size: 0x1b7
function function_9222a0eb7bde9dc0( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    enemyteams = [];
    var_9d6911866fea5d9e = [];
    
    if ( level.teambased )
    {
        enemyteams[ 0 ] = team_utility::getotherteam( self.team );
    }
    else
    {
        enemyteams[ enemyteams.size ] = "all";
    }
    
    foreach ( enemyteam in enemyteams )
    {
        if ( spawnpoint.totalplayers[ enemyteam ] == 0 )
        {
            continue;
        }
        
        var_9d6911866fea5d9e[ var_9d6911866fea5d9e.size ] = enemyteam;
    }
    
    if ( var_9d6911866fea5d9e.size == 0 )
    {
        return 100;
    }
    
    scoretotal = 0;
    
    foreach ( enemyteam in var_9d6911866fea5d9e )
    {
        if ( spawnpoint.mindistsquared[ enemyteam ] < 250000 )
        {
            return 0;
        }
        
        minenemydistsquared = min( spawnpoint.mindistsquared[ enemyteam ], 3240000 );
        scoringpercentage = minenemydistsquared / 3240000;
        scoretotal += scoringpercentage * 100;
    }
    
    return scoretotal / var_9d6911866fea5d9e.size;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x3fdd2250, Offset: 0x2eef
// Size: 0x14d
function avoidclosestenemybydistance( spawnpoint )
{
    var_421fe949fcd1c649 = level.spawnglobals.activespawncontext.factorparams[ #"closestenemyinfluencedistsq" ];
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    closestdist = 0;
    
    foreach ( enemy in level.teamdata[ enemyteam ][ "players" ] )
    {
        distsq = distancesquared( spawnpoint.origin, enemy.origin );
        
        if ( distsq < closestdist )
        {
            closestdist = distsq;
        }
    }
    
    if ( closestdist < 250000 )
    {
        return 0;
    }
    
    minenemydistsquared = min( closestdist, var_421fe949fcd1c649 );
    scoringpercentage = minenemydistsquared / var_421fe949fcd1c649;
    return scoringpercentage * 100;
}

// Namespace spawnfactor
// Params 2
// Checksum 0x207f234, Offset: 0x3045
// Size: 0x38
function function_6ee12c1c8b06235e( var_a92fbceda7b5d0c3, var_d55b2bd567d86532 )
{
    var_5604c97df7f05c1b = [];
    var_5604c97df7f05c1b[ "preferredDomPoints" ] = var_a92fbceda7b5d0c3;
    var_5604c97df7f05c1b[ "secondaryDomPoints" ] = var_d55b2bd567d86532;
    return var_5604c97df7f05c1b;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x151007f7, Offset: 0x3086
// Size: 0xbb
function preferdompoints( spawnpoint )
{
    preferreddompoints = level.spawnglobals.activespawncontext.factorparams[ "preferredDomPoints" ];
    secondarydompoints = level.spawnglobals.activespawncontext.factorparams[ "secondaryDomPoints" ];
    scriptdata = spawnpoint.scriptdata;
    
    if ( isdefined( scriptdata.domflagassignments ) )
    {
        if ( scriptdata.domflagassignments & preferreddompoints )
        {
            return 100;
        }
        else if ( scriptdata.domflagassignments & secondarydompoints )
        {
            return 50;
        }
    }
    
    return 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xab0846cc, Offset: 0x314a
// Size: 0xad
function preferclosepoints( spawnpoint )
{
    closestpoints = level.spawnglobals.activespawncontext.factorparams[ "closestPoints" ];
    
    foreach ( point in closestpoints )
    {
        if ( spawnpoint == point )
        {
            return 100;
        }
    }
    
    return 0;
}

// Namespace spawnfactor
// Params 2
// Checksum 0xc0658ad3, Offset: 0x3200
// Size: 0x2a
function function_a2156a6b6455e771( spawnpoint, team )
{
    if ( spawnpoint.teambase == team )
    {
        return 100;
    }
    
    return 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x9e1d1b35, Offset: 0x3233
// Size: 0xc1
function function_33865217caa9b6ca( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxsightvalue[ enemyteam ];
    var_e65655ad357ce225 = spawnlogic::getmaxdistancetolos();
    distancetolos = sightfraction * var_e65655ad357ce225;
    
    if ( distancetolos > 1200 )
    {
        scorepercent = ( var_e65655ad357ce225 - distancetolos ) / ( var_e65655ad357ce225 - 1200 );
        return ( 100 * scorepercent );
    }
    
    scorepercent = distancetolos / 1200;
    return 100 * scorepercent;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xb7615e5d, Offset: 0x32fc
// Size: 0x96
function function_cc3f0271f6d938bc( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxsightvalue[ enemyteam ];
    spawnpoint.analytics.maxenemysightfraction = sightfraction;
    return ( 1 - sightfraction ) * 0 + sightfraction * 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x8e7a5ad3, Offset: 0x339b
// Size: 0x96
function function_878fda2d69acf2d6( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxjumpsightvalue[ enemyteam ];
    spawnpoint.analytics.maxjumpingenemysightfraction = sightfraction;
    return ( 1 - sightfraction ) * 0 + sightfraction * 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x8ec02561, Offset: 0x343a
// Size: 0x92
function function_8e6b1934a865f43a( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( self.team );
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxjumpsightvalue[ enemyteam ];
    var_28d1aefb290065b7 = sightfraction * spawnlogic::getmaxdistancetolos();
    
    if ( var_28d1aefb290065b7 < 300 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xc0823890, Offset: 0x34d4
// Size: 0x3e
function randomspawnscore( spawnpoint )
{
    spawnpoint.analytics.randomscore = randomintrange( 0, 99 );
    return spawnpoint.analytics.randomscore;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x528c0d6b, Offset: 0x351b
// Size: 0x11
function maxplayerspawninfluencedistsquared( spawnpoint )
{
    return 3240000;
}

// Namespace spawnfactor
// Params 4
// Checksum 0x34fa0921, Offset: 0x3535
// Size: 0x6e
function function_daea503b73d07eed( zonekey, var_2647c61cc3d3875a, var_5c9c9b4819784ca2, closestenemyinfluencedistsq )
{
    var_5604c97df7f05c1b = [];
    var_5604c97df7f05c1b[ #"hash_6eb7aa82908790d4" ] = zonekey;
    var_5604c97df7f05c1b[ #"hash_ff12ea926c094dde" ] = var_2647c61cc3d3875a;
    var_5604c97df7f05c1b[ #"zonedeadzonedistsq" ] = var_5c9c9b4819784ca2;
    var_5604c97df7f05c1b[ #"closestenemyinfluencedistsq" ] = closestenemyinfluencedistsq;
    return var_5604c97df7f05c1b;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xc45008d2, Offset: 0x35ac
// Size: 0xa6
function prefershortestdisttozone( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    var_cf42cbdac19596ab = spawncontext.factorparams[ #"hash_6eb7aa82908790d4" ];
    distsq = spawnpoint.scriptdata.var_a881d5343a45f1a6[ var_cf42cbdac19596ab ];
    maxdistancesquared = spawncontext.factorparams[ #"hash_ff12ea926c094dde" ];
    percent = 1 - distsq / maxdistancesquared;
    return 100 * percent + 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x43220541, Offset: 0x365b
// Size: 0x98
function avoidclosetozone( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    var_cf42cbdac19596ab = spawncontext.factorparams[ #"hash_6eb7aa82908790d4" ];
    distsq = spawnpoint.scriptdata.var_a881d5343a45f1a6[ var_cf42cbdac19596ab ];
    var_5c9c9b4819784ca2 = spawncontext.factorparams[ #"zonedeadzonedistsq" ];
    return distsq < var_5c9c9b4819784ca2 ? 0 : 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x5d8f5b0e, Offset: 0x36fc
// Size: 0x92
function function_ff378bba0b02d878( spawnpoint )
{
    lastteamspawnpoint = level.spawnglobals.lastteamspawnpoints[ self.team ];
    
    if ( !isdefined( lastteamspawnpoint ) )
    {
        return 0;
    }
    
    distsq = distancesquared( lastteamspawnpoint.origin, spawnpoint.origin );
    distsq = int( min( distsq, 9000000 ) );
    percent = 1 - distsq / 9000000;
    return 100 * percent + 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x1de651d0, Offset: 0x3797
// Size: 0x178
function function_96503a41b2479b4a( spawnpoint )
{
    spawnglobals = level.spawnglobals;
    assert( isdefined( spawnglobals.hasclusterdata ) );
    assert( isdefined( spawnglobals.teamclusters[ self.team ] ) );
    var_7010280b1728a0c6 = -1;
    
    foreach ( cluster in spawnglobals.teamclusters[ self.team ].clusterlist )
    {
        if ( cluster.players.size <= 1 )
        {
            continue;
        }
        
        distsq = distance2dsquared( cluster.center, spawnpoint.origin );
        
        if ( var_7010280b1728a0c6 < 0 || distsq < var_7010280b1728a0c6 )
        {
            var_7010280b1728a0c6 = distsq;
        }
    }
    
    if ( var_7010280b1728a0c6 < 0 )
    {
        return 0;
    }
    
    if ( var_7010280b1728a0c6 < 10000 )
    {
        return 100;
    }
    
    var_7010280b1728a0c6 = int( min( var_7010280b1728a0c6, 9000000 ) );
    percent = 1 - ( var_7010280b1728a0c6 - 10000 ) / 8990000;
    return 100 * percent + 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x62b22c8, Offset: 0x3918
// Size: 0xd, Type: bool
function scriptonlytest( spawnpoint )
{
    return false;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x537d9933, Offset: 0x392e
// Size: 0x2c
function sprintChooseStartSpawn( spawnpoint )
{
    if ( self.coursedifficulty == spawnpoint.script_noteworthy )
    {
        return 100;
    }
    
    return 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x2ef5c93e, Offset: 0x3962
// Size: 0x107
function prefernearsinglepoint( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    pointpos = spawncontext.factorparams[ "singlePointPos" ];
    mindistsq = spawncontext.factorparams[ "minDistToSinglePointSq" ];
    maxdistsq = spawncontext.factorparams[ "maxDistToSinglePointSq" ];
    var_74a785d35d77468f = spawncontext.factorparams[ "distRangeToSinglePointSq" ];
    assert( var_74a785d35d77468f + 0.1 <= maxdistsq - mindistsq && var_74a785d35d77468f - 0.1 >= maxdistsq - mindistsq );
    distsq = distance2dsquared( pointpos, spawnpoint.origin );
    
    if ( distsq >= maxdistsq )
    {
        return 0;
    }
    
    if ( distsq <= mindistsq )
    {
        return 100;
    }
    
    scorepercent = 1 - ( distsq - mindistsq ) / var_74a785d35d77468f;
    return 100 * scorepercent;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x2bea4069, Offset: 0x3a72
// Size: 0x62
function avoidcurrentspawntraps( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    combo = function_d5911f4a65268b10( spawnpoint, spawncontext.team );
    pointratio = pow( 0.25, combo );
    return 100 * pointratio;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xf0ab9ab0, Offset: 0x3add
// Size: 0x23
function function_31211560fea609e4( spawnpoint )
{
    spawnpoint.scriptdata.var_8c520c1d492c59c4 = [];
}

// Namespace spawnfactor
// Params 3
// Checksum 0x5637a4ae, Offset: 0x3b08
// Size: 0xcb
function function_3d2c185018b63696( player, callbackparams, attacker )
{
    if ( !player )
    {
        return;
    }
    
    if ( isdefined( player.var_2fbd1e2a65dc3c11 ) )
    {
        return;
    }
    
    if ( ( isplayer( attacker ) || isagent( attacker ) && isalive( attacker ) ) && !player player_utility::isenemy( attacker ) )
    {
        return;
    }
    
    if ( gettime() - player.lastspawntime > ( level.var_1dca48bea1e01274 ?? function_40efd43fe03633f0() ) )
    {
        return;
    }
    
    if ( isdefined( player.lastspawnpoint ) )
    {
        player.var_2fbd1e2a65dc3c11 = player.lastspawnpoint;
        function_2586c1c5a4c73ac5( player.lastspawnpoint, player.team );
    }
}

// Namespace spawnfactor
// Params 2
// Checksum 0xf4435b64, Offset: 0x3bdb
// Size: 0x12a
function function_2586c1c5a4c73ac5( spawnpoint, team )
{
    currenttimems = gettime();
    
    if ( !level.teambased )
    {
        team = "none";
    }
    
    scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    
    if ( !isdefined( scriptdata.var_8c520c1d492c59c4 ) )
    {
        return;
    }
    
    combostruct = scriptdata.var_8c520c1d492c59c4[ team ] ?? undefined;
    
    if ( !isdefined( combostruct ) )
    {
        combostruct = spawnstruct();
        combostruct.starttimems = currenttimems;
        combostruct.var_da791ba9e5d034b8 = currenttimems;
        combostruct.trapcount = 1;
        scriptdata.var_8c520c1d492c59c4[ team ] = combostruct;
        return;
    }
    
    if ( currenttimems - combostruct.var_da791ba9e5d034b8 > function_a3316d1c3759fc6c() )
    {
        combostruct.starttimems = currenttimems;
        combostruct.trapcount = 1;
    }
    else
    {
        combostruct.trapcount++;
    }
    
    combostruct.var_da791ba9e5d034b8 = currenttimems;
}

// Namespace spawnfactor
// Params 2
// Checksum 0x1c3be48b, Offset: 0x3d0d
// Size: 0xa9
function function_d5911f4a65268b10( spawnpoint, team )
{
    currenttimems = gettime();
    
    if ( !level.teambased )
    {
        team = "none";
    }
    
    scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    combostruct = scriptdata.var_8c520c1d492c59c4[ team ] ?? undefined;
    
    if ( isdefined( combostruct ) )
    {
        if ( currenttimems - combostruct.var_da791ba9e5d034b8 < function_a3316d1c3759fc6c() )
        {
            return combostruct.trapcount;
        }
    }
    
    return 0;
}

// Namespace spawnfactor
// Params 0
// Checksum 0x6e66c19c, Offset: 0x3dbf
// Size: 0x14, Type: bool
function function_b8c457d1ff48b5c8()
{
    return level.var_1dca48bea1e01274 ?? function_40efd43fe03633f0();
}

// Namespace spawnfactor
// Params 0, eflags: 0x4
// Checksum 0xee47b744, Offset: 0x3ddc
// Size: 0x49
function private function_40efd43fe03633f0()
{
    timems = 2000;
    dvaroverride = getdvarfloat( @"hash_851a3f508adcd1dd", -1 );
    
    if ( dvaroverride > 0 )
    {
        timems = dvaroverride * 1000;
    }
    
    level.var_1dca48bea1e01274 = timems;
    return timems;
}

// Namespace spawnfactor
// Params 0
// Checksum 0x9a9b7717, Offset: 0x3e2e
// Size: 0x3e
function function_a3316d1c3759fc6c()
{
    timems = 6000;
    dvaroverride = getdvarfloat( @"hash_3b2062ace30035", -1 );
    
    if ( dvaroverride > 0 )
    {
        timems = dvaroverride * 1000;
    }
    
    return timems;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xb1747b, Offset: 0x3e75
// Size: 0xa3
function avoidrugbyoffsides( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    juggpos = spawncontext.factorparams[ "juggPos" ];
    var_70cca0bffac2893b = spawncontext.factorparams[ "rugbyFieldDir2D" ];
    var_1fc0fa8d23402d75 = ( spawnpoint.origin - juggpos ) * ( 1, 1, 0 );
    dot = vectordot( var_1fc0fa8d23402d75, var_70cca0bffac2893b );
    
    if ( dot >= 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xd7553540, Offset: 0x3f21
// Size: 0x39
function oneusespawns( spawnpoint )
{
    scriptdata = spawnpoint.scriptdata;
    
    if ( scriptdata.used )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 2
// Checksum 0x4752be48, Offset: 0x3f62
// Size: 0xa1
function avoidclosetodefenderflag( spawnpoint, paramlist )
{
    var_76d589e19567fe6d = undefined;
    var_e4b7b818a9d56c2 = paramlist[ "activeCarrierPosition" ];
    var_d977408b3452d2ce = paramlist[ "defenderFlagPosition" ];
    var_5c9c9b4819784ca2 = paramlist[ "avoidDefenderFlagDeadZoneDistSq" ];
    
    if ( isdefined( var_e4b7b818a9d56c2 ) )
    {
        var_76d589e19567fe6d = var_e4b7b818a9d56c2;
    }
    else if ( isdefined( var_d977408b3452d2ce ) )
    {
        var_76d589e19567fe6d = var_d977408b3452d2ce;
    }
    
    if ( isdefined( var_76d589e19567fe6d ) )
    {
        distsquared = distancesquared( var_76d589e19567fe6d, spawnpoint.origin );
        return ( distsquared < var_5c9c9b4819784ca2 ? 0 : 100 );
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 2
// Checksum 0x6fb3f96a, Offset: 0x400b
// Size: 0x54
function avoidclosetodefenderflagspawn( spawnpoint, paramlist )
{
    distsq = spawnpoint.scriptdata.distsqtodefenderfalgstart;
    var_5c9c9b4819784ca2 = paramlist[ "avoidDefenderFlagDeadZoneDistSq" ];
    return distsq < var_5c9c9b4819784ca2 ? 0 : 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x61143c90, Offset: 0x4068
// Size: 0xb9
function avoidfrontlineoffsides( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    
    if ( !( isdefined( spawncontext.factorparams ) && isdefined( level.frontlinedata ) ) )
    {
        return 100;
    }
    
    teamforward = spawncontext.factorparams[ "teamForward" ];
    frontlinepoint = frontline::function_3d6018358065499a( spawnpoint.origin );
    tospawn = vectornormalize( spawnpoint.origin - frontlinepoint );
    dot = vectordot( tospawn, teamforward );
    
    if ( dot >= 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor
// Params 1
// Checksum 0xcfe9ff22, Offset: 0x412a
// Size: 0xb1
function preferoptimalfrontlinedist( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    
    if ( !( isdefined( spawncontext.factorparams ) && isdefined( level.frontlinedata ) ) )
    {
        return 100;
    }
    
    idealdistsq = spawncontext.factorparams[ "idealDistSq" ];
    distsq2d = frontline::function_319c43e923454d67( spawnpoint.origin );
    percent = clamp( 1 - abs( distsq2d - idealdistsq ) / idealdistsq, 0, 1 );
    return 100 * percent + 0;
}

// Namespace spawnfactor
// Params 1
// Checksum 0x822a649b, Offset: 0x41e4
// Size: 0x87
function preferunoccupiedlanes( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    maxdistancesquared = 67108864;
    distsq2d = frontline::function_d8ca994cf0504f9c( spawnpoint.origin, self.team );
    percent = clamp( 1 - distsq2d / maxdistancesquared, 0, 1 );
    return 100 * percent + 0;
}

// Namespace spawnfactor
// Params 1, eflags: 0x4
// Checksum 0x8a235302, Offset: 0x4274
// Size: 0x16
function private on_player_spawned( params )
{
    self.var_2fbd1e2a65dc3c11 = undefined;
}

// Namespace spawnfactor
// Params 1, eflags: 0x4
// Checksum 0x515c4ab5, Offset: 0x4292
// Size: 0x21
function private on_player_death( params )
{
    function_3d2c185018b63696( self, params, params.attacker );
}

// Namespace spawnfactor
// Params 1, eflags: 0x4
// Checksum 0x9c677066, Offset: 0x42bb
// Size: 0x21
function private on_player_damaged( params )
{
    function_3d2c185018b63696( self, params, params.eattacker );
}

