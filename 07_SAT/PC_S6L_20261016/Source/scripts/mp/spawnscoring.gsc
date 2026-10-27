// scripts\mp\spawnscoring.gsc  (hash_0c46589f289d961a.gscc) (size: 13699 Bytes / 0x3583 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2606f17 (3529535255)
// size ...... 13699 (0x3583)
// includes .. 12  (offset: 0x320b)
// strings ... 30  (offset: 0x326b)
// dev strs .. 24  (offset: 0x3463)
// exports ... 25  (offset: 0x220f)
// cseg ...... 0x2e9 + 0x1f26 (0x220f)
// imports ... 97  (offset: 0x25f7)
// animtree1 . 0   (offset: 0x3583)
// animtree2 . 0   (offset: 0x3583)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\dev;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;

#namespace spawnscoring;

// Namespace spawnscoring
// Params 1
// Checksum 0xcfce58ab, Offset: 0x307
// Size: 0x2a
function checkdynamicspawns( spawnpoints )
{
    if ( isdefined( level.dynamicspawns ) )
    {
        spawnpoints = [[ level.dynamicspawns ]]( spawnpoints );
    }
    
    return spawnpoints;
}

// Namespace spawnscoring
// Params 2
// Checksum 0x6cef8120, Offset: 0x33a
// Size: 0x25
function selectbestspawnpoint( highestscoringspawn, spawnpoints )
{
    bestspawn = highestscoringspawn;
    return bestspawn;
}

// Namespace spawnscoring
// Params 0
// Checksum 0x9facb5ef, Offset: 0x368
// Size: 0x2f2
function findbuddyspawn()
{
    if ( !level.teambased || level.disablebuddyspawn )
    {
        return;
    }
    
    /#
        dev_mp::function_96866f3a345090c7( self );
    #/
    
    teammates = getteammatesoutofcombat( spawnlogic::getactivespawnquerycontext().team );
    spawnpoints = [];
    
    foreach ( player in teammates )
    {
        spawnposition = findspawnlocationnearplayer( player );
        
        if ( !isdefined( spawnposition ) )
        {
            continue;
        }
        
        spawnpoint = spawnstruct();
        spawnpoint.origin = spawnposition;
        spawnpoint.angles = getbuddyspawnangles( player, spawnpoint.origin );
        spawnpoint.index = -1;
        spawnpoint.buddyspawn = 1;
        spawnpoint.isdynamicspawn = 1;
        spawnpoint.owner = player;
        spawnpoint spawnlogic::spawnpointinit();
        
        if ( isdefined( player.analyticslog ) && isdefined( player.analyticslog.playerid ) )
        {
            spawnpoint.buddyplayerid = player.analyticslog.playerid;
        }
        
        spawnpoints[ spawnpoints.size ] = spawnpoint;
    }
    
    /#
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) != 0 )
        {
            dev_mp::function_ade21d22c5c6d9c6( spawnpoints );
        }
    #/
    
    validspawnpoints = [];
    updatespawnpoints( spawnpoints, 1 );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( !testbuddyspawncriticalfactors( spawnpoint ) )
        {
            continue;
        }
        
        scorebuddyspawn( spawnpoint );
        validspawnpoints[ validspawnpoints.size ] = spawnpoint;
    }
    
    bestspawnpoint = undefined;
    
    foreach ( spawnpoint in validspawnpoints )
    {
        if ( !isdefined( bestspawnpoint ) || spawnpoint.totalscore > bestspawnpoint.totalscore )
        {
            bestspawnpoint = spawnpoint;
        }
    }
    
    /#
        spawnlogic::function_3ecd05e33756ef13();
    #/
    
    return bestspawnpoint;
}

