// scripts\mp\br\gametypes\br_dom_quest.gsc  (hash_68a65b5f7ed82477.gscc) (size: 9941 Bytes / 0x26d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66cdad3b (1724755259)
// size ...... 9941 (0x26d5)
// includes .. 11  (offset: 0x2339)
// strings ... 57  (offset: 0x2391)
// dev strs .. 3   (offset: 0x26b1)
// exports ... 24  (offset: 0x175d)
// cseg ...... 0x587 + 0x11d6 (0x175d)
// imports ... 69  (offset: 0x1b1d)
// animtree1 . 0   (offset: 0x26d5)
// animtree2 . 0   (offset: 0x26d5)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace br_dom_quest;

// Namespace br_dom_quest
// Params 1
// Checksum 0x37b51be9, Offset: 0x5a5
// Size: 0x104
function getcontractdata( data )
{
    level.domprops = spawnstruct();
    level.domprops.capturetime = getdvarint( @"hash_d1ba52fb82cf7653", 30 );
    level.domprops.time = getdvarint( @"hash_be42880c860992ec", 240 );
    level.domprops.captureradius = getdvarint( @"hash_51711b96c9b3eec0", 128 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_dom_accept" ] = "mission_mission_dom_accept_secure";
    game[ "dialog" ][ "mission_dom_success" ] = "mission_mission_dom_success";
    data.funcs[ "onInit" ] = &dom_oninit;
    data.funcs[ "onTeamAssigned" ] = &dom_onteamassigned;
    data.funcs[ "bestRespawnMissionOrigin" ] = &function_30e1c8272073cbc1;
    setupdom();
}

// Namespace br_dom_quest
// Params 0
// Checksum 0xf3f859a6, Offset: 0x6b1
// Size: 0x33, Type: bool
function dom_oninit()
{
    placement = self.tablet function_18d37e50e55021b0();
    
    if ( !isdefined( placement ) )
    {
        return false;
    }
    
    self.reservedplacement = placement;
    return true;
}

// Namespace br_dom_quest
// Params 0
// Checksum 0x253fcbbf, Offset: 0x6ed
// Size: 0x152
function dom_onteamassigned()
{
    br_contract_manager::function_87e10a6e85d45d58( "domination" );
    time = level.domprops.time;
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    thread dom_watchtimer( time );
    
    if ( !isdefined( self.reservedplacement ) )
    {
        placement = self.tablet function_18d37e50e55021b0();
        
        if ( !isdefined( placement ) )
        {
            return;
        }
        
        self.reservedplacement = placement;
    }
    
    function_e7470c761c3bf1af( self.reservedplacement );
    domflagupdateicons();
    br_contract_manager::function_87e10a6e85d45d58( "domination" );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player thread hud_message::showsplash( "br_domination_quest_start_team" );
    }
    
    level thread br_public::brleaderdialogteam( "mission_dom_accept", self.team, 1 );
    print( "<dev string:x2b>" );
}

// Namespace br_dom_quest
// Params 1
// Checksum 0xd2072503, Offset: 0x847
// Size: 0x65
function function_7ed7f879861c5657( success )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    self.domflag gameobjects::releaseid();
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    br_contract_manager::endcontract( success );
}

// Namespace br_dom_quest
// Params 1
// Checksum 0x451354ea, Offset: 0x8b4
// Size: 0x72
function dom_watchtimer( time )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    wait time;
    params = spawnstruct();
    params.intvar = 0;
    br_contract_manager::function_5c7e547ccc13711b( "br_domination_quest_timer_expired", params );
    level thread br_public::brleaderdialogteam( "mission_gen_fail", self.team, 1 );
    thread function_7ed7f879861c5657( 0 );
}

// Namespace br_dom_quest
// Params 0
// Checksum 0xcd46f710, Offset: 0x92e
// Size: 0x192
function function_18d37e50e55021b0()
{
    locations = arrayrandomize( utility::getstructarray( "dmz_dom_tower", "script_noteworthy" ) );
    var_b5eefdf655fda772 = br_circle::getmintimetillpointindangercircle( self.origin );
    placement = undefined;
    bestlocindex = undefined;
    var_49bdf85b1540dcb2 = 12000;
    
    foreach ( i, node in locations )
    {
        dist = distance2d( node.origin, self.origin );
        
        if ( dist > var_49bdf85b1540dcb2 )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_4d410ddbe3d207be = br_circle::getmintimetillpointindangercircle( node.origin );
            
            if ( var_4d410ddbe3d207be < var_b5eefdf655fda772 )
            {
                continue;
            }
            
            traveltime = dist / 190;
            var_4d410ddbe3d207be -= traveltime;
            
            if ( var_4d410ddbe3d207be < 30 )
            {
                continue;
            }
            
            var_ac99ac222f6bbc72 = 0;
            
            if ( dist < 8000 )
            {
                if ( dist < 6000 )
                {
                    var_ac99ac222f6bbc72 = 6000 - dist;
                }
            }
            else
            {
                var_ac99ac222f6bbc72 = dist - 8000;
            }
            
            if ( var_ac99ac222f6bbc72 < var_49bdf85b1540dcb2 )
            {
                var_49bdf85b1540dcb2 = var_ac99ac222f6bbc72;
                bestlocindex = i;
                placement = node;
                
                if ( var_ac99ac222f6bbc72 <= 0 )
                {
                    break;
                }
            }
        }
    }
    
    return placement;
}

