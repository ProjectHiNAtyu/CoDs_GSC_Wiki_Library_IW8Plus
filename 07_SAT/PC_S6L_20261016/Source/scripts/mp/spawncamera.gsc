// scripts\mp\spawncamera.gsc  (hash_27c5d22c922f2128.gscc) (size: 26041 Bytes / 0x65b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2031945e (540120158)
// size ...... 26041 (0x65b9)
// includes .. 20  (offset: 0x6055)
// strings ... 77  (offset: 0x60f5)
// dev strs .. 0   (offset: 0x65b9)
// exports ... 47  (offset: 0x4745)
// cseg ...... 0x8c1 + 0x3e84 (0x4745)
// imports ... 134 (offset: 0x4e9d)
// animtree1 . 0   (offset: 0x65b9)
// animtree2 . 0   (offset: 0x65b9)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\ent_manager;
#using scripts\mp\flags;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;

#namespace spawncamera;

// Namespace spawncamera
// Params 0
// Checksum 0xd53f62b7, Offset: 0x8df
// Size: 0x1ff
function init()
{
    if ( !isdefined( level.disablespawncamera ) )
    {
        level.disablespawncamera = getmatchrulesdata( "commonOption", "disableSpawnCamera" ) == 1;
    }
    
    level.minimumtimetospectateteammates = getmatchrulesdata( "commonOption", "minimumTimeToSpectateTeammates" );
    level.durationtoshowspawncamera = getmatchrulesdata( "commonOption", "durationToShowSpawnCamera" );
    level.swaptospawncameraifallteammatesdead = getmatchrulesdata( "commonOption", "swapToSpawnCameraIfAllTeammatesDead" ) == 1;
    level.minimumTimeToShowRespawnMessage = getmatchrulesdata( "commonOption", "minimumTimeToShowRespawnMessage" );
    level.snaptospawncamera = getdvarint( @"hash_1a2c3b67392b6657", 1 ) == 1;
    level.evaluatefrontline = getdvarint( @"hash_405e7e20d91344cc", 0 ) == 1;
    level.evaluatespawnforcameraselection = getdvarint( @"hash_c7c93411ff36195c", 1 ) == 1;
    level.usestaticspawnselectioncamera = getdvarint( @"hash_67329f458977df45", 0 );
    level.var_df44da1a31f642fe = getdvarvector( @"hash_ee64455059eaeef8", ( 0, 0, 0 ) );
    
    if ( length( level.var_df44da1a31f642fe ) < 1 )
    {
        level.var_df44da1a31f642fe = undefined;
    }
    
    level.var_c5481112b07bd294 = getdvarvector( @"hash_f1fe5a0456713312", ( 0, 0, 0 ) );
    
    if ( length( level.var_c5481112b07bd294 ) < 1 )
    {
        level.var_c5481112b07bd294 = undefined;
    }
    
    level.useunifiedspawnselectioncameraheight = getdvarint( @"hash_9d6d762163aa3df", 1 );
    level.var_337324c343ba6f9e = getdvarint( @"hash_119957cbc3ce1a03", 0 );
    
    if ( !isdefined( level.var_3d172b3e61c9f60b ) )
    {
        level.var_3d172b3e61c9f60b = &createdefaultcameras;
    }
    
    if ( !isdefined( level.updatedefaultcamera ) )
    {
        level.updatedefaultcamera = &blank_func;
    }
    
    if ( !isdefined( level.updategamemodecamera ) )
    {
        level.updategamemodecamera = &blank_func;
    }
    
    if ( !level.disablespawncamera )
    {
        initcameras();
    }
}

// Namespace spawncamera
// Params 0
// Checksum 0xe958b6fc, Offset: 0xae6
// Size: 0x2
function blank_func()
{
    
}

// Namespace spawncamera
// Params 0
// Checksum 0x8fe00b65, Offset: 0xaf0
// Size: 0x31f
function initcameras()
{
    level.spawncameras = [];
    level.currentcamera = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.currentcamera[ entry ] = "default";
    }
    
    cameras = utility::getstructarray( "spawn_selection_camera", "targetname" );
    
    if ( cameras.size == 0 || level.mapname == "mp_aniyah_tac" )
    {
        [[ level.var_3d172b3e61c9f60b ]]();
        level.var_aeb6f04033bb30b0 = 1;
        return;
    }
    
    foreach ( camera in cameras )
    {
        ref = camera.script_label;
        
        if ( !isdefined( ref ) || ref == "spawn_selection_camera" )
        {
            ref = camera.script_noteworthy;
        }
        
        if ( isdefined( game_utility::getlocaleid() ) )
        {
            locale = camera.script_noteworthy;
            
            if ( !isdefined( locale ) || isdefined( locale ) && locale != level.localeid )
            {
                continue;
            }
        }
        
        if ( !isdefined( level.spawncameras[ ref ] ) )
        {
            level.spawncameras[ ref ] = [];
        }
        
        team = camera.script_team;
        
        if ( team == "all" )
        {
            foreach ( entry in level.teamnamelist )
            {
                level.spawncameras[ ref ][ entry ] = camera;
            }
            
            continue;
        }
        
        if ( level.usestaticspawnselectioncamera )
        {
            temp = spawnselection::getstaticcameraposition( team );
            camera.origin = temp.origin;
            camera.angles = temp.angles;
        }
        
        level.spawncameras[ ref ][ team ] = camera;
        
        if ( team == "axis" )
        {
            level.spawncameras[ ref ][ "team_three" ] = camera;
            level.spawncameras[ ref ][ "team_four" ] = camera;
        }
    }
    
    [[ level.var_3d172b3e61c9f60b ]]();
    level.var_aeb6f04033bb30b0 = 1;
}