// Namespace spawnscoring
// Params 1
// Checksum 0x3c52a9bc, Offset: 0x663
// Size: 0x3da
function findteammatebuddyspawn( teammate )
{
    if ( !level.teambased || level.disablebuddyspawn )
    {
        return;
    }
    
    /#
        dev_mp::function_96866f3a345090c7( self );
    #/
    
    spawninfo = spawnstruct();
    spawninfo.spawnposition = undefined;
    spawninfo.spawnangle = ( 0, teammate.angles[ 1 ], 0 );
    spawninfo = capsulepass( spawninfo, teammate );
    
    if ( !isdefined( spawninfo.spawnposition ) )
    {
        spawninfo.spawnposition = teammate.origin;
        spawninfo.spawnangle = teammate.angles;
    }
    
    if ( isdefined( teammate.vehicle ) )
    {
        seat = vehicle_occupancy::function_495d488c998ad412( teammate.vehicle );
        
        if ( isdefined( seat ) && vehicle_interact::vehicle_can_be_used( teammate.vehicle ) )
        {
            data = spawnstruct();
            data.useonspawn = 1;
            data.enterstartwaitmsg = "spawned_player";
            thread vehicle_occupancy::enter( teammate.vehicle, seat, self, data );
            spawninfo.spawnposition = teammate.vehicle.origin + anglestoforward( teammate.vehicle.angles ) * -200 + ( 0, 0, 64 );
            spawninfo.spawnangle = ( 0, teammate.vehicle.angles[ 1 ], 0 );
            self.spawningintovehicle = 1;
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "spawnSelectVehicle" ] ) )
                {
                    self.leaderboarddata[ "spawnSelectVehicle" ] = self.leaderboarddata[ "spawnSelectVehicle" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "spawnSelectVehicle" ] ) )
                {
                    [[ level.leaderboardfunc[ "spawnSelectVehicle" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( self.pers[ "spawnSelectVehicle" ] ) )
                {
                    self.pers[ "spawnSelectVehicle" ] = self.pers[ "spawnSelectVehicle" ] + 1;
                }
            }
        }
        else if ( !isdefined( spawninfo.spawnposition ) )
        {
            spawninfo.spawnposition = teammate.vehicle.origin + anglestoforward( teammate.vehicle.angles ) * -200 + ( 0, 0, 64 );
            spawninfo.spawnangle = ( 0, teammate.vehicle.angles[ 1 ], 0 );
        }
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawninfo.spawnposition;
    spawnpoint.angles = spawninfo.spawnangle;
    spawnpoint.index = -1;
    spawnpoint.buddyspawn = 1;
    spawnpoint.isdynamicspawn = 1;
    spawnpoint.owner = teammate;
    spawnpoint spawnlogic::spawnpointinit();
    
    if ( isdefined( teammate.analyticslog ) && isdefined( teammate.analyticslog.playerid ) )
    {
        spawnpoint.buddyplayerid = teammate.analyticslog.playerid;
    }
    
    return spawnpoint;
}