// Namespace br_dom_quest
// Params 1
// Checksum 0xa7d04eeb, Offset: 0xac9
// Size: 0x1e6
function function_e7470c761c3bf1af( placement )
{
    domflagorigin = placement.origin;
    radius = level.domprops.captureradius;
    trigger = spawn( "trigger_radius", domflagorigin, 0, int( radius ), int( level.br_domheight ) );
    trigger.angles = placement.angles;
    trigger.script_label = "_a";
    level.setdomscriptablepartstatefunc = &domflag_setdomscriptablepartstate;
    domflag = obj_dom::setupobjective( trigger );
    domflag.flagmodel setmodel( "lm_domination_point_01" );
    
    /#
        domflag.debugtype = "<dev string:x40>";
    #/
    
    domflag.onuse = &domflag_onuse;
    domflag.onbeginuse = &domflag_onbeginuse;
    domflag.onuseupdate = &domflag_onuseupdate;
    domflag.onenduse = &domflag_onenduse;
    domflag.usecondition = &domflag_usecondition;
    domflag.lockupdatingicons = 1;
    domflag.checkuseconditioninthink = 1;
    objidpoolmanager::update_objective_position( domflag.objidnum, domflag.curorigin + ( 0, 0, 60 ) );
    level.flagcapturetime = level.domprops.capturetime;
    domflag gameobjects::setusetime( level.flagcapturetime );
    self.lastcircletick = -1;
    self.domflag = domflag;
    self.curorigin = domflag.curorigin;
    domflag.task = self;
    self.radius = radius;
}

// Namespace br_dom_quest
// Params 0
// Checksum 0xcc47d113, Offset: 0xcb7
// Size: 0xd3
function domflagupdateicons()
{
    objective_showtoplayersinmask( self.domflag.objidnum );
    objective_removeallfrommask( self.domflag.objidnum );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( !player br_public::isplayeringulag() )
        {
            objective_addclienttomask( self.domflag.objidnum, player );
        }
    }
}

// Namespace br_dom_quest
// Params 1
// Checksum 0x2b4d5f69, Offset: 0xd92
// Size: 0x26
function domflag_hideiconfromplayer( player )
{
    objective_removeclientfrommask( self.domflag.objidnum, player );
}

// Namespace br_dom_quest
// Params 1
// Checksum 0xedeb3d83, Offset: 0xdc0
// Size: 0x26
function domflag_showicontoplayer( player )
{
    objective_addclienttomask( self.domflag.objidnum, player );
}