// Namespace spawncamera
// Params 0
// Checksum 0x675433ae, Offset: 0xe17
// Size: 0x583
function createdefaultcameras()
{
    if ( isdefined( level.spawncameras[ "default" ] ) )
    {
        allfound = 1;
        
        foreach ( entry in level.teamnamelist )
        {
            if ( !isdefined( level.spawncameras[ "default" ][ entry ] ) )
            {
                allfound = 0;
                break;
            }
        }
        
        if ( allfound )
        {
            return;
        }
    }
    else
    {
        level.spawncameras[ "default" ] = [];
    }
    
    if ( isdefined( level.mapcorners[ 0 ] ) && isdefined( level.mapcorners[ 1 ] ) )
    {
        level.mapcornervector = level.mapcorners[ 1 ].origin - level.mapcorners[ 0 ].origin;
        level.mapcornercenter = level.mapcorners[ 0 ].origin + level.mapcornervector * 0.5;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isdefined( level.spawncameras[ "default" ][ entry ] ) )
        {
            level.spawncameras[ "default" ][ entry ].radiantplaced = 1;
            continue;
        }
        
        camerastruct = spawnstruct();
        camerastruct.origin = ( 0, 0, 0 );
        camerastruct.angles = ( 0, 0, 0 );
        level.spawncameras[ "default" ][ entry ] = camerastruct;
    }
    
    level.spawncamerastartspawnallies = getstartspawnavg( "allies" );
    level.spawncamerastartspawnaxis = getstartspawnavg( "axis" );
    level.spawncamerastartspawnaxisang = distancesquared( level.spawncamerastartspawnaxis, level.mapcorners[ 0 ].origin ) < distancesquared( level.spawncamerastartspawnaxis, level.mapcorners[ 1 ].origin ) ? level.mapcorners[ 0 ].angles : level.mapcorners[ 1 ].angles;
    spawnvector = level.spawncamerastartspawnaxis - level.spawncamerastartspawnallies;
    
    if ( distancesquared( level.spawncamerastartspawnallies, level.mapcorners[ 0 ].origin ) < distancesquared( level.spawncamerastartspawnallies, level.mapcorners[ 1 ].origin ) )
    {
        cornerfwd = anglestoforward( level.mapcorners[ 0 ].angles );
        cornerright = anglestoright( level.mapcorners[ 0 ].angles );
        
        if ( abs( vectordot( spawnvector, cornerfwd ) ) > abs( vectordot( spawnvector, cornerright ) ) )
        {
            level.spawncamerastartspawnalliesvec = cornerfwd;
        }
        else
        {
            level.spawncamerastartspawnalliesvec = cornerright;
        }
    }
    else
    {
        cornerfwd = anglestoforward( level.mapcorners[ 1 ].angles );
        cornerright = anglestoright( level.mapcorners[ 1 ].angles );
        
        if ( abs( vectordot( spawnvector, cornerfwd ) ) > abs( vectordot( spawnvector, cornerright ) ) )
        {
            level.spawncamerastartspawnalliesvec = cornerfwd;
        }
        else
        {
            level.spawncamerastartspawnalliesvec = cornerright;
        }
    }
    
    if ( distancesquared( level.spawncamerastartspawnaxis, level.mapcorners[ 0 ].origin ) < distancesquared( level.spawncamerastartspawnaxis, level.mapcorners[ 1 ].origin ) )
    {
        cornerfwd = anglestoforward( level.mapcorners[ 0 ].angles );
        cornerright = anglestoright( level.mapcorners[ 0 ].angles );
        
        if ( abs( vectordot( spawnvector, cornerfwd ) ) > abs( vectordot( spawnvector, cornerright ) ) )
        {
            level.spawncamerastartspawnaxisvec = cornerfwd;
        }
        else
        {
            level.spawncamerastartspawnaxisvec = cornerright;
        }
    }
    else
    {
        cornerfwd = anglestoforward( level.mapcorners[ 1 ].angles );
        cornerright = anglestoright( level.mapcorners[ 1 ].angles );
        
        if ( abs( vectordot( spawnvector, cornerfwd ) ) > abs( vectordot( spawnvector, cornerright ) ) )
        {
            level.spawncamerastartspawnaxisvec = cornerfwd;
        }
        else
        {
            level.spawncamerastartspawnaxisvec = cornerright;
        }
    }
    
    spawndist = distance( level.spawncamerastartspawnallies, level.spawncamerastartspawnaxis );
    level.spawncameradistfactor = spawndist;
    orientdefaulttomapcenterusingmapcorners();
}

// Namespace spawncamera
// Params 0
// Checksum 0x2451d776, Offset: 0x13a2
// Size: 0x153
function createspawncamera()
{
    if ( isdefined( level.updatedefaultcamera ) )
    {
        [[ level.updatedefaultcamera ]]();
    }
    
    if ( isdefined( level.updategamemodecamera ) )
    {
        self [[ level.updategamemodecamera ]]();
    }
    
    spectatepos = self.origin + ( 0, 0, 60 );
    var_9149918291092f13 = self.angles;
    
    if ( isdefined( self.squadspectatepos ) )
    {
        self.deathspectatepos = self.squadspectatepos;
        self.deathspectateangles = self.squadspectateang;
    }
    else
    {
        self.deathspectatepos = spectatepos;
        self.deathspectateangles = var_9149918291092f13;
    }
    
    if ( !isdefined( self.spawncameraent ) )
    {
        cameraent = spawn( "script_model", self.deathspectatepos );
        cameraent ent_manager::registerspawncount( 1 );
        cameraent setmodel( "tag_origin" );
        cameraent.angles = self.deathspectateangles;
        self.spawncameraent = cameraent;
        return;
    }
    
    self.spawncameraent.origin = self.deathspectatepos;
    self.spawncameraent.angles = self.deathspectateangles;
}

// Namespace spawncamera
// Params 4
// Checksum 0xb3bb9345, Offset: 0x14fd
// Size: 0x1e0
function startspawncamera( fadedownduration, holdduration, fadeupduration, var_c5e049932980fa60 = 0 )
{
    self endon( #"disconnect" );
    self notify( #"hash_4a0590e04aac48c9" );
    player::printspawnmessage( "spawnCamera::startSpawnCamera() START" );
    player::hideminimap( 1 );
    self cleardamageindicators();
    
    if ( !( self.inspawncamera && getdvarint( @"hash_7958073a99a0d67e", 1 ) == 1 ) )
    {
        createspawncamera();
    }
    
    if ( !isdefined( self.spawncameraent ) )
    {
        player::printspawnmessage( "spawnCamera::startSpawnCamera() UNDEFINED SPAWNCAMERAENT!!!" );
        thread playslamzoomflash( 0, getspawncamerawaittime(), 0.5, var_c5e049932980fa60 );
        return;
    }
    
    if ( level.disablespawncamera && !level.usespawnselection )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( self.inspawncamera )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self.setspawnpoint ) && !level.usespawnselection )
    {
        return;
    }
    
    self.inspawncamera = 1;
    player::setdof_default();
    waitframe();
    spectating::setdisabled();
    player::updatesessionstate( "spectator" );
    self setclientomnvar( "ui_in_spawn_camera", 1 );
    
    if ( !isdefined( fadedownduration ) )
    {
        fadedownduration = 0;
    }
    
    if ( !isdefined( holdduration ) )
    {
        holdduration = 0.25;
    }
    
    if ( !isdefined( fadeupduration ) )
    {
        fadeupduration = 0.25;
    }
    
    thread playslamzoomflash( fadedownduration, holdduration, fadeupduration, var_c5e049932980fa60 );
    thread removecameraondisconnect( self.spawncameraent );
    thread function_98254b86918d7396( self.spawncameraent );
    utility::waittill_any_timeout_no_endon_death( 0.1, "force_spawn" );
    self cameralinkto( self.spawncameraent, "tag_origin", 1, 1 );
    player::printspawnmessage( "spawnCamera::startSpawnCamera() CameraLinkTo()" );
    self clearadditionalstreampos();
    thread snaptospawncamera();
}

// Namespace spawncamera
// Params 0
// Checksum 0xc45cd858, Offset: 0x16e5
// Size: 0x74
function getspawncamerawaittime()
{
    if ( isdefined( self.spawncameratime ) )
    {
        return self.spawncameratime;
    }
    
    if ( self.squadspawnaborted || !level.snaptospawncamera && ( self.skippedkillcam || !isdefined( self.killcamwatchtime ) || self.killcamwatchtime < 2 ) )
    {
        return 2.5;
    }
    
    return 1.5;
}

// Namespace spawncamera
// Params 0
// Checksum 0xf4730dc6, Offset: 0x1761
// Size: 0x7, Type: bool
function getspawncamerablendtime()
{
    return true;
}