// Namespace spawnscoring
// Params 2
// Checksum 0x3d649eb0, Offset: 0xa46
// Size: 0x3f0
function capsulepass( spawninfo, teammate )
{
    radius = 16;
    castdist = 64;
    var_b275c146ba8d7e69 = 30;
    angstep = 30;
    maxsteps = 180 / angstep;
    failcount = 1;
    usepos = 1;
    baseang = teammate.angles;
    firstrun = 1;
    dir = undefined;
    groundpos = teammate.origin;
    
    if ( teammate haslastgroundorigin() && !teammate isswimming() )
    {
        groundpos = teammate getlastgroundorigin();
    }
    
    startpos = groundpos + ( 0, 0, var_b275c146ba8d7e69 );
    var_6ae68d30c76d162f = [ "physicscontents_characterproxy", "physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip" ];
    
    if ( !teammate isswimming() )
    {
        var_6ae68d30c76d162f[ var_6ae68d30c76d162f.size ] = "physicscontents_water";
    }
    
    contents = physics_createcontents( var_6ae68d30c76d162f );
    teammatearray = [ teammate ];
    
    while ( failcount < maxsteps )
    {
        if ( firstrun )
        {
            firstrun = 0;
            dir = anglestoforward( baseang );
        }
        else
        {
            dir = anglestoforward( baseang + ( 0, ( usepos ? angstep : angstep * -1 ) * failcount, 0 ) );
            usepos = !usepos;
            
            if ( usepos == 1 )
            {
                failcount++;
            }
        }
        
        endpos = groundpos - dir * castdist + ( 0, 0, var_b275c146ba8d7e69 );
        caststart = startpos - dir * radius * 0.5;
        trace = trace::player_trace( caststart, endpos, ( 0, 0, 0 ), teammatearray, contents );
        finalpos = trace[ "shape_position" ];
        
        if ( trace[ "fraction" ] < 1 && trace[ "fraction" ] > radius / castdist )
        {
            finalpos += dir * radius - ( 0, 0, castdist / 2 );
        }
        
        if ( trace[ "fraction" ] > radius / castdist )
        {
            caststart = finalpos;
            castend = caststart + ( 0, 0, -80 );
            castresults = trace::player_trace( caststart, castend, ( 0, 0, 0 ), teammatearray, contents );
            
            if ( castresults[ "fraction" ] < 1 )
            {
                angles = vectortoangles( dir );
                caststart = castresults[ "shape_position" ] + ( 0, 0, 10 );
                rearstart = caststart + anglestoforward( angles ) * -32;
                rearend = rearstart + ( 0, 0, -80 );
                reartrace = trace::ray_trace( rearstart, rearend, teammatearray, contents );
                
                if ( reartrace[ "fraction" ] == 1 )
                {
                    continue;
                }
                
                leftstart = caststart + anglestoright( angles ) * -32;
                leftend = leftstart + ( 0, 0, -80 );
                lefttrace = trace::ray_trace( leftstart, leftend, teammatearray, contents );
                
                if ( lefttrace[ "fraction" ] == 1 )
                {
                    continue;
                }
                
                rightstart = caststart + anglestoright( angles ) * 32;
                righttrace = trace::ray_trace( rightstart, rearend, teammatearray, contents );
                
                if ( righttrace[ "fraction" ] == 1 )
                {
                    continue;
                }
                
                spawninfo.spawnposition = castresults[ "shape_position" ];
                spawninfo.spawnangle = angles;
                break;
            }
            
            if ( teammate isswimming() )
            {
                spawninfo.spawnposition = finalpos;
                spawninfo.spawnangle = vectortoangles( dir );
                continue;
            }
            
            continue;
        }
    }
    
    return spawninfo;
}

// Namespace spawnscoring
// Params 1
// Checksum 0xf8311da4, Offset: 0xe3f
// Size: 0x32
function scorebuddyspawn( spawnpoint )
{
    spawnfactor::calculatefactorscore( spawnpoint, "avoidShortTimeToEnemySight", 1 );
    spawnfactor::calculatefactorscore( spawnpoint, "avoidClosestEnemy", 1 );
}

// Namespace spawnscoring
// Params 2
// Checksum 0xa9fab002, Offset: 0xe79
// Size: 0x34
function getbuddyspawnangles( buddy, spawnlocation )
{
    spawnangles = ( 0, buddy.angles[ 1 ], 0 );
    return spawnangles;
}

// Namespace spawnscoring
// Params 1
// Checksum 0x1d4d644d, Offset: 0xeb6
// Size: 0x119
function getteammatesoutofcombat( team )
{
    teammates = [];
    
    foreach ( player in level.players )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x4a>" );
        #/
        
        if ( player.team != team )
        {
            /#
                dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x52>" );
            #/
            
            continue;
        }
        
        if ( player == self )
        {
            /#
                dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x5d>" );
            #/
            
            continue;
        }
        
        if ( !canplayerbebuddyspawnedon( player ) )
        {
            continue;
        }
        
        if ( !player val::get( "player_for_spawn_logic" ) )
        {
            /#
                dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x62>" );
            #/
            
            continue;
        }
        
        teammates[ teammates.size ] = player;
    }
    
    return arrayrandomize( teammates );
}

// Namespace spawnscoring
// Params 1
// Checksum 0x38cea926, Offset: 0xfd8
// Size: 0x11e, Type: bool
function canplayerbebuddyspawnedon( player )
{
    if ( player.sessionstate != "playing" )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x72>" + player.sessionstate );
        #/
        
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x81>" );
        #/
        
        return false;
    }
    
    if ( !player isonground() )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x86>" );
        #/
        
        return false;
    }
    
    if ( player isonladder() )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x8e>" );
        #/
        
        return false;
    }
    
    if ( player utility::isflashed() )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x95>" );
        #/
        
        return false;
    }
    
    if ( player.health < player.maxhealth && ( !isdefined( player.lastdamagedtime ) || gettime() < player.lastdamagedtime + 3000 ) )
    {
        /#
            dev_mp::function_f6455fc7b730d9f9( player, "<dev string:x9d>" );
        #/
        
        return false;
    }
    
    /#
        dev_mp::function_f6455fc7b730d9f9( player, "<dev string:xa4>" );
    #/
    
    return true;
}