// Namespace br_dom_quest
// Params 0
// Checksum 0x73050887, Offset: 0xdee
// Size: 0x16
function domflagupdateiconsframeend()
{
    self endon( #"removed" );
    waittillframeend();
    domflagupdateicons();
}

// Namespace br_dom_quest
// Params 0
// Checksum 0xbdc1709, Offset: 0xe0c
// Size: 0x147
function deletedomflaggameobject()
{
    foreach ( vis in self.domflag.visuals )
    {
        vis delete();
    }
    
    if ( isdefined( self.domflag.flagmodel ) )
    {
        self.domflag.flagmodel delete();
    }
    
    if ( isdefined( self.domflag.scriptable ) )
    {
        self.domflag.scriptable delete();
    }
    
    if ( isdefined( self.domflag.trigger ) )
    {
        self.domflag.trigger delete();
        self.domflag.trigger = undefined;
    }
    
    self.domflag thread gameobjectreleaseid_delayed();
    self.domflag notify( #"deleted" );
}

// Namespace br_dom_quest
// Params 0
// Checksum 0x75b67fe7, Offset: 0xf5b
// Size: 0xf
function gameobjectreleaseid_delayed()
{
    wait 0.1;
    gameobjects::releaseid();
}

// Namespace br_dom_quest
// Params 0
// Checksum 0x9aaf2aa, Offset: 0xf72
// Size: 0x1c3
function setupdom()
{
    if ( isdefined( level.br_domheight ) )
    {
        return;
    }
    
    level.disableinitplayergameobjects = 0;
    level.br_domheight = 120;
    level.iconneutral = "waypoint_captureneutral_br";
    level.iconcapture = "waypoint_capture_br";
    level.icondefend = "waypoint_defend_br";
    level.icondefending = "waypoint_defending_br";
    level.iconcontested = "waypoint_contested_br";
    level.icontaking = "waypoint_taking_br";
    level.iconlosing = "waypoint_losing_br";
    level.iconovertime = "icon_waypoint_ot";
    _setdomflagiconinfo( "icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0 );
    _setdomflagiconinfo( "icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0 );
    _setdomflagiconinfo( "icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0 );
}

// Namespace br_dom_quest
// Params 4
// Checksum 0xca8604c3, Offset: 0x113d
// Size: 0x72
function _setdomflagiconinfo( name, colors, string, pulses )
{
    level.waypointcolors[ name ] = colors;
    level.waypointbgtype[ name ] = 1;
    level.waypointstring[ name ] = string;
    level.waypointshader[ name ] = "ui_mp_br_mapmenu_icon_dom_objective";
    level.waypointpulses[ name ] = pulses;
}

// Namespace br_dom_quest
// Params 4
// Checksum 0xd0dad2db, Offset: 0x11b7
// Size: 0x74
function domflag_onuseupdate( team, progress, change, capplayer )
{
    if ( progress < 1 && !level.gameended )
    {
        play_spotrep_capture_sfx( progress, team );
    }
    
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        self.didstatusnotify = 1;
    }
}

// Namespace br_dom_quest
// Params 1
// Checksum 0x6762618, Offset: 0x1233
// Size: 0x184
function domflag_onbeginuse( credit_player )
{
    if ( !self.obj_icon_revealed )
    {
        self.obj_icon_revealed = 1;
        level thread br_contract_manager::utilflare_shootflare( self.curorigin, "dom" );
        playerteam = player::getteamarray( credit_player.team );
        playersinrange = player_utility::script_getplayersinradius( self.curorigin, 7800, undefined, playerteam );
        
        foreach ( player in playersinrange )
        {
            if ( isalive( player ) )
            {
                player thread hud_message::showsplash( "br_domination_quest_alert" );
            }
        }
        
        playersquad = teams::getfriendlyplayers( credit_player.team, 0 );
        
        foreach ( teammate in playersquad )
        {
            teammate notify( #"hash_fe8368d98cacf961" );
        }
    }
}

// Namespace br_dom_quest
// Params 1
// Checksum 0xb092c5ea, Offset: 0x13bf
// Size: 0x1b1
function domflag_onuse( credit_player )
{
    if ( self.task.team == credit_player.team )
    {
        missionid = br_contract_manager::getquestindex( "domination" );
        br_contract_manager::questrewardcirclepeek( self.task.team );
        rewards = self.task br_contract_manager::function_7d7e225a8f9c9222( "dom" );
        
        if ( rewards && rewards[ 0 ] )
        {
            self.task br_contract_manager::function_1f816e3c3465df7e( "br_domination_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "dom" ), rewards[ 0 ] );
        }
        
        self.task br_contract_manager::function_ba80ad6a1d946b85( 8, missionid, credit_player );
        level thread br_public::brleaderdialogteam( "mission_dom_success", self.task.team, 1, 1 );
        self.task.rewardorigin = self.flagmodel.origin;
        self.task.rewardangles = self.flagmodel.angles;
        self.task.result = "success";
        self.task thread function_7ed7f879861c5657( 1 );
        return;
    }
    
    self.task br_contract_manager::function_5c7e547ccc13711b( "br_domination_quest_failure" );
    level thread br_public::brleaderdialogteam( "mission_gen_fail", self.task.team, 1 );
    self.task.result = "fail";
}

// Namespace br_dom_quest
// Params 3
// Checksum 0xf896ffdd, Offset: 0x1578
// Size: 0x29
function domflag_onenduse( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
}

// Namespace br_dom_quest
// Params 2
// Checksum 0xdf2a25b2, Offset: 0x15a9
// Size: 0x8d
function play_spotrep_capture_sfx( progress, team )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var_8eb35fb703d61a67 = "";
        progress = int( floor( progress * 10 ) );
        var_8eb35fb703d61a67 = "uin_cer_cappoint_tick_0" + progress;
        self.visuals[ 0 ] playsoundtoteam( var_8eb35fb703d61a67, team );
    }
}

// Namespace br_dom_quest
// Params 3
// Checksum 0xb759c3da, Offset: 0x163e
// Size: 0xa1
function domflag_setdomscriptablepartstate( part, state, statemod )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
        case #"hash_3699ac6c262c25ea":
        case #"hash_86bf1a776a7c4cbe":
            return 0;
        default:
            state = "using";
            
            if ( isdefined( statemod ) )
            {
                state += statemod;
            }
            
            self.scriptable setscriptablepartstate( part, state );
            
            if ( part == "pulse" )
            {
                self.scriptable setscriptablepartstate( "flag", state );
            }
            
            return 1;
    }
}

// Namespace br_dom_quest
// Params 1
// Checksum 0x69135ceb, Offset: 0x16e7
// Size: 0x43, Type: bool
function domflag_usecondition( player )
{
    return self.task.team == player.team && !self.task.ended;
}

// Namespace br_dom_quest
// Params 0
// Checksum 0x7447c4a6, Offset: 0x1733
// Size: 0x2a
function function_30e1c8272073cbc1()
{
    var_7237854e3be197ca = self.domflag.curorigin;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

