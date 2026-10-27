// scripts\mp\gametypes\obj_captureflag.gsc  (hash_3fddda92c991755e.gscc) (size: 15475 Bytes / 0x3c73 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2465e256 (610656854)
// size ...... 15475 (0x3c73)
// includes .. 19  (offset: 0x3817)
// strings ... 60  (offset: 0x38af)
// dev strs .. 2   (offset: 0x3c5b)
// exports ... 32  (offset: 0x2407)
// cseg ...... 0x49c + 0x1f6b (0x2407)
// imports ... 122 (offset: 0x2907)
// animtree1 . 0   (offset: 0x3c73)
// animtree2 . 0   (offset: 0x3c73)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\wm;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\weapons;

#namespace obj_captureflag;

// Namespace obj_captureflag
// Params 0
// Checksum 0xcdd0576, Offset: 0x4ba
// Size: 0x103
function updategametypedvars()
{
    level.winrule = dvars::dvarintvalue( "winRule", 0, 0, 1 );
    level.showenemycarrier = dvars::dvarintvalue( "showEnemyCarrier", 1, 0, 6 );
    level.idleresettime = dvars::dvarfloatvalue( "idleResetTime", 30, 0, 60 );
    level.capturecondition = dvars::dvarintvalue( "captureCondition", 0, 0, 1 );
    level.pickuptime = dvars::dvarfloatvalue( "pickupTime", 0.5, 0, 10 );
    level.returntime = dvars::dvarfloatvalue( "returnTime", 0.5, -1, 25 );
    level.carryzonespeedscale = dvars::dvarfloatvalue( "carryZoneSpeedScale", 0.6, 0, 1 );
    level.flagswitchtp = dvars::dvarintvalue( "flagSwitchTP", 0, 0, 1 );
    level.requiredflag = dvars::dvarintvalue( "requiredFlag", 1, 1, 10 );
    level.enableflagcheckpoint = dvars::dvarintvalue( "enableFlagCheckPoint", 0, 0, 1 );
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xcb785e1a, Offset: 0x5c5
// Size: 0xa6
function function_a646823403efa442( flagpoints )
{
    if ( flagpoints.size == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    captureflags = [];
    
    foreach ( flagpoint in flagpoints )
    {
        captureflags[ captureflags.size ] = createteamflag( flagpoint );
    }
    
    return captureflags;
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x5d3f74d8, Offset: 0x674
// Size: 0x98
function function_2c5532fdbfaf542e()
{
    foreach ( captureflag in level.zone.captureflags )
    {
        captureflag gameobjects::allowcarry( "none" );
        captureflag gameobjects::setvisibleteam( "none" );
    }
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x19da31cb, Offset: 0x714
// Size: 0xbf
function function_c4c6124c369e4564()
{
    foreach ( captureflag in level.zone.captureflags )
    {
        objective_state( captureflag.objidnum, "current" );
        captureflag gameobjects::allowcarry( "enemy" );
        captureflag gameobjects::setvisibleteam( "any" );
        wm_objectives::function_c8300b794535b6fa( captureflag.objectivekey );
    }
}

// Namespace obj_captureflag
// Params 1
// Checksum 0x342f349f, Offset: 0x7db
// Size: 0x296
function createteamflag( flagpoint )
{
    if ( isdefined( flagpoint ) )
    {
        if ( isdefined( flagpoint.target ) )
        {
            ent = utility::getstruct( flagpoint.target, "targetname" );
            flagorigin = ent.origin;
            flagangles = ent.angles;
        }
        else
        {
            flagorigin = flagpoint.origin;
        }
    }
    else
    {
        assertmsg( "<dev string:x3f>" );
    }
    
    trigger = flagpoint;
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", flagorigin );
    visuals[ 0 ].angles = flagangles;
    visuals[ 0 ] setmodel( level.flagmodel );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 0 ] setteaminhuddatafromteamname( game[ "defenders" ] );
    visuals[ 0 ] setnonstick( 1 );
    teamflag = gameobjects::createcarryobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 32 ) );
    teamflag.iconname = trigger.objectivekey;
    teamflag.objectivekey = trigger.objectivekey;
    teamflag gameobjects::setteamusetime( "enemy", level.pickuptime );
    teamflag gameobjects::allowcarry( "none" );
    teamflag gameobjects::allowuse( "enemy" );
    teamflag gameobjects::setvisibleteam( "none" );
    teamflag gameobjects::setobjectivestatusicons( "waypoint_defend_flag", "waypoint_take_flag" );
    teamflag objidpoolmanager::objective_set_play_intro( teamflag.objidnum, 0 );
    teamflag objidpoolmanager::objective_set_play_outro( teamflag.objidnum, 0 );
    teamflag gameobjects::registercarryobjectpickupcheck( &flagpickupchecks );
    teamflag gameobjects::setusehinttext( &"mp_jup_skydiving/press_to_take_device" );
    teamflag.trigger setuseprioritymax();
    teamflag.allowweapons = 1;
    teamflag.onpickup = &onpickup;
    teamflag.onpickupfailed = &onpickupfailed;
    teamflag.ondrop = &ondrop;
    teamflag.onreset = &onreset;
    teamflag gameobjects::function_a8c99f0b8d97b750( [ visuals[ 0 ] ], trigger, 1, 80, 0 );
    teamflag.manualdropdata.var_a6d8c99992dec978 = 1;
    objective_state( teamflag.objidnum, "done" );
    return teamflag;
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xb60b08b7, Offset: 0xa7a
// Size: 0x263
function createflagzone( flagzone )
{
    trigger = flagzone;
    visuals = [];
    capzone = gameobjects::createuseobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 85 ), undefined );
    capzone.objectivekey = trigger.objectivekey;
    capzone.iconname = trigger.objectivekey;
    capzone gameobjects::allowuse( "none" );
    capzone gameobjects::setvisibleteam( "none" );
    capzone gameobjects::setobjectivestatusicons( "waypoint_defend_PDS", "waypoint_install_PDS" );
    capzone gameobjects::setusetime( 0.01 );
    capzone gameobjects::setusehinttext( &"mp_jup_skydiving/press_to_deploy_device" );
    capzone.trigger setuseprioritymax();
    capzone.trigger setuseholdduration( "duration_none" );
    objective_state( capzone.objidnum, "done" );
    capzone.onuse = &onuse;
    capzone.oncantuse = &oncantuse;
    var_a1b8191b1715d31d = spawn( "script_model", capzone.curorigin );
    var_a1b8191b1715d31d.angles = trigger.angles;
    var_a1b8191b1715d31d makeusable();
    var_a1b8191b1715d31d sethintdisplayrange( 256 );
    var_a1b8191b1715d31d sethintdisplayfov( 360 );
    var_a1b8191b1715d31d setuserange( 128 );
    var_a1b8191b1715d31d setusefov( 360 );
    var_a1b8191b1715d31d sethintonobstruction( "show" );
    var_a1b8191b1715d31d setcursorhint( "HINT_NOBUTTON" );
    var_a1b8191b1715d31d sethintstring( &"mp_jup_wm/need_filter" );
    capzone.var_a1b8191b1715d31d = var_a1b8191b1715d31d;
    slots = utility::getstructarray( trigger.target, "targetname" );
    
    foreach ( slot in slots )
    {
        slot.isdeployed = 0;
    }
    
    capzone.var_a3c478853dec78ef = slots;
    return capzone;
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xd879648b, Offset: 0xce6
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

// Namespace obj_captureflag
// Params 3
// Checksum 0x4811c106, Offset: 0xd2d
// Size: 0x26a
function onpickup( player, playervo, defused )
{
    self notify( #"picked_up" );
    player notify( #"obj_picked_up" );
    level notify( #"filter_picked_up" );
    team = player.pers[ "team" ];
    
    if ( team == game[ "attackers" ] )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
        objidpoolmanager::objective_set_progress( self.objidnum, 0 );
        player attachflag();
        player.carryingflag = self;
        player.playerstreakspeedscale = -0.4;
        
        if ( !player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", player.playerstreakspeedscale );
            player common::function_a6a0ecdb12c8e351( 2 );
        }
        
        player weapons::updatemovespeedscale();
        player setclientomnvar( "ui_filter_player_hud_icon", 1 );
        player function_d050f8bfe7e5e74b();
        player function_1173a70bc467b654();
        thread hud_util::teamplayercardsplash( "jup_wm_picked_up_filter", player );
        
        if ( level.flagswitchtp )
        {
            player setcamerathirdperson( 1 );
        }
        
        if ( game_utility::getgametype() == "wm" )
        {
            player playsoundtoteam( "jup_mode_wm_pds_ally_pickup", player.team, undefined, player );
            player playsoundtoteam( "jup_mode_wm_pds_enemy_pickup", team_utility::getotherteam( player.team )[ 0 ], undefined, player );
            var_76ffb54c45e40a13 = 30000;
            
            if ( !isdefined( player.var_467963ee16e82745 ) || gettime() - player.var_467963ee16e82745 >= var_76ffb54c45e40a13 )
            {
                player.var_467963ee16e82745 = gettime();
                player points::doscoreevent( #"hash_b2a15ba5409c3d64" );
            }
            
            thread function_4d3c92494e2ac2d2( player );
        }
        
        if ( isdefined( level.showenemycarrier ) )
        {
            if ( level.showenemycarrier == 0 )
            {
                gameobjects::setvisibleteam( "none" );
            }
            else
            {
                gameobjects::setvisibleteam( "any" );
            }
        }
        
        gameobjects::setownerteam( game[ "attackers" ] );
        gameobjects::allowuse( "none" );
        gameobjects::setobjectivestatusicons( "waypoint_escort_flag", "waypoint_kill_flag" );
        self.previouscarrier = player;
        self.iscarrying = 1;
        player thread function_ed47ade7b1a50b19( level.zone );
    }
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xbe0a3e9, Offset: 0xf9f
// Size: 0x11b
function function_4d3c92494e2ac2d2( player )
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    self endon( #"gameobject_deleted" );
    player endon( #"death_or_disconnect" );
    player endon( #"flag_drop" );
    nearbyrange = getdvarint( @"hash_d2747c44489080dc", 300 );
    
    while ( true )
    {
        wait 5;
        attackers = teams::getteamdata( game[ "attackers" ], "alivePlayers" );
        nearbyattackers = function_6a293b884c444a20( attackers, player.origin, nearbyrange );
        
        foreach ( player in nearbyattackers )
        {
            player points::doscoreevent( #"hash_f95e4d51587aea39" );
        }
    }
}

// Namespace obj_captureflag
// Params 1
// Checksum 0x15d191af, Offset: 0x10c2
// Size: 0xc
function onpickupfailed( player )
{
    
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x3ee3da86, Offset: 0x10d7
// Size: 0x16c
function returnflag()
{
    homeorigin = undefined;
    
    if ( level.enableflagcheckpoint )
    {
        checkpoints = level.zone.flagcheckpoints;
        flagzone = level.zone.flagzone;
        mindistance = 99999999;
        
        foreach ( checkpoint in checkpoints )
        {
            var_a35fa47d8ad97dc9 = distance2d( self.trigger.origin, flagzone.trigger.origin );
            var_51ed27316694b3cd = distance2d( checkpoint.origin, flagzone.trigger.origin );
            
            if ( var_51ed27316694b3cd < var_a35fa47d8ad97dc9 )
            {
                continue;
            }
            
            if ( var_a35fa47d8ad97dc9 < mindistance )
            {
                mindistance = var_a35fa47d8ad97dc9;
                nearestcheckpoint = checkpoint;
            }
        }
        
        if ( isdefined( nearestcheckpoint ) )
        {
            homeorigin = nearestcheckpoint.origin;
        }
    }
    
    gameobjects::returnhome( homeorigin );
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xd2575841, Offset: 0x124b
// Size: 0x244
function ondrop( player )
{
    gameobjects::setownerteam( game[ "defenders" ] );
    gameobjects::allowuse( "enemy" );
    gameobjects::setvisibleteam( "any" );
    self notify( #"dropped" );
    gameobjects::setobjectivestatusallicons( "waypoint_defend_flag", "waypoint_take_flag" );
    
    if ( game_utility::getgametype() == "wm" )
    {
        player playsoundtoteam( "jup_mode_wm_pds_ally_drop", player.team, undefined, player );
        player playsoundtoteam( "jup_mode_wm_pds_enemy_drop", team_utility::getotherteam( player.team )[ 0 ], undefined, player );
    }
    
    if ( isdefined( player ) )
    {
        if ( !player::isreallyalive( player ) )
        {
            player.carryobject.previouscarrier = undefined;
        }
        
        if ( isdefined( player.carryflag ) )
        {
            player.carryingflag = undefined;
            player detachflag();
            player notify( #"flag_drop" );
            level notify( #"filter_drop" );
            player setclientomnvar( "ui_filter_player_hud_icon", 0 );
            player function_cf85c45df6a6270a();
            player function_4e06bf3dcb5f2fc1();
        }
        
        player.playerstreakspeedscale = 0;
        
        if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            player common::function_65276d8c156b2ec9( 2 );
        }
        
        player weapons::updatemovespeedscale();
        
        if ( level.flagswitchtp )
        {
            player setcamerathirdperson( 0 );
        }
        
        thread hud_util::teamplayercardsplash( "jup_wm_dropped_filter", player );
        self.iscarrying = 0;
        volumes = level.zone.subzones;
        
        if ( isdefined( volumes ) )
        {
            foreach ( volume in volumes )
            {
                if ( ispointinvolume( player.origin, volume ) )
                {
                    returnflag();
                    return;
                }
            }
        }
    }
    
    if ( level.idleresettime > 0 )
    {
        thread returnaftertime();
    }
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x71eed71c, Offset: 0x1497
// Size: 0xf0
function returnaftertime()
{
    level endon( #"complete_capture_flag" );
    self endon( #"picked_up" );
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    objidpoolmanager::objective_set_progress( self.objidnum, 1 );
    currentwaittime = 0;
    
    while ( currentwaittime < level.idleresettime )
    {
        waitframe();
        
        if ( !isdefined( self.claimteam ) || self.claimteam == "none" )
        {
            currentwaittime += level.framedurationseconds;
        }
        
        progress = 1 - currentwaittime / level.idleresettime;
        progress = clamp( progress, 0, 1 );
        objidpoolmanager::objective_set_progress( self.objidnum, progress );
    }
    
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    returnflag();
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x691a9e11, Offset: 0x158f
// Size: 0x43
function onreset()
{
    gameobjects::setownerteam( game[ "defenders" ] );
    gameobjects::allowcarry( "enemy" );
    gameobjects::setvisibleteam( "any" );
    gameobjects::setobjectivestatusicons( "waypoint_defend_flag", "waypoint_take_flag" );
    self.previouscarrier = undefined;
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xc309bd15, Offset: 0x15da
// Size: 0x136
function onuse( player )
{
    if ( !level.gameended )
    {
        if ( player vehicle::is_in_vehicle() || !isdefined( player.carryingflag ) )
        {
            return;
        }
        
        player notify( #"objective", "captured" );
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        player.playerstreakspeedscale = 0;
        
        if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            player common::function_65276d8c156b2ec9( 2 );
        }
        
        player weapons::updatemovespeedscale();
        
        if ( level.flagswitchtp )
        {
            player setcamerathirdperson( 0 );
        }
        
        player.carryingflag function_b68dcb49c3c3ed8e( self );
        player.carryingflag = undefined;
        player notify( #"place_flag" );
        player setclientomnvar( "ui_filter_player_hud_icon", 0 );
        
        if ( game_utility::getgametype() == "wm" )
        {
            player playsoundtoteam( "jup_mode_wm_pds_ally_placed", player.team, undefined, player );
            player playsoundtoteam( "jup_mode_wm_pds_enemy_placed", team_utility::getotherteam( player.team )[ 0 ], undefined, player );
        }
    }
}

// Namespace obj_captureflag
// Params 1
// Checksum 0x93b394b3, Offset: 0x1718
// Size: 0x5e6
function function_b68dcb49c3c3ed8e( flagzone )
{
    if ( isdefined( level.flagbase ) )
    {
        var_330441cf8853d795 = level.flagbase gettagorigin( "tag_turret03" );
        var_3f19a1ab2e49506b = level.flagbase gettagangles( "tag_turret03" );
        completedflag = spawnscriptable( "jup_skydiving_military_pdsf", var_330441cf8853d795, var_3f19a1ab2e49506b );
        
        if ( isdefined( level.pdsfarr ) )
        {
            level.pdsfarr[ level.pdsfarr.size ] = completedflag;
            
            foreach ( pdsf in level.pdsfarr )
            {
                pdsf utility::function_7c10ea82c1e305b8( "model", "deploy" );
            }
        }
    }
    
    gameobjects::disableobject();
    self.completed = 1;
    self notify( #"manual_drop_cleanup" );
    self notify( #"gameobject_deleted" );
    objectivekey = self.trigger.objectivekey;
    level.objectives[ objectivekey ].complete = 1;
    level.zone.completeflagcount++;
    level notify( #"flag_placed" );
    level.defendersrespawndelay = getdvarint( @"hash_1017300f1352f2fa", 0 );
    points::function_40522c040a4e7b1( game[ "attackers" ], #"hash_a11b33bfb5de050c" );
    wm_objectives::function_52ac9e302f5b92ef( objectivekey );
    
    if ( level.zone.completeflagcount >= level.requiredflag )
    {
        foreach ( flag in level.zone.captureflags )
        {
            if ( !flag.completed )
            {
                objectivekey = flag.trigger.objectivekey;
                level.objectives[ objectivekey ].complete = 1;
                flag gameobjects::disableobject();
                flag notify( #"manual_drop_cleanup" );
                wm_objectives::function_52ac9e302f5b92ef( objectivekey );
            }
        }
        
        foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
        {
            if ( isdefined( player.carryflag ) )
            {
                player.carryingflag = undefined;
                player detachflag();
                player notify( #"flag_drop" );
                player setclientomnvar( "ui_filter_player_hud_icon", 0 );
                player function_cf85c45df6a6270a();
                player.playerstreakspeedscale = 0;
                
                if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
                {
                    player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
                    player common::function_65276d8c156b2ec9( 2 );
                }
                
                player weapons::updatemovespeedscale();
            }
        }
        
        objectivekey = flagzone.trigger.objectivekey;
        flagzone gameobjects::allowuse( "none" );
        flagzone gameobjects::setvisibleteam( "none" );
        flagzone gameobjects::disableobject();
        flagzone.var_a1b8191b1715d31d disableplayeruseforallplayers();
        level.objectives[ objectivekey ].complete = 1;
        wm_objectives::function_52ac9e302f5b92ef( objectivekey );
        var_759faa37ebc6a2b2 = getdvarint( @"hash_c940b4d3990293e5", -30 );
        level.extratime = max( 0, float( game_utility::gettimepassed() / 1000 ) + float( var_759faa37ebc6a2b2 ) );
        level.zone.currentphase = "capture_zone";
        level notify( #"complete_capture_flag" );
        hud_message::notifyteam( "jup_wm_install_filter_attacker", "jup_wm_install_filter_defender", game[ "attackers" ] );
        
        if ( isdefined( level.var_b656bf028db861b7 ) )
        {
            [[ level.var_b656bf028db861b7 ]]();
        }
        else
        {
            level.flagbase utility::function_7c10ea82c1e305b8( "model", "green" );
        }
        
        var_842eed1a6764560d = level.zone.flag_capture_zone;
        var_842eed1a6764560d gameobjects::enableobject();
        var_842eed1a6764560d gameobjects::setownerteam( game[ "defenders" ] );
        var_842eed1a6764560d gameobjects::allowuse( "enemy" );
        objective_state( var_842eed1a6764560d.objidnum, "current" );
        var_842eed1a6764560d gameobjects::function_17f4ed788c5de22e( 1 );
        var_842eed1a6764560d gameobjects::function_d7c8d276bc014cae( 1 );
        wm_objectives::function_c8300b794535b6fa( var_842eed1a6764560d.objectivekey );
        wm_utility::function_4afa4860425f25d1();
        level thread wm_objectives::function_d0714e0e77c5d0fc( var_842eed1a6764560d );
        level notify( #"hash_deefa06d1c6c7931" );
        
        if ( isdefined( level.flagbase ) )
        {
            level.flagbase.nextstate = "charging_1";
            waitframe();
            level.flagbase utility::function_7c10ea82c1e305b8( "model", "charging_1" );
            level.flagbase utility::function_7c10ea82c1e305b8( "beam", "on" );
            level.flagbase.nextstate = "charged_1";
        }
    }
}

// Namespace obj_captureflag
// Params 0
// Checksum 0xe8a5b8a0, Offset: 0x1d06
// Size: 0x2a
function attachflag()
{
    self attach( level.carryflag, "tag_shield_back", 1 );
    self.carryflag = level.carryflag;
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x1eb3d864, Offset: 0x1d38
// Size: 0x20
function detachflag()
{
    self detach( self.carryflag, "tag_shield_back" );
    self.carryflag = undefined;
}

// Namespace obj_captureflag
// Params 1
// Checksum 0x6638a06, Offset: 0x1d60
// Size: 0x15, Type: bool
function flagpickupchecks( player )
{
    return !player vehicle::is_in_vehicle();
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xbe14e9ab, Offset: 0x1d7e
// Size: 0xc
function oncantuse( player )
{
    
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x89c87c73, Offset: 0x1d92
// Size: 0x1f
function function_51f68acf123a57b7()
{
    return level.requiredflag - level.zone.completeflagcount;
}

// Namespace obj_captureflag
// Params 1
// Checksum 0xb5c437b5, Offset: 0x1dba
// Size: 0x1e7
function function_ed47ade7b1a50b19( zone )
{
    level endon( #"game_ended" );
    self endon( #"place_flag" );
    self endon( #"flag_drop" );
    self endon( #"death_or_disconnect" );
    volumes = zone.subzones;
    
    if ( isdefined( level.var_a67a2b75a3f21bb5 ) )
    {
        volumes = level.var_a67a2b75a3f21bb5;
    }
    
    if ( getdvarint( @"hash_2dd79d3cf0785c5b", 0 ) )
    {
        return;
    }
    
    /#
        level thread wm::debug_oob_triggers( volumes );
    #/
    
    player = self;
    player.var_ccd98f03f654db7e = gettime();
    player.var_1d5a97d14b0e37ac = 0;
    firststart = 1;
    
    while ( true )
    {
        foreach ( volume in volumes )
        {
            if ( function_b9b4e652147a039f( player, volume ) )
            {
                if ( !player.var_1d5a97d14b0e37ac )
                {
                    player.var_24d5d93db667022d = gettime();
                    
                    if ( player.var_24d5d93db667022d - player.var_ccd98f03f654db7e > 5000 || firststart )
                    {
                        player.var_8732e800b9fb9ff8 = 5;
                    }
                }
                
                player.var_1d5a97d14b0e37ac = 1;
                player wm::function_9bfc55558d794540();
                player wm_ui::function_e50496e135055296( player.var_8732e800b9fb9ff8 );
                player thread function_37512452e387a1e6( volume );
                
                if ( player.var_1d5a97d14b0e37ac )
                {
                    player thread function_315ff38f6a67af0d( player.var_8732e800b9fb9ff8 );
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace obj_captureflag
// Params 2
// Checksum 0x79c56a60, Offset: 0x1fa9
// Size: 0x51, Type: bool
function function_b9b4e652147a039f( player, volume )
{
    if ( player.var_1d5a97d14b0e37ac )
    {
        return false;
    }
    
    if ( !player istouching( volume ) )
    {
        return false;
    }
    
    if ( !player wm::function_ce09e729d21e7354( volume ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace obj_captureflag
// Params 1
// Checksum 0x727a5eda, Offset: 0x2003
// Size: 0x65
function function_37512452e387a1e6( volume )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"place_flag" );
    player endon( #"flag_drop" );
    
    while ( player istouching( volume ) )
    {
        waitframe();
    }
    
    if ( player.var_1d5a97d14b0e37ac )
    {
        player function_7503d9e71ca954a0();
    }
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x9e49389b, Offset: 0x2070
// Size: 0xa8
function function_7503d9e71ca954a0()
{
    player = self;
    player.var_1d5a97d14b0e37ac = 0;
    player.var_ccd98f03f654db7e = gettime();
    
    if ( isdefined( player.var_8732e800b9fb9ff8 ) && isdefined( player.var_24d5d93db667022d ) )
    {
        player.var_8732e800b9fb9ff8 = int( player.var_8732e800b9fb9ff8 - ( player.var_ccd98f03f654db7e - player.var_24d5d93db667022d ) / 1000 );
    }
    
    player notify( #"hash_5c24a0262241ca3d" );
    player setclientomnvar( "ui_out_of_bounds_type", 0 );
    player setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace obj_captureflag
// Params 1
// Checksum 0x27ec988c, Offset: 0x2120
// Size: 0x6f
function function_315ff38f6a67af0d( time )
{
    player = self;
    player endon( #"hash_5c24a0262241ca3d" );
    player endon( #"death_or_disconnect" );
    
    if ( time > 0 )
    {
        wait time;
    }
    
    player.oobdeath = 1;
    player damage::_suicide( undefined, 1 );
    player.oobdeath = undefined;
    player.var_1d5a97d14b0e37ac = 0;
}

// Namespace obj_captureflag
// Params 0
// Checksum 0xd143894, Offset: 0x2197
// Size: 0x8d
function function_d050f8bfe7e5e74b()
{
    foreach ( captureflag in level.zone.captureflags )
    {
        captureflag.trigger disableplayeruse( self );
    }
}

// Namespace obj_captureflag
// Params 0
// Checksum 0xc023e6b, Offset: 0x222c
// Size: 0x8d
function function_cf85c45df6a6270a()
{
    foreach ( captureflag in level.zone.captureflags )
    {
        captureflag.trigger enableplayeruse( self );
    }
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x6d21ea4e, Offset: 0x22c1
// Size: 0x48
function function_4e06bf3dcb5f2fc1()
{
    level.zone.flagzone.trigger disableplayeruse( self );
    level.zone.flagzone.var_a1b8191b1715d31d enableplayeruse( self );
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x55c3df7e, Offset: 0x2311
// Size: 0x48
function function_1173a70bc467b654()
{
    level.zone.flagzone.trigger enableplayeruse( self );
    level.zone.flagzone.var_a1b8191b1715d31d disableplayeruse( self );
}

// Namespace obj_captureflag
// Params 0
// Checksum 0x34f411db, Offset: 0x2361
// Size: 0xa6
function function_44de5ed6e0cad306()
{
    level.zone.flagzone.var_a1b8191b1715d31d disableplayeruseforallplayers();
    
    foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
    {
        player function_4e06bf3dcb5f2fc1();
    }
}