// Namespace spawnscoring
// Params 1
// Checksum 0x993a96f1, Offset: 0x10ff
// Size: 0x4c
function findspawnlocationnearplayer( player )
{
    playerheight = spawnlogic::getplayertraceheight( player, 1 );
    buddynode = findbuddypathnode( player, playerheight, 0.5 );
    
    if ( isdefined( buddynode ) )
    {
        return buddynode.origin;
    }
}

// Namespace spawnscoring
// Params 3
// Checksum 0x81aab11, Offset: 0x1154
// Size: 0x18d
function findbuddypathnode( buddy, playerheight, cosangle )
{
    nodearray = getnodesinradiussorted( buddy.origin, 192, 64, playerheight, "Path", 1 );
    bestnode = undefined;
    
    if ( nodearray.size > 0 )
    {
        buddydir = anglestoforward( buddy.angles );
        
        /#
            if ( getdvarint( @"hash_9bffca47d2e56b54" ) != 0 )
            {
                dev_mp::function_4cce993aca3c36a3( buddy, nodearray );
            }
        #/
        
        foreach ( buddynode in nodearray )
        {
            if ( isdefined( level.badpathnodes ) && arraycontains( level.badpathnodes, buddynode ) )
            {
                continue;
            }
            
            var_16ed23c977a1370a = vectornormalize( buddynode.origin - buddy.origin );
            dot = vectordot( buddydir, var_16ed23c977a1370a );
            
            if ( dot <= cosangle && !positionwouldtelefrag( buddynode.origin ) )
            {
                bestnode = buddynode;
                
                if ( dot <= 0 )
                {
                    break;
                }
            }
        }
    }
    
    /#
        dev_mp::function_97b016636c4e563c( buddy, bestnode );
    #/
    
    return bestnode;
}

// Namespace spawnscoring
// Params 1
// Checksum 0xf1a081f1, Offset: 0x12ea
// Size: 0x14b
function initscoredata( spawnpoint )
{
    spawnpoint.totalscore = 0;
    spawnpoint.totalpossiblescore = 0;
    spawnpoint.isbadspawn = 0;
    spawnpoint.lastscore = [];
    spawnpoint.lastscore[ "allies" ] = 0;
    spawnpoint.lastscore[ "axis" ] = 0;
    spawnpoint.analytics = spawnstruct();
    spawnpoint.analytics.allyaveragedist = 0;
    spawnpoint.analytics.enemyaveragedist = 0;
    spawnpoint.analytics.timesincelastspawn = 0;
    spawnpoint.analytics.maxenemysightfraction = 0;
    spawnpoint.analytics.randomscore = 0;
    spawnpoint.analytics.maxjumpingenemysightfraction = 0;
    spawnpoint.analytics.spawnusedbyenemies = 0;
    spawnpoint.analytics.spawntype = 0;
    
    /#
        spawnpoint.debugscoredata = [];
        spawnpoint.var_5618820f8f5487f4 = [];
    #/
}

// Namespace spawnscoring
// Params 2
// Checksum 0x90f7a2b5, Offset: 0x143d
// Size: 0xf4
function updatespawnpoints( spawnpoints, skipfrontline )
{
    team = spawnlogic::getspawnteam( self );
    skipfrontline = istrue( skipfrontline );
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = team_utility::getotherteam( team );
    }
    
    foreach ( spawnpoint in spawnpoints )
    {
        initscoredata( spawnpoint );
        spawnlogic::initspawnpointvalues( spawnpoint );
        spawnlogic::evaluateprecomputedlos( spawnpoint, team );
        
        if ( !skipfrontline )
        {
            spawnlogic::evaluateprecomputedlos( spawnpoint, enemyteam );
        }
    }
    
    if ( !skipfrontline )
    {
        spawnfactor::updatefrontline( team );
    }
}

// Namespace spawnscoring
// Params 1
// Checksum 0x654161d0, Offset: 0x1539
// Size: 0x36
function criticalfactors_callback( spawnpoint )
{
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidbradleys, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 8;
        return "bad";
    }
    
    return "primary";
}