// Namespace spawncamera
// Params 0
// Checksum 0x156f7bad, Offset: 0x1771
// Size: 0x7b2
function getspawncamera()
{
    if ( self.var_12828bf3eee603d5 && isdefined( self.cachedspawncamera ) )
    {
        return self.cachedspawncamera;
    }
    
    spawncamera = undefined;
    team = self.team;
    
    if ( !isdefined( team ) )
    {
        team = self.sessionteam;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        player::printspawnmessage( "spawncamera::getSpawnCamera() - !isGameplayTeam() = " + team + "camera was undefined, forcing allies default" );
        spawncamera = level.spawncameras[ "default" ][ "allies" ];
        return spawncamera;
    }
    
    if ( function_28d94ef4997bd53e() )
    {
        self.forcedspawncameraref = "default";
    }
    
    if ( level.spawncameraoverride )
    {
        self.forcedspawncameraref = level.spawncameraoverride;
    }
    
    if ( level.usestaticspawnselectioncamera )
    {
        level.currentcamera[ team ] = "default";
        spawncamera = level.spawncameras[ level.currentcamera[ team ] ][ team ];
        temp = spawnselection::getstaticcameraposition( team );
        spawncamera.origin = temp.origin;
        spawncamera.angles = temp.angles;
    }
    else if ( isdefined( self.forcedspawncameraref ) )
    {
        if ( isdefined( level.spawncameras[ self.forcedspawncameraref ] ) )
        {
            spawncamera = level.spawncameras[ self.forcedspawncameraref ][ team ];
        }
        else if ( issubstr( self.forcedspawncameraref, "squad" ) )
        {
            ref = self.forcedspawncameraref;
            
            if ( ref == "squad_leader" )
            {
                index = level.squaddata[ team ][ self.sessionsquadid ].squadleader.sessionuimemberindex;
            }
            else
            {
                index = int( getsubstr( ref, ref.size - 1, ref.size ) );
            }
            
            goalplayer = undefined;
            
            if ( isdefined( level.squaddata[ team ][ self.sessionsquadid ] ) && isdefined( level.squaddata[ team ][ self.sessionsquadid ].players[ index ] ) )
            {
                goalplayer = level.squaddata[ team ][ self.sessionsquadid ].players[ index ];
            }
            
            if ( isdefined( goalplayer ) )
            {
                forward = level.spawnselectionteamforward[ team ];
                heightoffset = 7000;
                
                if ( level.useunifiedspawnselectioncameraheight )
                {
                    heightoffset = spawnselection::function_ceff7e3b58ecd747();
                }
                
                goalposition = goalplayer.origin + forward * -8500 + ( 0, 0, heightoffset );
                goalvector = vectornormalize( goalplayer.origin - goalposition );
                goalangles = script::vectortoanglessafe( goalvector, ( 0, 0, 1 ) );
                
                if ( !isdefined( level.var_81d027302ddd38f4 ) )
                {
                    level.var_81d027302ddd38f4 = &calculatecameraoffset;
                }
                
                goalposition += [[ level.var_81d027302ddd38f4 ]]( team, goalplayer.origin );
                spawncamera = spawnstruct();
                spawncamera.origin = goalposition;
                spawncamera.angles = goalangles;
            }
        }
        else if ( issubstr( self.forcedspawncameraref, "vehicle" ) )
        {
            ref = self.forcedspawncameraref;
            vehicleent = undefined;
            
            if ( isdefined( level.spawnselectionlocations[ ref ][ team ] ) )
            {
                vehicleent = level.spawnselectionlocations[ ref ][ team ].dynamicent;
            }
            
            forward = level.spawnselectionteamforward[ team ];
            
            if ( isdefined( vehicleent ) && !vehicleent.isdestroyed )
            {
                goalposition = [];
                goalangles = [];
                heightoffset = 7000;
                
                if ( level.useunifiedspawnselectioncameraheight )
                {
                    heightoffset = spawnselection::function_ceff7e3b58ecd747();
                }
                
                goalposition = vehicleent.origin + forward * -8500 + ( 0, 0, heightoffset );
                groundpos = level.spawnselectionlocations[ ref ][ team ].anchorentity.origin;
                camerapos = groundpos + forward * -8500 + ( 0, 0, heightoffset );
                toground = vectornormalize( groundpos - camerapos );
                goalangles = script::vectortoanglessafe( toground, ( 0, 0, 1 ) );
                
                if ( !isdefined( level.var_81d027302ddd38f4 ) )
                {
                    level.var_81d027302ddd38f4 = &calculatecameraoffset;
                }
                
                goalposition += [[ level.var_81d027302ddd38f4 ]]( team, groundpos );
                spawncamera = spawnstruct();
                spawncamera.origin = goalposition;
                spawncamera.angles = goalangles;
            }
        }
    }
    else if ( isdefined( level.lastspawnpos[ team ] ) && level.evaluatespawnforcameraselection )
    {
        testpos = level.lastspawnpos[ team ];
        closestdistsq = undefined;
        closestcam = undefined;
        
        foreach ( team, cam in level.spawncameras[ level.currentcamera[ team ] ] )
        {
            distsq = distancesquared( cam.origin, testpos );
            
            if ( !isdefined( closestcam ) || distsq < closestdistsq )
            {
                closestcam = cam;
                closestdistsq = distsq;
            }
        }
        
        spawncamera = closestcam;
    }
    else if ( level.evaluatefrontline )
    {
        frontlineinfo = calulatefrontline();
        closestdistsq = undefined;
        closestcam = undefined;
        
        foreach ( team, cam in level.spawncameras[ level.currentcamera[ team ] ] )
        {
            teamdistsq = distancesquared( cam.origin, frontlineinfo.teamavg[ team ] );
            frontlinedistsq = distancesquared( cam.origin, frontlineinfo.origin );
            
            if ( !isdefined( closestcam ) || teamdistsq < frontlinedistsq )
            {
                closestcam = cam;
                closestdistsq = teamdistsq;
            }
        }
        
        spawncamera = closestcam;
    }
    else
    {
        if ( level.usec130spawn )
        {
            while ( !isdefined( level.currentcamera[ team ] ) )
            {
                waitframe();
            }
        }
        
        if ( !isstring( level.currentcamera[ team ] ) )
        {
            spawncamera = spawnstruct();
            spawncamera.origin = level.currentcamera[ team ].origin;
            spawncamera.angles = level.currentcamera[ team ].angles;
            spawncamera.usingintermissionpos = 1;
        }
        else
        {
            spawncamera = level.spawncameras[ level.currentcamera[ team ] ][ team ];
        }
    }
    
    if ( !isdefined( spawncamera ) )
    {
        player::printspawnmessage( "spawncamera::getSpawnCamera() - self.forcedSpawnCameraRef = " + self.forcedspawncameraref + "camera was undefined, forcing default" );
        spawncamera = level.spawncameras[ "default" ][ team ];
    }
    
    self.cachedspawncamera = spawncamera;
    return spawncamera;
}

// Namespace spawncamera
// Params 0
// Checksum 0x3107f8bb, Offset: 0x1f2c
// Size: 0xb
function function_8d5ad857a3c8b7f2()
{
    return level.spawncameraoverride;
}

// Namespace spawncamera
// Params 1
// Checksum 0xc45121ef, Offset: 0x1f40
// Size: 0x17
function function_44b2ee31180f4f3e( camera )
{
    level.spawncameraoverride = camera;
}

// Namespace spawncamera
// Params 4
// Checksum 0xe2b25791, Offset: 0x1f5f
// Size: 0x6e
function addspawncamera( key, team, origin, angles )
{
    level.spawncameras[ key ][ team ] = spawnstruct();
    level.spawncameras[ key ][ team ].origin = origin;
    level.spawncameras[ key ][ team ].angles = angles;
}

