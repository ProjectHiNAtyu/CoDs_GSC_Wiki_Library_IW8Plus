// scripts\mp\common\utility\player_utility.gsc  (hash_7b1e082b2533e255.gscc) (size: 14147 Bytes / 0x3743 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdb428592 (3678569874)
// size ...... 14147 (0x3743)
// includes .. 5   (offset: 0x33af)
// strings ... 40  (offset: 0x33d7)
// dev strs .. 26  (offset: 0x3603)
// exports ... 64  (offset: 0x1e97)
// cseg ...... 0x358 + 0x1b3f (0x1e97)
// imports ... 94  (offset: 0x2897)
// animtree1 . 0   (offset: 0x3743)
// animtree2 . 0   (offset: 0x3743)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\mtx_weapon;

#namespace player_utility;

// Namespace player_utility
// Params 1
// Checksum 0x590b934e, Offset: 0x376
// Size: 0xcb
function isenemy( other )
{
    if ( level.teambased )
    {
        if ( isdefined( other.team ) && isdefined( self.team ) )
        {
            return ( other.team != self.team );
        }
        else
        {
            assertmsg( "<dev string:x24>" + ( self.team ?? "<dev string:x6f>" ) + "<dev string:x79>" + ( other.team ?? "<dev string:x6f>" ) + "<dev string:x86>" + ( other.classname ?? "<dev string:x6f>" ) );
            return 1;
        }
        
        return;
    }
    
    if ( isdefined( other.owner ) )
    {
        return ( other.owner != self );
    }
    
    return other != self;
}

// Namespace player_utility
// Params 1
// Checksum 0xb4ff7416, Offset: 0x449
// Size: 0x31
function getvehicle( var_193f2bb22e471663 )
{
    if ( vehicle::is_in_vehicle() )
    {
        return self.vehicle;
    }
    
    if ( var_193f2bb22e471663 )
    {
        return self.externalvehicle;
    }
}

// Namespace player_utility
// Params 1
// Checksum 0x99ac24d3, Offset: 0x483
// Size: 0x3e, Type: bool
function function_c0192d3e90f65e0e( player )
{
    if ( !isdefined( player ) || isbot( player ) || isagent( player ) )
    {
        return false;
    }
    
    return player vehicle::is_in_vehicle( 1 ) || isdefined( player getmovingplatformparent() );
}

// Namespace player_utility
// Params 2
// Checksum 0xf0cfd73a, Offset: 0x4ca
// Size: 0x138
function getteamarray( team, includeagents )
{
    teamarray = [];
    
    if ( !isdefined( includeagents ) || includeagents )
    {
        foreach ( player in level.characters )
        {
            if ( player.team === team )
            {
                teamarray[ teamarray.size ] = player;
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player.team === team )
            {
                teamarray[ teamarray.size ] = player;
            }
        }
    }
    
    return teamarray;
}

// Namespace player_utility
// Params 3
// Checksum 0xc6245992, Offset: 0x60b
// Size: 0x57
function _freezecontrols( frozen, force, debug )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"freezecontrols" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( frozen, force, debug );
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x9232fbf7, Offset: 0x66a
// Size: 0x37
function function_b8d64912ebafb09()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"freezeControlsDebug" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
}

// Namespace player_utility
// Params 2
// Checksum 0xc3aa0fdb, Offset: 0x6a9
// Size: 0x4d
function _freezelookcontrols( frozen, force )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"freezelookcontrols" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( frozen, force );
    }
}

// Namespace player_utility
// Params 1
// Checksum 0xc38ac73e, Offset: 0x6fe
// Size: 0x41
function getplayersuperfaction( player )
{
    playersuperfaction = 0;
    
    if ( isdefined( player.operatorcustomization ) )
    {
        playersuperfaction = player.operatorcustomization.superfaction;
    }
    
    return playersuperfaction;
}