// Namespace spawnscoring
// Params 1
// Checksum 0x6d750324, Offset: 0x1578
// Size: 0x1e1
function function_7f5a514a8d106245( spawnpoint )
{
    /#
        if ( getdvarint( @"hash_88da8d1aa9e42678" ) > 0 )
        {
            return "<dev string:xaa>";
        }
    #/
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_9458c22d717552de, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 0;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_234c5bb0b629ba36, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 1;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_1346227861145279, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 2;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidcarepackages, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 4;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidbradleys, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 8;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidtelefrag, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 5;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_165bd49158282462, spawnpoint ) )
    {
        spawnpoint.badspawnreason = 6;
        return "bad";
    }
    
    assert( !spawnfactor::currentspawnlogicsupportsfrontline() || spawnfactor::getglobalfrontlineinfo().lastupdatetime == gettime() );
    
    if ( isdefined( spawnpoint.frontlineteam ) && level.frontlineinfo.isactive[ self.team ] && spawnpoint.frontlineteam != self.team )
    {
        spawnpoint.badspawnreason = 7;
        return "bad";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_ee2557d42e1f1f2a, spawnpoint ) )
    {
        return "secondary";
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_e48a260b1ebcccf, spawnpoint ) )
    {
        return "secondary";
    }
    
    return "primary";
}

// Namespace spawnscoring
// Params 1
// Checksum 0x50872e3a, Offset: 0x1762
// Size: 0x11b, Type: bool
function testbuddyspawncriticalfactors( spawnpoint )
{
    if ( !spawnfactor::critical_factor( &spawnfactor::function_9458c22d717552de, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xae>" );
        #/
        
        return false;
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_234c5bb0b629ba36, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xb7>" );
        #/
        
        return false;
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_1346227861145279, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xc4>" );
        #/
        
        return false;
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidcarepackages, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xce>" );
        #/
        
        return false;
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidbradleys, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xe0>" );
        #/
        
        return false;
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::avoidtelefrag, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xef>" );
        #/
        
        return false;
    }
    
    if ( !spawnfactor::critical_factor( &spawnfactor::function_e48a260b1ebcccf, spawnpoint ) )
    {
        /#
            dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:xf8>" );
        #/
        
        return false;
    }
    
    /#
        dev_mp::function_9549682a12e7ad1( spawnpoint, "<dev string:x103>" );
    #/
    
    return true;
}

// Namespace spawnscoring
// Params 1
// Checksum 0x65697e05, Offset: 0x1886
// Size: 0x1be
function getstartspawnpoint_freeforall( spawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return;
    }
    
    selectedspawnpoint = undefined;
    activeplayerlist = spawnlogic::getactiveplayerlist();
    spawnpoints = checkdynamicspawns( spawnpoints );
    
    if ( !isdefined( activeplayerlist ) || activeplayerlist.size == 0 )
    {
        return spawnlogic::getspawnpoint_random( spawnpoints );
    }
    
    furthestdistsq = 0;
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( canspawn( spawnpoint.origin ) && !positionwouldtelefrag( spawnpoint.origin ) )
        {
            var_7bb107a7fbe87b9a = undefined;
            
            foreach ( player in activeplayerlist )
            {
                disttoenemysq = distancesquared( spawnpoint.origin, player.origin );
                
                if ( !isdefined( var_7bb107a7fbe87b9a ) || disttoenemysq < var_7bb107a7fbe87b9a )
                {
                    var_7bb107a7fbe87b9a = disttoenemysq;
                }
            }
            
            if ( !isdefined( selectedspawnpoint ) || var_7bb107a7fbe87b9a > furthestdistsq )
            {
                selectedspawnpoint = spawnpoint;
                furthestdistsq = var_7bb107a7fbe87b9a;
            }
        }
    }
    
    if ( !isdefined( selectedspawnpoint ) )
    {
        return spawnlogic::getspawnpoint_random( spawnpoints );
    }
    
    return selectedspawnpoint;
}