// Namespace spawncamera
// Params 0
// Checksum 0xa91b510d, Offset: 0x1fd5
// Size: 0x230
function movetospawncamerainitial()
{
    self endon( #"disconnect" );
    self notify( #"hash_b7d82aba92e272f0" );
    self endon( #"hash_b7d82aba92e272f0" );
    self endon( #"tac_ops_spawn_focus_changed" );
    self endon( #"slamzoominitiated" );
    spawncamera = getspawncamera();
    spawncamerapos = spawncamera.origin;
    spawncameraang = spawncamera.angles;
    lookatpos = self.spawncameraent.origin;
    var_cab9d5635abcae0c = vectornormalize( lookatpos - spawncamera.origin );
    var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_cab9d5635abcae0c, ( 0, 0, 1 ) );
    self.spawncameraent.angles = var_a21dce04dcaeb0eb;
    dist = distance( lookatpos, spawncamerapos );
    time = dist / 3520;
    time = clamp( time, 1.5, 3 );
    self.spawncameratargetpos = spawncamerapos;
    self.spawncameratargetang = spawncameraang;
    self.spawncameratime = time;
    self.spawncameraendtime = gettime() + time * 1000;
    
    if ( !spawncamera.usingintermissionpos )
    {
        self.spawncameraent moveto( spawncamerapos, time, time * 0.3, time * 0.4 );
        self.spawncameraent rotateto( spawncameraang, time, time * 0.3, time * 0.4 );
        wait 1;
    }
    else
    {
        self.spawncameraent.origin = spawncamerapos;
        self.spawncameraent.angles = spawncameraang;
        self.deathspectatepos = spawncamerapos;
    }
    
    applythermal();
    thread startoperatorsound();
    
    if ( isdefined( self ) && isdefined( self.spawncameraent ) && !self.inspawnselection )
    {
        self earthquakeforplayer( 0.03, 15, spawncamerapos, 1000 );
    }
    
    self notify( #"hash_9700613dc001d6d9" );
}

// Namespace spawncamera
// Params 1
// Checksum 0x66a58d63, Offset: 0x220d
// Size: 0x1bf
function movetospawncamera( var_df91e643c914aec3 )
{
    self notify( #"hash_ab95eb3484b73ebe" );
    self endon( #"hash_ab95eb3484b73ebe" );
    self endon( #"disconnect" );
    self endon( #"hash_f540c8a93cb75761" );
    self endon( #"hash_cd5d52713de758c5" );
    self endon( #"slamzoominitiated" );
    spawncamera = getspawncamera();
    spawncamerapos = spawncamera.origin;
    spawncameraang = spawncamera.angles;
    
    if ( self.spawncameratargetpos == spawncamerapos && self.spawncameratargetang == spawncameraang )
    {
        return;
    }
    
    self.spawncameratargetpos = spawncamerapos;
    self.spawncameratargetang = spawncameraang;
    
    if ( !isdefined( self.spawncameraent ) )
    {
        createspawncamera();
    }
    
    self.spawncameraent moveto( spawncamerapos, 1, 0.25, 0.75 );
    self.spawncameraent rotateto( spawncameraang, 1, 0.25, 0.75 );
    wait 1;
    
    if ( isdefined( self ) && isdefined( self.spawncameraent ) && !self.inspawnselection )
    {
        driftoffset = anglestoforward( spawncameraang ) * 300;
        driftoffset *= ( 1, 1, 0 );
        self.spawncameraent moveto( spawncamerapos + driftoffset, 15, 1, 1 );
        self earthquakeforplayer( 0.03, 15, spawncamerapos, 1000 );
    }
    
    player::printspawnmessage( "spawnCamera::moveToSpawnCamera() MoveTo(): " + spawncamerapos + ", + RotateTo(): " + spawncameraang );
    self notify( #"hash_9700613dc001d6d9" );
}

// Namespace spawncamera
// Params 0
// Checksum 0x7f285856, Offset: 0x23d4
// Size: 0x1c2
function snaptospawncamera()
{
    self endon( #"disconnect" );
    
    while ( !self.cansnapcamera )
    {
        waitframe();
    }
    
    spawncamera = getspawncamera();
    self.spawncameraent dontinterpolate();
    self.spawncameraent.origin = spawncamera.origin;
    self.spawncameraent.angles = spawncamera.angles;
    
    if ( isdefined( spawncamera.prestreamorigin ) )
    {
        thread streamhint::playerstreamhintlocation( spawncamera.prestreamorigin );
    }
    
    if ( !level.updatedinit )
    {
        if ( !level.nukeinfo.detonated )
        {
            self visionsetnakedforplayer( "", 0 );
        }
    }
    
    applythermal();
    thread startoperatorsound();
    
    if ( isdefined( self ) && isdefined( self.spawncameraent ) && !self.inspawnselection )
    {
        driftoffset = anglestoforward( self.spawncameraent.angles ) * 300;
        driftoffset *= ( 1, 1, 0 );
        self.spawncameraent moveto( self.spawncameraent.origin + driftoffset, 15, 1, 1 );
        self earthquakeforplayer( 0.03, 15, self.spawncameraent.origin, 1000 );
    }
    
    player::printspawnmessage( "spawnCamera::snapToSpawnCamera() Origin: " + spawncamera.origin + ", Angles: " + spawncamera.angles );
    self notify( #"hash_9700613dc001d6d9" );
}

// Namespace spawncamera
// Params 0
// Checksum 0xda5dc23d, Offset: 0x259e
// Size: 0x8d
function endspawncamera()
{
    if ( isdefined( self.operatorsfx ) )
    {
        self clearsoundsubmix( "iw8_mp_spawn_camera" );
        self.operatorsfx stoploopsound( self.operatorsfxalias );
        self.operatorsfx delete();
        self.operatorsfx = undefined;
        self.operatorsfxalias = undefined;
    }
    
    if ( !isdefined( self.spawncameraent ) )
    {
        return;
    }
    
    if ( self.abortspawncamera )
    {
        deletespawncamera();
        return;
    }
    
    player::hideminimap( 1 );
    thread streamforslamzoomonspawn();
    runslamzoomonspawn();
}

// Namespace spawncamera
// Params 0
// Checksum 0xe52975cc, Offset: 0x2633
// Size: 0x69
function deletespawncamera()
{
    if ( !isdefined( self.spawncameraent ) )
    {
        return;
    }
    
    self cameraunlink();
    self.spawncameraent ent_manager::deregisterspawn();
    self.spawncameraent delete();
    self.spawncameraent = undefined;
    self.isusingspawnmapcamera = undefined;
    self.inspawncamera = 0;
    self.cachedspawncamera = undefined;
    self notify( #"hash_238bc8a33b3811cc" );
}

// Namespace spawncamera
// Params 1
// Checksum 0xfe6ecc6e, Offset: 0x26a4
// Size: 0x3b
function removecameraondisconnect( cameraent )
{
    self endon( #"hash_238bc8a33b3811cc" );
    self waittill( #"disconnect" );
    
    if ( isdefined( cameraent ) )
    {
        cameraent ent_manager::deregisterspawn();
        cameraent delete();
    }
}

// Namespace spawncamera
// Params 1
// Checksum 0x3eed1791, Offset: 0x26e7
// Size: 0x2c
function function_98254b86918d7396( cameraent )
{
    self endon( #"hash_238bc8a33b3811cc" );
    level waittill( #"game_ended" );
    deletespawncamera();
}

// Namespace spawncamera
// Params 0
// Checksum 0xe7932bda, Offset: 0x271b
// Size: 0x76
function streamforslamzoomonspawn()
{
    self endon( #"disconnect" );
    self waittill( #"spawncamera_start" );
    
    if ( self.prestreaminglocation )
    {
        self notify( #"hash_b70a0ed0949e821f" );
        self.prestreaminglocation = undefined;
        self notify( #"hash_2d0813a2d19b7c7e" );
    }
    
    self function_a7905e09abb76fbe( 0 );
    self predictstreamposuntilcleared( self geteye() );
    self waittill( #"hash_904dbefb2e7a4bc0" );
    self clearpredictedstreampos();
    self function_a7905e09abb76fbe( 1 );
}

// Namespace spawncamera
// Params 1
// Checksum 0xf0046f, Offset: 0x2799
// Size: 0x2c2
function runslamzoomonspawn( var_6ce8c4371dea9f11 )
{
    self endon( #"disconnect" );
    player::printspawnmessage( "spawnCamera::runSlamZoomOnSpawn() START" );
    self waittill( #"spawncamera_start" );
    player::printspawnmessage( "spawnCamera::runSlamZoomOnSpawn() spawncamera_start PASSED" );
    self notify( #"slamzoominitiated" );
    player::_freezecontrols( 1, undefined, "slamZoom" );
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "spawncamera::runSlamZoomOnSpawn()" );
    self useinvisibleplayerduringspawnselection( 1 );
    self.plotarmor = 1;
    val::set( "slamZoom", "vehicle_use", 0 );
    spectating::setdisabled();
    player::updatesessionstate( "spectator" );
    self cameralinkto( self.spawncameraent, "tag_origin", 1 );
    player::printspawnmessage( "spawnCamera::runSlamZoomOnSpawn() CameraLinkTo()" );
    handlemovetoblended();
    deletespawncamera();
    
    if ( self.team == "spectator" )
    {
        playerlogic::removefromalivecount();
        self setclientomnvar( "ui_in_spawn_camera", 0 );
        
        if ( !level.updatedinit )
        {
            if ( !level.nukeinfo.detonated )
            {
                self visionsetnakedforplayer( "", 0.5 );
            }
        }
        
        player::_freezecontrols( 0, undefined, "slamZoom" );
        self useinvisibleplayerduringspawnselection( 0 );
        self.plotarmor = 0;
        thread spectating::setspectatepermissions();
        return;
    }
    
    player::updatesessionstate( "playing" );
    
    if ( self.shouldgetnewspawnpoint )
    {
        spawnpoint = playerlogic::getspawnpoint();
        self setorigin( spawnpoint.spawnorigin );
        self setplayerangles( spawnpoint.spawnangles );
        spawnlogic::finalizespawnpointchoice( spawnpoint.spawnpoint );
        self.shouldgetnewspawnpoint = undefined;
        self.selectedspawnarea = undefined;
    }
    
    thread function_de59f844d506dff1();
    self setclientomnvar( "ui_in_spawn_camera", 0 );
    
    if ( !level.updatedinit )
    {
        if ( !level.nukeinfo.detonated )
        {
            self visionsetnakedforplayer( "", 0.5 );
        }
    }
    
    player::_freezecontrols( 0, undefined, "slamZoom" );
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "spawncamera::runSlamZoomOnSpawn()" );
    self useinvisibleplayerduringspawnselection( 0 );
    self.plotarmor = 0;
    val::reset_all( "slamZoom" );
    self notify( #"spawned_player" );
    level notify( #"player_spawned", self, self.wasrevivespawn );
    thread playerlogic::setspawnnotifyomnvar();
    self.wasrevivespawn = undefined;
    self.delayedspawnedplayernotify = undefined;
    self.spawndata = undefined;
    player::printspawnmessage( "spawnCamera::runSlamZoomOnSpawn() COMPLETE" );
    callback::callback( #"player_spawned", { #player:self, #revivespawn:0 } );
}

// Namespace spawncamera
// Params 0
// Checksum 0x45612bc9, Offset: 0x2a63
// Size: 0x1d7
function function_de59f844d506dff1()
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_52451a3506366553 ) && isdefined( self.var_52451a3506366553.origin ) && isdefined( self.var_52451a3506366553.angles ) && isdefined( self.platformoffset ) )
    {
        self setorigin( self.var_52451a3506366553.origin + rotatevector( self.platformoffset, self.var_52451a3506366553.angles ) );
    }
    
    waitframe();
    
    if ( isdefined( self.var_52451a3506366553 ) && isdefined( self.var_52451a3506366553.origin ) && isdefined( self.var_52451a3506366553.angles ) && isdefined( self.platformoffset ) )
    {
        player::printspawnmessage( "spawnCamera::runSlamZoomOnSpawn() Set origin on moving platform\nPlatform vehicle type: " + ( self.var_52451a3506366553.targetname ?? "undefined" ) + "\n\tPlatform origin: " + self.var_52451a3506366553.origin + "\n\tPlatform angles: " + self.var_52451a3506366553.angles + "\n\tPlatform offset: " + self.platformoffset + "\n\tFinal position: " + self.var_52451a3506366553.origin + rotatevector( self.platformoffset, self.var_52451a3506366553.angles ) );
        self function_b24bb8a9e05f54bc( self.var_52451a3506366553.origin + rotatevector( self.platformoffset, self.var_52451a3506366553.angles ), self.var_52451a3506366553 );
    }
    
    self.var_52451a3506366553 = undefined;
    self.platformoffset = undefined;
}

// Namespace spawncamera
// Params 1
// Checksum 0xf53bad33, Offset: 0x2c42
// Size: 0x1a4
function handlemoveto( duration )
{
    self endon( #"disconnect" );
    targetpos = self geteye();
    targetangles = self.angles;
    aerialpos = ( targetpos[ 0 ], targetpos[ 1 ], self.spawncameraent.origin[ 2 ] );
    aerialpos += anglestoforward( targetangles ) * -480;
    self.spawncameraent moveto( aerialpos, 0.75, 0.25, 0.25 );
    var_ef1c75bf83f06a03 = vectornormalize( targetpos - aerialpos );
    var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_ef1c75bf83f06a03, ( 0, 0, 1 ) );
    self.spawncameraent rotateto( var_a21dce04dcaeb0eb, 0.75, 0.25, 0.25 );
    wait 0.75;
    
    if ( !level.updatedinit )
    {
        self visionsetnakedforplayer( "tac_ops_slamzoom", 0.2 );
    }
    
    behindspawnpos = targetpos + anglestoforward( targetangles ) * -60;
    self.spawncameraent moveto( behindspawnpos, 0.5, 0.1, 0.4 );
    self.spawncameraent rotateto( targetangles, 0.7, 0.45, 0.05 );
    wait 0.5;
    thread playslamzoomflash();
    self.spawncameraent moveto( targetpos, 0.6, 0.1, 0.1 );
    wait 0.2;
    
    if ( !level.updatedinit )
    {
        self visionsetnakedforplayer( "", 0 );
    }
}

// Namespace spawncamera
// Params 1
// Checksum 0x45b8939e, Offset: 0x2dee
// Size: 0x3a6
function handlemovetoblended( duration )
{
    self endon( #"disconnect" );
    self endon( #"hash_28332b038105413d" );
    self endon( #"hash_238bc8a33b3811cc" );
    player::printspawnmessage( "spawnCamera::handleMoveTo() START" );
    
    if ( isdefined( level.var_766c421aa66752e5 ) )
    {
        self [[ level.var_766c421aa66752e5 ]]();
    }
    
    targetpos = self.spawndata.spawnorigin + ( 0, 0, 60 );
    targetangles = self.spawndata.spawnangles;
    
    if ( isdefined( self.forcespawncameraorg ) )
    {
        targetpos = self.forcespawncameraorg;
        targetangles = self.forcespawncameraang;
        self.forcespawncameraorg = undefined;
        self.forcespawncameraang = undefined;
    }
    
    anglecheck = angle_diff( self.spawncameraent.angles[ 1 ], targetangles[ 1 ] ) < 45;
    distcheck = distance2dsquared( self.spawncameraent.origin, targetpos ) > 1000000;
    thread fadeblackforgeo( targetpos );
    
    if ( !anglecheck || !distcheck )
    {
        if ( !level.updatedinit )
        {
            if ( !level.nukeinfo.detonated )
            {
                if ( !utility::isnightmap() )
                {
                    removethermal();
                    self visionsetnakedforplayer( "", 0 );
                }
                else
                {
                    self visionsetnakedforplayer( "respawn_camera_night", 0 );
                }
            }
        }
        
        wait 0.05;
        self.spawncameraent moveto( targetpos, 1, 0.1, 0.9 );
        self.spawncameraent rotateto( targetangles, 1, 0.9, 0.1 );
        player::printspawnmessage( "spawnCamera::handleMoveTo() FULL Blend Set" );
        
        if ( !level.updatedinit )
        {
            if ( !level.nukeinfo.detonated )
            {
                if ( !utility::isnightmap() )
                {
                    self visionsetnakedforplayer( "tac_ops_slamzoom", 0.8 );
                }
            }
        }
        
        wait 0.8;
        wait 0.2;
    }
    else
    {
        var_ef1c75bf83f06a03 = vectornormalize( targetpos - self.spawncameraent.origin );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_ef1c75bf83f06a03, ( 0, 0, 1 ) );
        self.spawncameraent rotateto( var_a21dce04dcaeb0eb, 0.7, 0.2, 0.2 );
        player::printspawnmessage( "spawnCamera::handleMoveTo() FIRST HALF Blend Set" );
        
        if ( !level.updatedinit )
        {
            if ( !level.nukeinfo.detonated )
            {
                if ( !utility::isnightmap() )
                {
                    removethermal();
                    self visionsetnakedforplayer( "", 0 );
                }
                else
                {
                    self visionsetnakedforplayer( "respawn_camera_night", 0 );
                }
            }
        }
        
        wait 0.05;
        self.spawncameraent moveto( targetpos, 1, 0.1, 0.9 );
        
        if ( !level.updatedinit )
        {
            if ( !level.nukeinfo.detonated )
            {
                if ( !utility::isnightmap() )
                {
                    self visionsetnakedforplayer( "tac_ops_slamzoom", 0.8 );
                }
            }
        }
        
        wait 0.5;
        self.spawncameraent rotateto( targetangles, 0.5, 0.2, 0.1 );
        player::printspawnmessage( "spawnCamera::handleMoveTo() SECOND HALF Blend Set" );
        wait 0.3;
        wait 0.2;
    }
    
    player::printspawnmessage( "spawnCamera::handleMoveTo() COMPLETE" );
    self notify( #"hash_904dbefb2e7a4bc0" );
}

// Namespace spawncamera
// Params 1
// Checksum 0xd1317649, Offset: 0x319c
// Size: 0x257
function fadeblackforgeo( targetpos )
{
    self endon( #"disconnect" );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    airtrace = trace::ray_trace( self.spawncameraent.origin, targetpos, undefined, contentoverride );
    groundtrace = trace::ray_trace( targetpos, self.spawncameraent.origin, undefined, contentoverride );
    airfrac = airtrace[ "fraction" ];
    groundfrac = groundtrace[ "fraction" ];
    var_1e1b800543e6488e = 0.11;
    
    if ( self.spawningintovehicle )
    {
        if ( isdefined( self.vehiclereserved ) && self.vehiclereserved vehicle::get_ref() == %"hash_1dd941f8f4026e3" )
        {
            if ( isdefined( self.vehiclereserved.occupants ) && self.vehiclereserved.occupants.size == 0 )
            {
                self setsoundsubmix( "iw8_mp_vehicle_spawn", 0.1 );
                thread clear_plr_vehicle_submix();
            }
        }
        else
        {
            self setsoundsubmix( "iw8_mp_vehicle_spawn", 0.1 );
            thread clear_plr_vehicle_submix();
        }
    }
    
    if ( self.spawningintovehicle || utility::isnightmap() )
    {
        self.spawningintovehicle = undefined;
        
        if ( self.vehiclespawninginto == %"vehiclebundle:light_tank_mp" )
        {
            airfrac = min( airfrac, 0.95 );
            groundfrac = 0;
            var_1e1b800543e6488e = 0.75;
        }
        else
        {
            airfrac = min( airfrac, 0.95 );
            groundfrac = 0;
        }
    }
    
    if ( self.shouldgetnewspawnpoint )
    {
        airfrac = min( airfrac, 0.5 );
        groundfrac = 0;
        thread waitandgetnewspawnpoint();
    }
    
    if ( airfrac < 1 )
    {
        if ( airfrac - 0.22 > 0 )
        {
            wait airfrac - 0.22;
        }
        
        thread playslamzoomflash( 0.1, 1 - airfrac - groundfrac + var_1e1b800543e6488e, 0.25 );
    }
}

// Namespace spawncamera
// Params 0
// Checksum 0x95d01792, Offset: 0x33fb
// Size: 0x27
function waitandgetnewspawnpoint()
{
    self endon( #"disconnect" );
    self waittill( #"fadeup_start" );
    self notify( #"hash_28332b038105413d" );
}

// Namespace spawncamera
// Params 0
// Checksum 0xa93f81d0, Offset: 0x342a
// Size: 0x21
function clear_plr_vehicle_submix()
{
    self endon( #"disconnect" );
    wait 1.5;
    self clearsoundsubmix( "iw8_mp_vehicle_spawn", 1 );
}

// Namespace spawncamera
// Params 4
// Checksum 0x173018fd, Offset: 0x3453
// Size: 0xb9
function playslamzoomflash( fadedownduration, holdduration, fadeupduration, var_c5e049932980fa60 = 0 )
{
    self endon( #"disconnect" );
    self.cansnapcamera = 0;
    
    if ( !isdefined( fadeupduration ) )
    {
        fadeupduration = 0.5;
    }
    
    self notify( #"fadedown_start" );
    
    if ( !var_c5e049932980fa60 )
    {
        game_utility::fadetoblackforplayer( self, 1, fadedownduration );
    }
    
    self notify( #"fadedown_complete" );
    self.cansnapcamera = 1;
    
    if ( holdduration > 0 )
    {
        wait holdduration;
    }
    
    self notify( #"fadeup_start" );
    
    if ( !var_c5e049932980fa60 )
    {
        game_utility::fadetoblackforplayer( self, 0, fadeupduration );
    }
    
    self notify( #"fadeup_complete" );
}

// Namespace spawncamera
// Params 3
// Checksum 0x5ba28b4e, Offset: 0x3514
// Size: 0x5b
function movecameratomappos( player, var_9956298e86821c5a, finalangles )
{
    self moveto( var_9956298e86821c5a, 1, 0.5, 0.5 );
    self rotateto( finalangles, 1, 0.5, 0.5 );
    player thread startoperatorsound();
    wait 1.1;
}

// Namespace spawncamera
// Params 0
// Checksum 0x292821ac, Offset: 0x3577
// Size: 0x76
function applythermal()
{
    if ( self.spawncameraskipthermalonce )
    {
        self.spawncameraskipthermalonce = 0;
        return;
    }
    
    if ( self.spawncameraskipthermal )
    {
        return;
    }
    
    if ( level.updatedinit )
    {
        return;
    }
    
    if ( !level.nukeinfo.detonated )
    {
        if ( utility::isnightmap() )
        {
            self visionsetnakedforplayer( "respawn_camera_night", 1 );
            return;
        }
        
        self visionsetnakedforplayer( "respawn_camera", 1 );
    }
}

// Namespace spawncamera
// Params 0
// Checksum 0x79ac78e, Offset: 0x35f5
// Size: 0x2
function removethermal()
{
    
}

// Namespace spawncamera
// Params 0
// Checksum 0x11c35791, Offset: 0x35ff
// Size: 0x100
function startoperatorsound()
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    
    if ( isdefined( self.operatorsfx ) )
    {
        return;
    }
    
    if ( level.nukeinfo.incoming )
    {
        return;
    }
    
    self.operatorsfx = spawn( "script_origin", ( 0, 0, 0 ) );
    self.operatorsfx.targetname = "startOperatorSound";
    self.operatorsfx showonlytoplayer( self );
    self setsoundsubmix( "iw8_mp_spawn_camera" );
    var_3130356482f49d5d = teams::getteamvoiceinfix( self.team );
    dronechatter = "dx_mpo_" + var_3130356482f49d5d + "op_drone_deathchatter";
    
    if ( !soundexists( dronechatter ) )
    {
        dronechatter = "dx_mpo_ruop_drone_deathchatter";
    }
    
    if ( soundexists( dronechatter ) )
    {
        self.operatorsfxalias = dronechatter;
        self.operatorsfx playloopsound( dronechatter );
    }
    
    thread endoperatorsfxondisconnect();
}

// Namespace spawncamera
// Params 0
// Checksum 0x68782744, Offset: 0x3707
// Size: 0x58
function endoperatorsfxondisconnect()
{
    self endon( #"spawned_player" );
    ent = self.operatorsfx;
    alias = self.operatorsfxalias;
    self waittill( #"disconnect" );
    
    if ( isdefined( ent ) )
    {
        ent stoploopsound( alias );
        ent delete();
    }
}

// Namespace spawncamera
// Params 2
// Checksum 0x7c419ffc, Offset: 0x3767
// Size: 0x37
function setgamemodecamera( team, cameraent )
{
    level.spawncameras[ "gamemode" ][ team ] = cameraent;
    setspawncamera( team, "gamemode" );
}

// Namespace spawncamera
// Params 2
// Checksum 0xd3e13b4a, Offset: 0x37a6
// Size: 0x23
function setspawncamera( team, ref )
{
    level.currentcamera[ team ] = ref;
}

// Namespace spawncamera
// Params 0
// Checksum 0xe159dd91, Offset: 0x37d1
// Size: 0x275
function orientdefaulttomapcenterusingmapcorners()
{
    var_145331f6f26f8006 = ( level.spawncamerastartspawnallies[ 2 ] + level.spawncamerastartspawnaxis[ 2 ] ) * 0.5;
    var_7a5bcc395feb6c07 = ( level.mapcornercenter[ 0 ], level.mapcornercenter[ 1 ], var_145331f6f26f8006 );
    
    if ( !level.spawncameras[ "default" ][ "allies" ].radiantplaced )
    {
        heightoffset = function_688df189ec4751d3();
        
        if ( heightoffset > 0 )
        {
            alliescamerapos = var_7a5bcc395feb6c07 + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + ( 0, 0, heightoffset );
        }
        else
        {
            alliescamerapos = var_7a5bcc395feb6c07 + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + ( 0, 0, 1 ) * level.spawncameradistfactor * 0.45;
        }
        
        var_8c0531a9ab4681a6 = vectornormalize( var_7a5bcc395feb6c07 - alliescamerapos );
        var_6fecdef3c6273dd5 = script::vectortoanglessafe( var_8c0531a9ab4681a6, ( 0, 0, 1 ) );
        level.spawncameras[ "default" ][ "allies" ].origin = alliescamerapos;
        level.spawncameras[ "default" ][ "allies" ].angles = var_6fecdef3c6273dd5;
    }
    
    if ( !level.spawncameras[ "default" ][ "axis" ].radiantplaced )
    {
        heightoffset = function_688df189ec4751d3();
        
        if ( heightoffset > 0 )
        {
            axiscamerapos = var_7a5bcc395feb6c07 + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + ( 0, 0, heightoffset );
        }
        else
        {
            axiscamerapos = var_7a5bcc395feb6c07 + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + ( 0, 0, 1 ) * level.spawncameradistfactor * 0.45;
        }
        
        var_8c0531a9ab4681a6 = vectornormalize( var_7a5bcc395feb6c07 - axiscamerapos );
        var_5013141d835eb090 = script::vectortoanglessafe( var_8c0531a9ab4681a6, ( 0, 0, 1 ) );
        level.spawncameras[ "default" ][ "axis" ].origin = axiscamerapos;
        level.spawncameras[ "default" ][ "axis" ].angles = var_5013141d835eb090;
    }
}

// Namespace spawncamera
// Params 0
// Checksum 0xbd721249, Offset: 0x3a4e
// Size: 0x49
function function_688df189ec4751d3()
{
    if ( level.var_337324c343ba6f9e > 0 )
    {
        return level.var_337324c343ba6f9e;
    }
    
    switch ( level.mapname )
    {
        case #"hash_c860b74f2269590c":
            return 3000;
        default:
            return 0;
    }
}

// Namespace spawncamera
// Params 0
// Checksum 0xb7309cf0, Offset: 0x3a9f
// Size: 0x377
function orientdefaulttofrontline()
{
    alliesplayers = teams::getfriendlyplayers( "allies", 1 );
    alliesavg = level.spawncamerastartspawnallies;
    
    if ( alliesplayers.size > 0 )
    {
        alliesavg = ( 0, 0, 0 );
        
        foreach ( player in alliesplayers )
        {
            alliesavg += player.origin;
        }
        
        alliesavg /= alliesplayers.size;
    }
    
    axisplayers = teams::getfriendlyplayers( "axis", 1 );
    axisavg = level.spawncamerastartspawnaxis;
    
    if ( axisplayers.size > 0 )
    {
        axisavg = ( 0, 0, 0 );
        
        foreach ( player in axisplayers )
        {
            axisavg += player.origin;
        }
        
        axisavg /= axisplayers.size;
    }
    
    frontlinevector = axisavg - alliesavg;
    var_187043a6d01c5a32 = vectornormalize( frontlinevector );
    frontlinedistsq = vectordot( frontlinevector, frontlinevector );
    
    if ( frontlinedistsq < 1048576 )
    {
        return;
    }
    
    alliescamerapos = level.mapcornercenter + var_187043a6d01c5a32 * level.spawncameradistfactor * -0.5 + ( 0, 0, 1 ) * level.spawncameradistfactor * 0.2;
    var_8c0531a9ab4681a6 = vectornormalize( level.mapcornercenter - alliescamerapos );
    var_6fecdef3c6273dd5 = script::vectortoanglessafe( var_8c0531a9ab4681a6, ( 0, 0, 1 ) );
    level.spawncameras[ "default" ][ "allies" ].origin = alliescamerapos;
    level.spawncameras[ "default" ][ "allies" ].angles = var_6fecdef3c6273dd5;
    axiscamerapos = level.mapcornercenter + var_187043a6d01c5a32 * level.spawncameradistfactor * 0.5 + ( 0, 0, 1 ) * level.spawncameradistfactor * 0.2;
    var_8c0531a9ab4681a6 = vectornormalize( level.mapcornercenter - axiscamerapos );
    var_5013141d835eb090 = script::vectortoanglessafe( var_8c0531a9ab4681a6, ( 0, 0, 1 ) );
    level.spawncameras[ "default" ][ "axis" ].origin = axiscamerapos;
    level.spawncameras[ "default" ][ "axis" ].angles = var_5013141d835eb090;
    thread debug::drawline( alliescamerapos, level.mapcornercenter, 60, ( 0, 0, 1 ) );
    thread debug::drawline( axiscamerapos, level.mapcornercenter, 60, ( 1, 0, 0 ) );
}

// Namespace spawncamera
// Params 0
// Checksum 0xc52e9005, Offset: 0x3e1e
// Size: 0x216
function calulatefrontline()
{
    alliesplayers = teams::getfriendlyplayers( "allies", 1 );
    alliesavg = getstartspawnavg( "allies" );
    
    if ( alliesplayers.size > 0 )
    {
        alliesavg = ( 0, 0, 0 );
        
        foreach ( player in alliesplayers )
        {
            alliesavg += player.origin;
        }
        
        alliesavg /= alliesplayers.size;
    }
    
    axisplayers = teams::getfriendlyplayers( "axis", 1 );
    axisavg = getstartspawnavg( "axis" );
    
    if ( axisplayers.size > 0 )
    {
        axisavg = ( 0, 0, 0 );
        
        foreach ( player in axisplayers )
        {
            axisavg += player.origin;
        }
        
        axisavg /= axisplayers.size;
    }
    
    frontlinevector = axisavg - alliesavg;
    var_187043a6d01c5a32 = vectornormalize( frontlinevector );
    frontlineinfo = spawnstruct();
    frontlineinfo.origin = ( alliesavg + axisavg ) * 0.5;
    frontlineinfo.angles = vectorcross( var_187043a6d01c5a32, ( 0, 0, 1 ) );
    frontlineinfo.teamavg = [];
    frontlineinfo.teamavg[ "allies" ] = alliesavg;
    frontlineinfo.teamavg[ "axis" ] = axisavg;
    return frontlineinfo;
}

// Namespace spawncamera
// Params 2
// Checksum 0x5e66319d, Offset: 0x403d
// Size: 0x1a7
function getstartspawnavg( team, classname )
{
    if ( isdefined( level.startspawnavg[ team ] ) )
    {
        return level.startspawnavg[ team ];
    }
    
    if ( !isdefined( level.startspawnavg ) )
    {
        level.startspawnavg = [];
    }
    
    level.startspawnavg[ team ] = ( 0, 0, 0 );
    
    if ( isdefined( classname ) )
    {
        spawns = spawnlogic::getspawnpointarray( classname );
    }
    else
    {
        spawnkey = spawnlogic::function_d5c160a4110b573e();
        
        if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
        {
            if ( team == game[ "attackers" ] )
            {
                spawns = spawnlogic::function_491fcfcdc1232e11( spawnkey, spawnlogic::function_61ba521db28762a7() );
            }
            else
            {
                spawns = spawnlogic::function_491fcfcdc1232e11( spawnkey, spawnlogic::function_3a5e3efa19e5df47() );
            }
        }
    }
    
    if ( !isdefined( spawns ) || spawns.size == 0 )
    {
        spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn_" + team + "_start" );
    }
    
    spawnavg = ( 0, 0, 0 );
    
    foreach ( s in spawns )
    {
        spawnavg += s.origin;
    }
    
    if ( spawns.size > 0 )
    {
        spawnavg /= spawns.size;
    }
    
    level.startspawnavg[ team ] = spawnavg;
    return level.startspawnavg[ team ];
}

// Namespace spawncamera
// Params 2
// Checksum 0x40e5b0b4, Offset: 0x41ed
// Size: 0x27
function angle_diff( value1, value2 )
{
    return 180 - abs( abs( value1 - value2 ) - 180 );
}

// Namespace spawncamera
// Params 0
// Checksum 0x31cfad05, Offset: 0x421d
// Size: 0x8
function function_28d94ef4997bd53e()
{
    return game_utility_mp::isgroundwarcoremode();
}

// Namespace spawncamera
// Params 5
// Checksum 0x65f0b0aa, Offset: 0x422e
// Size: 0x245
function createOrientedCameras( keyarray, team, forward, forwardoffset, heightoffset )
{
    foreach ( key in keyarray )
    {
        if ( level.useunifiedspawnselectioncameraheight )
        {
            heightoffset = spawnselection::function_ceff7e3b58ecd747();
        }
        
        if ( level.usespawnselection )
        {
            if ( !isdefined( level.spawnselectionlocations[ key ] ) )
            {
                return;
            }
            
            groundpos = level.spawnselectionlocations[ key ][ team ].anchorentity.origin;
        }
        else if ( isdefined( level.spawncameras[ key ][ team ] ) )
        {
            groundpos = level.spawncameras[ key ][ team ].origin;
        }
        else
        {
            return;
        }
        
        camerapos = groundpos + forward * forwardoffset + ( 0, 0, heightoffset );
        toground = vectornormalize( groundpos - camerapos );
        cameraang = script::vectortoanglessafe( toground, ( 0, 0, 1 ) );
        
        if ( !isdefined( level.var_81d027302ddd38f4 ) )
        {
            level.var_81d027302ddd38f4 = &calculatecameraoffset;
        }
        
        camerapos += [[ level.var_81d027302ddd38f4 ]]( team, groundpos );
        
        if ( !isdefined( level.spawncameras[ key ] ) )
        {
            level.spawncameras[ key ] = [];
        }
        
        if ( !isdefined( level.spawncameras[ key ][ team ] ) )
        {
            level.spawncameras[ key ][ team ] = spawn( "script_origin", ( 0, 0, 0 ) );
            level.spawncameras[ key ][ team ].targetname = "createOrientedCameras";
        }
        
        level.spawncameras[ key ][ team ].origin = camerapos;
        level.spawncameras[ key ][ team ].angles = cameraang;
    }
}

// Namespace spawncamera
// Params 2
// Checksum 0xdd9c91f9, Offset: 0x447b
// Size: 0x238
function calculatecameraoffset( team, objectiveorigin )
{
    switch ( level.mapname )
    {
        case #"hash_7a28db3c5928c489":
            var_9aeeec533ac4cd45 = 0.25;
            var_f776d2686256c018 = 0.35;
            break;
        case #"hash_863773b8960b3944":
            var_9aeeec533ac4cd45 = 0.25;
            var_f776d2686256c018 = 0.8;
            break;
        case #"hash_a8b272dba33a4aed":
            var_9aeeec533ac4cd45 = 0.5;
            var_f776d2686256c018 = 0.3;
            break;
        default:
            var_9aeeec533ac4cd45 = 0;
            var_f776d2686256c018 = 0;
            break;
    }
    
    len = distance( objectiveorigin, level.hqmidpoint );
    
    if ( len < 2048 )
    {
        return ( 0, 0, 0 );
    }
    
    axishqloc = level.var_a2d8d17d8f187169 ?? level.gw_objstruct.axishqloc.trigger.origin;
    allieshqloc = level.var_4211ce60d0f027fe ?? level.gw_objstruct.allieshqloc.trigger.origin;
    
    if ( team == "axis" )
    {
        var_367861ab2439dd31 = distance( axishqloc, objectiveorigin );
        fulloffset = level.hqvecttomid_axis;
    }
    else
    {
        var_367861ab2439dd31 = distance( allieshqloc, objectiveorigin );
        fulloffset = level.hqvecttomid_allies;
    }
    
    if ( var_367861ab2439dd31 < 2048 )
    {
        return ( fulloffset * var_9aeeec533ac4cd45 );
    }
    
    if ( var_367861ab2439dd31 > level.hqdisttomid )
    {
        if ( team == "axis" )
        {
            var_367861ab2439dd31 = distance( allieshqloc, objectiveorigin );
        }
        else
        {
            var_367861ab2439dd31 = distance( axishqloc, objectiveorigin );
        }
        
        percentage = 100 - var_367861ab2439dd31 * 100 / level.hqdisttomid;
        offset = fulloffset * var_f776d2686256c018 * -1 * percentage / 100;
        return offset;
    }
    
    percentage = 100 - var_367861ab2439dd31 * 100 / level.hqdisttomid;
    offset = fulloffset * var_9aeeec533ac4cd45 * percentage / 100;
    return offset;
}

// Namespace spawncamera
// Params 0
// Checksum 0x7932c5d, Offset: 0x46bb
// Size: 0x47, Type: bool
function function_7e5668ce5be4b48e()
{
    return !level.disablespawncamera && ( !flags::gameflagexists( "prematch_done" ) || flags::gameflag( "prematch_done" ) ) && !self.skipspawncamera && !level.usespawnselection;
}

// Namespace spawncamera
// Params 0
// Checksum 0x95a9bb6f, Offset: 0x470b
// Size: 0x3a
function function_769148f8af5f7546()
{
    self.var_12828bf3eee603d5 = 1;
    spawncamera = getspawncamera();
    streamorigin = streamhint::playerstreamhintlocation( spawncamera.origin );
}