// Namespace player_utility
// Params 3
// Checksum 0x329eb661, Offset: 0x748
// Size: 0x4b
function setthermalvision( bool, fstop, focusdistance )
{
    if ( bool )
    {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield( fstop, focusdistance, 20, 20 );
        self thermalvisionon();
        return;
    }
    
    self disablephysicaldepthoffieldscripting();
    self thermalvisionoff();
}

// Namespace player_utility
// Params 2
// Checksum 0x43a8fd94, Offset: 0x79b
// Size: 0xa4
function watchthermalinputchange( inairvehicle, var_41b147ca23b7366e )
{
    self notify( #"watch_thermal_input_change" );
    self endon( #"watch_thermal_input_change" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        var_57d1116398f2b84e = var_41b147ca23b7366e ?? getthermalswitchplayercommand( inairvehicle );
        self notifyonplayercommand( "switch_thermal_mode", var_57d1116398f2b84e );
        returnednotif = utility::waittill_any_return_no_endon_death( "input_type_changed", "thermal_handling_ended" );
        self notifyonplayercommandremove( "switch_thermal_mode", var_57d1116398f2b84e );
        
        if ( !isdefined( returnednotif ) || returnednotif == "thermal_handling_ended" )
        {
            break;
        }
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x51dd0881, Offset: 0x847
// Size: 0xe
function stopwatchingthermalinputchange()
{
    self notify( #"thermal_handling_ended" );
}

// Namespace player_utility
// Params 1
// Checksum 0xf266174b, Offset: 0x85d
// Size: 0x2b
function getthermalswitchplayercommand( inairvehicle )
{
    if ( utility::is_player_gamepad_enabled() )
    {
        if ( inairvehicle )
        {
            return "+stance";
        }
        
        return "+gostand";
    }
    
    return "nightvision";
}

// Namespace player_utility
// Params 0
// Checksum 0xdc92d20a, Offset: 0x891
// Size: 0x3a
function enabledemeanorsafe()
{
    if ( !isdefined( self.demeanorsafeenabled ) )
    {
        self.demeanorsafeenabled = 0;
    }
    
    self.demeanorsafeenabled++;
    
    if ( self.demeanorsafeenabled == 1 )
    {
        forcedemeanorsafe( 1 );
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x5e54699a, Offset: 0x8d3
// Size: 0x44
function disabledemeanorsafe()
{
    assert( self.demeanorsafeenabled > 0, "<dev string:x98>" );
    self.demeanorsafeenabled--;
    
    if ( self.demeanorsafeenabled == 0 )
    {
        self.demeanorsafeenabled = undefined;
        forcedemeanorsafe( 0 );
    }
}

// Namespace player_utility
// Params 1
// Checksum 0xb9f7dc42, Offset: 0x91f
// Size: 0x4a
function forcedemeanorsafe( bool )
{
    if ( bool && self getdemeanorviewmodel() != "safe" )
    {
        thread forcedemeanorsafeinteral( bool );
        return;
    }
    
    if ( !bool && self getdemeanorviewmodel() == "safe" )
    {
        thread forcedemeanorsafeinteral( bool );
    }
}

// Namespace player_utility
// Params 1
// Checksum 0x4b28eed5, Offset: 0x971
// Size: 0xc1
function forcedemeanorsafeinteral( bool )
{
    self endon( #"death_or_disconnect" );
    self notify( #"forcedemeanorsafeinteral" );
    self endon( #"forcedemeanorsafeinteral" );
    wassprinting = self issprinting();
    
    if ( !self.demeanorsprintdisable )
    {
        val::set( "forceDemeanor", "sprint", 0 );
        self.demeanorsprintdisable = 1;
    }
    
    if ( wassprinting )
    {
        wait 0.5;
    }
    
    if ( bool )
    {
        self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe" );
    }
    else
    {
        self setdemeanorviewmodel( "normal" );
    }
    
    wait 0.5;
    
    if ( self.demeanorsprintdisable )
    {
        val::reset_all( "forceDemeanor" );
        self.demeanorsprintdisable = undefined;
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x9c25167d, Offset: 0xa3a
// Size: 0x16
function cleardemeanorsafe()
{
    self.demeanorsafeenabled = undefined;
    self.demeanorsprintdisable = undefined;
}

// Namespace player_utility
// Params 2
// Checksum 0x1b6115d7, Offset: 0xa58
// Size: 0x6b
function playersareenemies( firstplayer, secondplayer )
{
    return level.teambased ? isdefined( firstplayer.team ) && isdefined( secondplayer.team ) && firstplayer.team != secondplayer.team : isdefined( firstplayer ) && isdefined( secondplayer ) && firstplayer != secondplayer;
}

// Namespace player_utility
// Params 2
// Checksum 0xe2eb50c8, Offset: 0xacc
// Size: 0xae
function function_2b55094fe59356fe( firstplayer, secondplayer )
{
    if ( !( isdefined( firstplayer.team ) && isdefined( secondplayer.team ) ) )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        sameteam = firstplayer.team == secondplayer.team;
        var_9e55c69066c49c17 = firstplayer.var_52a4aad8e6eafc68 != "none" && firstplayer.var_52a4aad8e6eafc68 == secondplayer.var_52a4aad8e6eafc68;
        return ( !sameteam && !var_9e55c69066c49c17 );
    }
    
    return firstplayer != secondplayer;
}

// Namespace player_utility
// Params 2
// Checksum 0xca375d87, Offset: 0xb82
// Size: 0x28
function function_51a0c300008ab56b( firstplayer, secondplayer )
{
    return isfriendly( firstplayer.team, secondplayer );
}

// Namespace player_utility
// Params 1
// Checksum 0x623084ba, Offset: 0xbb3
// Size: 0x1e
function getteamindex( teamname )
{
    return level.teamdata[ teamname ][ "index" ];
}

// Namespace player_utility
// Params 0
// Checksum 0x9445bc0e, Offset: 0xbda
// Size: 0x14, Type: bool
function playerbloodrestricted()
{
    return level.var_ce11fa8b9f14341d ?? utility::iswegameplatform();
}

// Namespace player_utility
// Params 0
// Checksum 0x1067ab09, Offset: 0xbf7
// Size: 0xc
function initdismembermentlist()
{
    level.playerswithoutdismemberment = [];
}

// Namespace player_utility
// Params 0
// Checksum 0x756845fc, Offset: 0xc0b
// Size: 0x33
function addtodismembermentlist()
{
    assert( isdefined( level.playerswithoutdismemberment ), "<dev string:xd7>" );
    
    if ( !self isdismembermentenabledforplayer() )
    {
        level.playerswithoutdismemberment[ self getxuid() ] = self;
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x6dc590b8, Offset: 0xc46
// Size: 0x28
function removefromdismembermentlist()
{
    assert( isdefined( level.playerswithoutdismemberment ), "<dev string:x113>" );
    level.playerswithoutdismemberment[ self getxuid() ] = undefined;
}

// Namespace player_utility
// Params 0
// Checksum 0x9fc2ea39, Offset: 0xc76
// Size: 0xb
function getdismembermentlist()
{
    return level.playerswithoutdismemberment;
}

// Namespace player_utility
// Params 0
// Checksum 0x28f26816, Offset: 0xc8a
// Size: 0x37
function _playerhidestack()
{
    if ( !isdefined( self.playerhidden ) )
    {
        self.playerhidden = 0;
    }
    
    if ( self.playerhidden == 0 )
    {
        function_dbe5a52a6654a982();
    }
    
    self.playerhidden++;
}

// Namespace player_utility
// Params 1
// Checksum 0xea7df90a, Offset: 0xcc9
// Size: 0x29
function function_dbe5a52a6654a982( var_eb28bb08a5c7d49c )
{
    mtx_weapon::function_61f9d1047d33e77e();
    
    if ( var_eb28bb08a5c7d49c )
    {
        self playerhide( 1 );
        return;
    }
    
    self playerhide();
}

// Namespace player_utility
// Params 1
// Checksum 0xbb48091a, Offset: 0xcfa
// Size: 0x3d
function function_9d378d725bb4831e( reason )
{
    if ( getdvarint( @"hash_b5fe5be1cf552f2e", 0 ) == 0 )
    {
        return;
    }
    
    logprint( "PlayerHide(): " + reason );
    println( "<dev string:x154>" + reason );
}

// Namespace player_utility
// Params 0
// Checksum 0xb3895699, Offset: 0xd3f
// Size: 0x52
function _playershowstack()
{
    assert( self.playerhidden > 0, "<dev string:x163>" );
    
    if ( self.playerhidden == 1 )
    {
        function_b54a1e23734ef07();
    }
    
    self.playerhidden--;
    
    if ( self.playerhidden == 0 )
    {
        self.playerhidden = undefined;
    }
}

// Namespace player_utility
// Params 1
// Checksum 0xb52f1193, Offset: 0xd99
// Size: 0x29
function function_b54a1e23734ef07( var_eb28bb08a5c7d49c )
{
    if ( var_eb28bb08a5c7d49c )
    {
        self playershow( 1 );
    }
    else
    {
        self playershow();
    }
    
    mtx_weapon::function_6e83b6d312e47cb3();
}

// Namespace player_utility
// Params 1
// Checksum 0x18bc12eb, Offset: 0xdca
// Size: 0x3d
function function_4688d689820ff1ed( reason )
{
    if ( getdvarint( @"hash_11b8360f35c60d6f", 0 ) == 0 )
    {
        return;
    }
    
    logprint( "PlayerShow(): " + reason );
    println( "<dev string:x191>" + reason );
}

// Namespace player_utility
// Params 0
// Checksum 0xb1c0a9e8, Offset: 0xe0f
// Size: 0x12
function function_278a198455b7bee6()
{
    self.playerhidden = undefined;
    self playershow();
}

// Namespace player_utility
// Params 1
// Checksum 0x2db87489, Offset: 0xe29
// Size: 0xa7
function function_bd8d26e4f03d2ca( var_f1d441fe1b436aa0 = 0 )
{
    activeanims = self getactiveanimations();
    
    foreach ( activeanim in activeanims )
    {
        self setanimtime( utility::getanim( activeanim[ "name" ] ), 0.999, undefined, var_f1d441fe1b436aa0 );
    }
}

// Namespace player_utility
// Params 0
// Checksum 0xaa769aae, Offset: 0xed8
// Size: 0x10, Type: bool
function isswimmingunderwater()
{
    return self isswimming() && self isswimunderwater();
}

// Namespace player_utility
// Params 0
// Checksum 0x69743527, Offset: 0xef1
// Size: 0x11, Type: bool
function function_2e61ffcf29281b15()
{
    return self isswimming() && !self isswimunderwater();
}

// Namespace player_utility
// Params 4
// Checksum 0xcc2594f, Offset: 0xf0b
// Size: 0x4a
function function_2a104cfb275afa1b( player, firstpersonsound, thirdpersonsound, var_d7cadebdd3516a03 )
{
    player playlocalsound( firstpersonsound );
    
    if ( var_d7cadebdd3516a03 )
    {
        player playsoundatviewheight( thirdpersonsound );
        return;
    }
    
    player playsound( thirdpersonsound, player, player );
}

// Namespace player_utility
// Params 4
// Checksum 0x3d32b79, Offset: 0xf5d
// Size: 0x10e
function function_99d180c3f0ca93b8( player, motionasset, priority, forceon )
{
    if ( !isdefined( player ) || isbot( player ) || isagent( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_eed72558c5c10954 ) )
    {
        player.var_eed72558c5c10954 = spawnstruct();
        player.var_eed72558c5c10954.asset = motionasset;
        player.var_eed72558c5c10954.priority = priority;
    }
    else if ( forceon || !isdefined( player.var_eed72558c5c10954.priority ) || player.var_eed72558c5c10954.priority <= priority )
    {
        player.var_eed72558c5c10954.asset = motionasset;
        player.var_eed72558c5c10954.priority = priority;
    }
    else
    {
        return;
    }
    
    player setcinematicmotionoverride( motionasset );
}

// Namespace player_utility
// Params 1
// Checksum 0xfafd0508, Offset: 0x1073
// Size: 0x68
function function_c14762bb6e0b4edb( player )
{
    if ( !isdefined( player ) || isbot( player ) || isagent( player ) )
    {
        return;
    }
    
    player clearcinematicmotionoverride();
    
    if ( isdefined( player.var_eed72558c5c10954 ) )
    {
        player.var_eed72558c5c10954.asset = undefined;
        player.var_eed72558c5c10954.priority = undefined;
    }
}

// Namespace player_utility
// Params 1
// Checksum 0xb79919b, Offset: 0x10e3
// Size: 0xdd
function printspawnmessage( message )
{
    /#
        if ( getdvarint( @"scr_debug_spawn_print", 0 ) == 1 )
        {
            println( "<dev string:x1a0>" + gettime() + "<dev string:x1a3>" + self.name + "<dev string:x1a6>" + message );
            println( "<dev string:x1a9>" + self.sessionstate );
            println( "<dev string:x1b9>" + self.origin );
            
            if ( isdefined( self.forcedspawncameraref ) )
            {
                println( "<dev string:x1ca>" + self.forcedspawncameraref );
            }
            
            if ( isdefined( self.spawncameraent ) )
            {
                println( "<dev string:x1e7>" + self.spawncameraent.origin );
                println( "<dev string:x205>" + self.spawncameraent.angles );
            }
        }
    #/
}

// Namespace player_utility
// Params 0
// Checksum 0x2574730, Offset: 0x11c8
// Size: 0x73
function function_f1bdd64504937120()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned" );
    
    if ( level.killcam )
    {
        while ( !isdefined( self.willshowkillcam ) )
        {
            waitframe();
        }
        
        if ( level.killcam && self.killcam )
        {
            utility::waittill_any( "killcam_ended", "killcam_canceled", "abort_killcam" );
        }
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x79d2a6f6, Offset: 0x1243
// Size: 0xe4
function function_230204b1e2875ed0()
{
    self endon( #"disconnect" );
    assert( self.liveragdoll );
    
    if ( getdvarint( @"killswitch_cyberrevivedeathcamenabled", 1 ) == 0 )
    {
        cameraentity = function_232d44374eb29c6a( 0, 0 );
        self.willshowkillcam = undefined;
        wait getdvarfloat( @"scr_death_scene_time", level.gamemodebundle.deathcamtime );
        function_f1bdd64504937120();
        self allowspectateteam( self.team, 1 );
        self cameraunlink();
        cameraentity delete();
        return;
    }
    
    self allowspectateallteams( 0 );
    self.willshowkillcam = undefined;
    wait getdvarfloat( @"scr_death_scene_time", level.gamemodebundle.deathcamtime );
    function_f1bdd64504937120();
    self allowspectateteam( self.team, 1 );
}

// Namespace player_utility
// Params 2
// Checksum 0x2b7ab08a, Offset: 0x132f
// Size: 0xc9
function function_232d44374eb29c6a( var_a9427f67bd9fcf83 = 0, var_53b8cce0afd54244 )
{
    cameradata = function_cdda5b59decded4e( self, self.attacker, var_53b8cce0afd54244 );
    
    if ( !isdefined( cameradata ) )
    {
        return;
    }
    
    cameraentity = spawn( "script_model", cameradata.origin );
    cameraentity setmodel( "tag_origin" );
    cameraentity.angles = cameradata.angles;
    cameraentity.data = cameradata;
    playermover = self getmovingplatformparent();
    
    if ( isdefined( playermover ) )
    {
        cameraentity linkto( playermover );
    }
    
    self allowspectateallteams( 0 );
    self cameralinkto( cameraentity, "tag_origin", 1, var_a9427f67bd9fcf83 );
    return cameraentity;
}

// Namespace player_utility
// Params 3
// Checksum 0x7e89ef6f, Offset: 0x1401
// Size: 0x269
function function_cdda5b59decded4e( victim, attacker, var_53b8cce0afd54244 )
{
    assert( isent( victim ) );
    assert( isent( attacker ) );
    deathpos = undefined;
    
    if ( isdefined( victim.origin ) )
    {
        deathpos = victim.origin;
    }
    else if ( isdefined( victim.lastdeathpos ) )
    {
        deathpos = victim.lastdeathpos;
    }
    
    if ( !isdefined( deathpos ) )
    {
        logstring( "Undefined deathPos for death ragdoll 3rd person camera." );
        return;
    }
    
    if ( victim == attacker || !isdefined( attacker.origin ) )
    {
        forwardvector = anglestoforward( victim.angles );
        forwardvector = vectornormalize2( forwardvector );
    }
    else
    {
        forwardvector = vectornormalize( deathpos - attacker.origin );
    }
    
    baseangles = generateaxisanglesfromforwardvector( forwardvector, ( 0, 0, 1 ) );
    cameraposition = deathpos + ( 0, 0, 12 );
    cameradistance = 200;
    stepangle = 30;
    maxsteps = 360 / stepangle;
    validpositions = [];
    
    for ( i = 0; i < maxsteps ; i++ )
    {
        stepvector = anglestoforward( baseangles + ( 0, stepangle * i, 0 ) );
        startposition = deathpos + ( 0, 0, 12 );
        endposition = deathpos + stepvector * cameradistance + ( 0, 0, 150 );
        trace = trace::sphere_trace( startposition, endposition, 2, [ victim, attacker ] );
        
        if ( trace[ "fraction" ] > 0.99 )
        {
            validpositions[ validpositions.size ] = trace[ "position" ];
            
            if ( !var_53b8cce0afd54244 )
            {
                break;
            }
        }
    }
    
    if ( validpositions.size > 0 )
    {
        cameraposition = validpositions[ 0 ];
    }
    
    victimdirection = vectornormalize( deathpos - cameraposition );
    cameradata = spawnstruct();
    cameradata.origin = cameraposition;
    cameradata.angles = vectortoangles( victimdirection );
    cameradata.distance = cameradistance;
    cameradata.validpositions = validpositions;
    return cameradata;
}

// Namespace player_utility
// Params 2
// Checksum 0x88c90f2a, Offset: 0x1673
// Size: 0x1cb
function updatesessionstate( sessionstate, statusicon )
{
    assert( sessionstate == "<dev string:x223>" || sessionstate == "<dev string:x22b>" || sessionstate == "<dev string:x230>" || sessionstate == "<dev string:x23a>" || sessionstate == "<dev string:x247>" );
    
    if ( self.liveragdoll )
    {
        if ( self.sessionstate == "playing_but_spectating" && ( sessionstate == "dead" || sessionstate == "spectator" ) )
        {
            printspawnmessage( "player::updateSessionState() didn't not update because we are in liveRagdoll" );
            return;
        }
        
        if ( sessionstate == "playing_but_spectating" )
        {
            thread function_230204b1e2875ed0();
        }
    }
    
    switch ( sessionstate )
    {
        case #"hash_6e223a17d0eb5015":
        case #"hash_7135993aa112803d":
            statusicon = "";
            break;
        case #"hash_9430ae82e6671e2a":
        case #"hash_cf14c509efeb3c87":
            if ( level.doing_winners_circle )
            {
                statusicon = "";
            }
            else if ( level.numlifelimited )
            {
                if ( self.tagavailable )
                {
                    statusicon = "hud_status_dogtag";
                }
                else if ( self.revivetriggeravailable )
                {
                    if ( self.statusicon == "hud_status_revive_or" )
                    {
                        statusicon = "hud_status_revive_or";
                    }
                    else
                    {
                        statusicon = "hud_status_revive_wh";
                    }
                }
                else
                {
                    statusicon = "hud_status_dead";
                }
            }
            else
            {
                statusicon = "hud_status_dead";
            }
            
            break;
    }
    
    if ( !isdefined( statusicon ) )
    {
        statusicon = "";
    }
    
    self.sessionstate = sessionstate;
    self.statusicon = statusicon;
    ui_session_state = sessionstate == "playing_but_spectating" ? "spectator" : sessionstate;
    self setclientomnvar( "ui_session_state", ui_session_state );
    printspawnmessage( "player::updateSessionState() " + sessionstate );
}

// Namespace player_utility
// Params 1
// Checksum 0xc55400a3, Offset: 0x1846
// Size: 0x57
function clearkillcamstate( var_824c9d962d9cde74 )
{
    self.forcespectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.archiveusepotg = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    
    if ( !var_824c9d962d9cde74 )
    {
        thread function_d14fd7480f28bba9();
    }
}

// Namespace player_utility
// Params 0, eflags: 0x4
// Checksum 0xccf19932, Offset: 0x18a5
// Size: 0x6c
function private function_d14fd7480f28bba9()
{
    self endon( #"disconnect" );
    self notify( #"reset_killcam_player" );
    self endon( #"reset_killcam_player" );
    wait 0.05;
    restorepitch = 0;
    restoreroll = 0;
    var_2f9e1349ec2a4b90 = self getplayerangles();
    restoreyaw = var_2f9e1349ec2a4b90[ 1 ];
    self setplayerangles( ( restorepitch, restoreyaw, restoreroll ) );
}

// Namespace player_utility
// Params 4
// Checksum 0xb7bd8483, Offset: 0x1919
// Size: 0x33
function script_getplayersinradius( origin, radius, desiredteam, excludeent )
{
    return getplayersinradius( origin, radius, undefined, undefined, excludeent, desiredteam );
}

// Namespace player_utility
// Params 3
// Checksum 0xb67c13b0, Offset: 0x1955
// Size: 0xa5
function getplayerlookatpos( player, ignoreents, contentoverride )
{
    starttrace = player getcamerathirdperson() ? player getcamerathirdpersonorigin() : player getvieworigin();
    endtrace = starttrace + anglestoforward( player getplayerangles() ) * 20000;
    trace = trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
    endpos = undefined;
    
    if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
    {
        endpos = trace[ "position" ];
    }
    
    return endpos;
}

// Namespace player_utility
// Params 2
// Checksum 0x7183c2ac, Offset: 0x1a03
// Size: 0xa4
function _visionsetnaked( visionset, time )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isai( player ) )
        {
            continue;
        }
        
        player visionsetnakedforplayer( visionset, time );
    }
}

// Namespace player_utility
// Params 2
// Checksum 0xd98ac633, Offset: 0x1ab0
// Size: 0x90
function waittillrecoveredhealth( time, interval )
{
    self endon( #"death_or_disconnect" );
    fullhealthtime = 0;
    
    if ( !isdefined( interval ) )
    {
        interval = 0.05;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    while ( true )
    {
        if ( self.health != self.maxhealth )
        {
            fullhealthtime = 0;
        }
        else
        {
            fullhealthtime += interval;
        }
        
        wait interval;
        
        if ( self.health == self.maxhealth && fullhealthtime >= time )
        {
            break;
        }
    }
}

// Namespace player_utility
// Params 0
// Checksum 0x836f877a, Offset: 0x1b49
// Size: 0x3f
function hidehudenable()
{
    if ( !isdefined( self.ui_hudhidden ) )
    {
        self.hidehudenabled = 0;
    }
    
    if ( self.hidehudenabled == 0 )
    {
        self setclientomnvar( "ui_hide_hud", 1 );
    }
    
    self.hidehudenabled++;
}

// Namespace player_utility
// Params 0
// Checksum 0xd0e1c19d, Offset: 0x1b90
// Size: 0x3f
function hidehuddisable()
{
    assert( self.hidehudenabled > 0, "<dev string:x25e>" );
    
    if ( self.hidehudenabled == 1 )
    {
        self setclientomnvar( "ui_hide_hud", 0 );
    }
    
    self.hidehudenabled--;
}

// Namespace player_utility
// Params 0
// Checksum 0x653c0167, Offset: 0x1bd7
// Size: 0x18
function hidehudclear()
{
    self.hidehudenabled = undefined;
    self setclientomnvar( "ui_hide_hud", 0 );
}

// Namespace player_utility
// Params 1
// Checksum 0x72246a19, Offset: 0x1bf7
// Size: 0x27, Type: bool
function function_cdedd9a19069ca4c( reviver )
{
    return reviver.revivingteammate && !reviver.var_e0a3e97f1aea8404;
}

// Namespace player_utility
// Params 2
// Checksum 0xbe60249b, Offset: 0x1c27
// Size: 0x66, Type: bool
function isfriendly( teamtocheck, var_5b415c263e1d902 )
{
    assert( isdefined( var_5b415c263e1d902 ), "<dev string:x28c>" );
    
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( !isplayer( var_5b415c263e1d902 ) && !isdefined( var_5b415c263e1d902.team ) )
    {
        return false;
    }
    
    if ( teamtocheck != var_5b415c263e1d902.team )
    {
        return false;
    }
    
    return true;
}

// Namespace player_utility
// Params 0
// Checksum 0xaabb0919, Offset: 0x1c96
// Size: 0x7
function _jumpbuttonpressed()
{
    return self jumpbuttonpressed();
}

// Namespace player_utility
// Params 0
// Checksum 0xc6d8f837, Offset: 0x1ca6
// Size: 0x7
function function_a1e9194b63d531a4()
{
    return self superbuttonpressed();
}

// Namespace player_utility
// Params 1
// Checksum 0x39e8428d, Offset: 0x1cb6
// Size: 0x3f
function getPlayerGuid( player )
{
    if ( isplayer( player ) && isdefined( player.guid ) )
    {
        return player.guid;
    }
    
    assertmsg( "<dev string:x2b5>" );
    return 0;
}

// Namespace player_utility
// Params 1
// Checksum 0x6ba72b98, Offset: 0x1cfe
// Size: 0x54, Type: bool
function function_cb195d25060312a( override_vehicle )
{
    vehicle = override_vehicle ?? getvehicle();
    
    if ( vehicle )
    {
        return ( vehicle.occupants[ "driver" ] == self || vehicle.occupants[ "gunner" ] == self );
    }
    
    return false;
}

// Namespace player_utility
// Params 1
// Checksum 0x4871a96d, Offset: 0x1d5b
// Size: 0xbd, Type: bool
function function_36e9830807a5007( override_vehicle )
{
    vehicle = override_vehicle ?? getvehicle();
    
    if ( vehicle )
    {
        foreach ( site, occupant in vehicle.occupants )
        {
            if ( site == "driver" || site == "gunner" )
            {
                continue;
            }
            
            if ( occupant == self )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace player_utility
// Params 1
// Checksum 0x1570894, Offset: 0x1e21
// Size: 0x59, Type: bool
function function_452d7021e128ff08( vehicle )
{
    vehicleowner = vehicle.owner;
    
    if ( !vehicleowner )
    {
        return false;
    }
    
    return vehicleowner.team == self.team && vehicleowner.sessionsquadid == self.sessionsquadid;
}

// Namespace player_utility
// Params 0
// Checksum 0x645c0ab0, Offset: 0x1e83
// Size: 0x13
function getplayerclientnum()
{
    return isplayer( self ) ? self getplayerclientnum() : undefined;
}