// Namespace spawnscoring
// Params 2
// Checksum 0x95919ec7, Offset: 0x1a4d
// Size: 0x7a
function logbadspawn( typestring, spawningentity )
{
    if ( isdefined( spawningentity ) && spawningentity.disablespawnwarnings )
    {
        return;
    }
    
    if ( !isdefined( typestring ) )
    {
        typestring = "";
    }
    else
    {
        typestring = typestring;
    }
    
    println( "<dev string:x10b>" + typestring + "<dev string:x119>" );
    
    if ( isdefined( level.matchrecording_logeventmsg ) )
    {
        [[ level.matchrecording_logeventmsg ]]( "LOG_BAD_SPAWN", gettime(), typestring );
    }
}

// Namespace spawnscoring
// Params 5
// Checksum 0x7f123b9, Offset: 0x1acf
// Size: 0x2bd
function getspawnpoint_legacy( spawnpoints, fallbackspawnpoints, factorparams, var_80f4ec8d73bb8ba1, nobuddyspawns )
{
    level.spawnglobals.spawnpointslist = spawnpoints;
    spawncontext = spawnlogic::createspawnquerycontext( self, self.pers[ "team" ] );
    spawnlogic::setactivespawnquerycontext( spawncontext );
    resetperupdatespawnglobals();
    function_1023ce5c5fc672b();
    
    if ( level.forcebuddyspawn )
    {
        spawnpoint = findbuddyspawn();
        
        if ( isdefined( spawnpoint ) )
        {
            /#
                spawnlogic::function_3ecd05e33756ef13();
            #/
            
            return spawnpoint;
        }
    }
    
    var_61acbd60741db8a0 = undefined;
    level.spawnglobals.spawn_type = 0;
    normalresult = function_e2143227fcb330c9( spawnpoints, 0 );
    
    if ( isdefined( normalresult ) )
    {
        if ( !normalresult.isbadspawn )
        {
            /#
                spawnlogic::function_3ecd05e33756ef13();
            #/
            
            return normalresult;
        }
        else
        {
            var_61acbd60741db8a0 = normalresult;
        }
    }
    
    if ( isdefined( fallbackspawnpoints ) )
    {
        fallbackresult = function_e2143227fcb330c9( fallbackspawnpoints, 3 );
        
        if ( isdefined( fallbackresult ) )
        {
            if ( fallbackresult.isbadspawn )
            {
                if ( !isdefined( var_61acbd60741db8a0 ) || fallbackresult.totalscore > var_61acbd60741db8a0.totalscore )
                {
                    var_61acbd60741db8a0 = fallbackresult;
                }
            }
            else
            {
                /#
                    spawnlogic::function_3ecd05e33756ef13();
                #/
                
                logbadspawn( "Using a fallback spawn.", self );
                return fallbackresult;
            }
        }
    }
    
    if ( var_80f4ec8d73bb8ba1 )
    {
        /#
            spawnlogic::function_3ecd05e33756ef13();
        #/
        
        return;
    }
    
    logbadspawn( "Using a LastResort spawn point.", self );
    
    /#
        if ( isplayer( self ) )
        {
            self iprintlnbold( "<dev string:x11b>" );
        }
    #/
    
    if ( !nobuddyspawns )
    {
        buddyspawn = findbuddyspawn();
        
        if ( isdefined( buddyspawn ) )
        {
            buddyspawn.spawntype = 7;
            level.spawnglobals.buddyspawnid = 0;
            
            if ( isdefined( buddyspawn.buddyplayerid ) )
            {
                level.spawnglobals.buddyplayerid = buddyspawn.buddyplayerid;
            }
            
            /#
                spawnlogic::function_3ecd05e33756ef13();
            #/
            
            return buddyspawn;
        }
        
        logbadspawn( "UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self );
    }
    
    if ( level.teambased && !game_utility_mp::isanymlgmatch() )
    {
        lastbadspawntime = level.spawnglobals.lastbadspawntime[ self.team ];
        
        if ( gettime() - lastbadspawntime < 5000 )
        {
            var_61acbd60741db8a0 = spawnpoints[ randomint( spawnpoints.size ) ];
        }
        else
        {
            level.spawnglobals.lastbadspawntime[ self.team ] = gettime();
        }
    }
    
    /#
        spawnlogic::function_3ecd05e33756ef13();
    #/
    
    return var_61acbd60741db8a0;
}

// Namespace spawnscoring
// Params 2
// Checksum 0x97ae3667, Offset: 0x1d95
// Size: 0x21f
function function_e2143227fcb330c9( spawnpoints, spawntypeoffset )
{
    spawnpoints = checkdynamicspawns( spawnpoints );
    spawnchoices[ "primary" ] = [];
    spawnchoices[ "secondary" ] = [];
    spawnchoices[ "bad" ] = [];
    updatespawnpoints( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        result = function_7f5a514a8d106245( spawnpoint );
        spawnchoices[ result ][ spawnchoices[ result ].size ] = spawnpoint;
        spawnpoint.lastbucket[ self.spawnlogicteam ?? self.team ] = result;
        
        if ( isdefined( spawnpoint.analytics ) && isdefined( spawnpoint.analytics.spawntype ) )
        {
            if ( result == "primary" )
            {
                spawnpoint.analytics.spawntype = spawntypeoffset + 1;
                continue;
            }
            
            if ( result == "secondary" )
            {
                spawnpoint.analytics.spawntype = spawntypeoffset + 2;
                continue;
            }
            
            spawnpoint.analytics.spawntype = spawntypeoffset + 3;
        }
    }
    
    if ( spawnchoices[ "primary" ].size )
    {
        result = gethighestscoringspawn( spawnchoices[ "primary" ] );
        result.spawn_type = 1;
        return result;
    }
    
    if ( spawnchoices[ "secondary" ].size )
    {
        result = gethighestscoringspawn( spawnchoices[ "secondary" ] );
        result.spawn_type = 2;
        return result;
    }
    
    if ( spawnchoices[ "bad" ].size )
    {
        logbadspawn( "Using Bad Spawn", self );
        result = gethighestscoringspawn( spawnchoices[ "bad" ] );
        
        if ( isdefined( result ) )
        {
            result.isbadspawn = 1;
        }
        
        return result;
    }
}

// Namespace spawnscoring
// Params 0
// Checksum 0xff0aa0da, Offset: 0x1fbd
// Size: 0x31
function resetperupdatespawnglobals()
{
    spawnglobals = level.spawnglobals;
    spawnglobals.hasclusterdata = 0;
    spawnglobals.haslanedata = 0;
}

// Namespace spawnscoring
// Params 0
// Checksum 0xecc74959, Offset: 0x1ff6
// Size: 0x5a
function function_1023ce5c5fc672b()
{
    team = spawnlogic::getspawnteam( self );
    spawnglobals = level.spawnglobals;
    
    if ( spawnlogic::isfactorinuse( "preferNearGroupsOfTeamMates" ) )
    {
        spawnglobals.teamclusters = [];
        spawnglobals.teamclusters[ team ] = spawnlogic::calculateteamclusters( team );
    }
}

// Namespace spawnscoring
// Params 1
// Checksum 0x8bbaade0, Offset: 0x2058
// Size: 0xb6
function gethighestscoringspawn( spawnpoints )
{
    bestspawn = spawnpoints[ 0 ];
    
    foreach ( spawnpoint in spawnpoints )
    {
        spawnlogic::scorespawnpoint( spawnpoint );
        
        if ( spawnpoint.totalscore > bestspawn.totalscore )
        {
            bestspawn = spawnpoint;
        }
    }
    
    bestspawn = selectbestspawnpoint( bestspawn, spawnpoints );
    return bestspawn;
}

// Namespace spawnscoring
// Params 0
// Checksum 0xc2226ded, Offset: 0x2117
// Size: 0xf8
function squadspawndebug()
{
    self endon( #"death_or_disconnect" );
    spawninfo = spawnstruct();
    
    while ( true )
    {
        spawninfo.spawnposition = undefined;
        spawninfo.spawnangle = undefined;
        spawninfo = capsulepass( spawninfo, self );
        failed = 0;
        
        if ( !isdefined( spawninfo.spawnposition ) )
        {
            spawninfo.spawnposition = self.origin;
            spawninfo.spawnangle = self.angles;
            failed = 1;
        }
        
        thread debug_utility::drawsphere( spawninfo.spawnposition, 16, 0.1, failed ? ( 1, 0, 0 ) : ( 0, 1, 0 ) );
        thread debug_utility::drawangles( spawninfo.spawnposition, spawninfo.spawnangle, 0.1, 1 );
        wait 0.1;
    }
}

