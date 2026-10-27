// scripts\mp\gametypes\obj_grindzone.gsc  (hash_4055de5045bf885a.gscc) (size: 5649 Bytes / 0x1611 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xefe3f8e4 (4024695012)
// size ...... 5649 (0x1611)
// includes .. 3   (offset: 0x14c5)
// strings ... 21  (offset: 0x14dd)
// dev strs .. 0   (offset: 0x1611)
// exports ... 25  (offset: 0xbcd)
// cseg ...... 0x1b2 + 0xa1b (0xbcd)
// imports ... 44  (offset: 0xfb5)
// animtree1 . 0   (offset: 0x1611)
// animtree2 . 0   (offset: 0x1611)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\gameobjects;

#namespace obj_grindzone;

// Namespace obj_grindzone
// Params 0
// Checksum 0x9c5cd42e, Offset: 0x1d0
// Size: 0x9
function init()
{
    setuphudelements();
}

// Namespace obj_grindzone
// Params 0
// Checksum 0xa971cdac, Offset: 0x1e1
// Size: 0x48
function setuphudelements()
{
    level.iconneutral = "waypoint_bank_";
    level.iconcapture = "waypoint_scoring_foe_";
    level.icondefend = "waypoint_scoring_friend_";
    level.iconenemycontested = "waypoint_contested_";
    level.iconfriendlycontested = "waypoint_contested_";
}

// Namespace obj_grindzone
// Params 3
// Checksum 0xe1c0a9c3, Offset: 0x231
// Size: 0x1df
function setupobjective( trigger, var_ee9ac91f30ff8e1, skipobjid )
{
    if ( isdefined( trigger.objectivekey ) )
    {
        objectivekey = trigger.objectivekey;
    }
    else
    {
        objectivekey = trigger.script_label;
    }
    
    triggerorigin = fixuptriggerorigin( trigger, objectivekey );
    clonetrigger = spawn( "trigger_radius", triggerorigin, 0, 90, 128 );
    clonetrigger.script_label = trigger.script_label;
    trigger = clonetrigger;
    visuals[ 0 ] = spawn( "script_model", triggerorigin );
    visuals[ 0 ].angles = trigger.angles;
    
    if ( isdefined( trigger.iconname ) )
    {
        iconname = trigger.iconname;
    }
    else
    {
        iconname = trigger.script_label;
    }
    
    zone = gameobjects::createuseobject( "neutral", trigger, visuals, ( 0, 0, 90 ), var_ee9ac91f30ff8e1, skipobjid );
    zone gameobjects::allowuse( "enemy" );
    zone gameobjects::setusetime( level.bankcapturetime );
    zone gameobjects::cancontestclaim( 1 );
    zone gameobjects::mustmaintainclaim( 1 );
    zone.tagsdeposited = 0;
    zone.disabled = 0;
    zone.objectivekey = objectivekey;
    zone.iconname = iconname;
    
    if ( !skipobjid )
    {
        zone gameobjects::setvisibleteam( "any" );
        zone setobjectivecallbacks();
        objective_setlabel( zone.objidnum, &"mp_ingame_only/pillage_depot_open" );
        zone utility::delaythread( 1, &setneutral );
    }
    
    return zone;
}

// Namespace obj_grindzone
// Params 0
// Checksum 0xf980a35e, Offset: 0x419
// Size: 0xb4
function setobjectivecallbacks()
{
    self.onbeginuse = &zone_onusebegin;
    self.onuseupdate = &zone_onuseupdate;
    self.onenduse = &zone_onuseend;
    self.onuse = &zone_onuse;
    self.onunoccupied = &zone_onunoccupied;
    self.oncontested = &zone_oncontested;
    self.onuncontested = &zone_onuncontested;
    self.id = "domFlag";
    gameobjects::pinobjiconontriggertouch();
    self.claimgracetime = level.bankcapturetime * 1000;
    self.scriptable = setupscriptablevisuals( self.visuals[ 0 ].origin, self );
}

// Namespace obj_grindzone
// Params 1
// Checksum 0x2061a86a, Offset: 0x4d5
// Size: 0x2d
function getreservedobjid( scriptlabel )
{
    if ( scriptlabel == "a" )
    {
        reservedid = 0;
    }
    else
    {
        reservedid = 1;
    }
    
    return reservedid;
}

// Namespace obj_grindzone
// Params 2
// Checksum 0xfd85bff5, Offset: 0x50b
// Size: 0x13c
function setupscriptablevisuals( visorigin, zone )
{
    tracestart = visorigin + ( 0, 0, 32 );
    traceend = visorigin + ( 0, 0, -32 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    zone.baseeffectpos = trace[ "position" ];
    zone.baseeffectpos = fixupscriptableorigin( zone );
    upangles = vectortoangles( trace[ "normal" ] );
    modifiedupangles = function_55010077fda691df( zone, upangles );
    zone.baseeffectforward = anglestoforward( modifiedupangles );
    scriptable = spawn( "script_model", zone.baseeffectpos );
    scriptable setmodel( "grind_flag_scriptable" );
    scriptable.angles = generateaxisanglesfromforwardvector( zone.baseeffectforward, scriptable.angles );
    return scriptable;
}

// Namespace obj_grindzone
// Params 2
// Checksum 0xb2eaba83, Offset: 0x650
// Size: 0x6b
function fixuptriggerorigin( trigger, objectivekey )
{
    origin = trigger.origin;
    
    switch ( level.mapname )
    {
        case #"hash_52f1fb3b7304621d":
            if ( objectivekey == "b" )
            {
                origin += ( 0, 0, -100 );
            }
            
            break;
    }
    
    return origin;
}

// Namespace obj_grindzone
// Params 1
// Checksum 0x857df4, Offset: 0x6c4
// Size: 0xa0
function fixupscriptableorigin( zone )
{
    origin = zone.baseeffectpos;
    
    switch ( level.mapname )
    {
        case #"hash_a62df42a13dad323":
            if ( zone.objectivekey == "b" )
            {
                origin += ( 0, 0, 10 );
            }
            
            break;
        case #"hash_81b84d832a53ee33":
            if ( zone.objectivekey == "b" )
            {
                origin += ( 0, 0, 10 );
            }
            
            break;
    }
    
    return origin;
}

// Namespace obj_grindzone
// Params 2
// Checksum 0x1f4f2d94, Offset: 0x76d
// Size: 0xcc
function function_55010077fda691df( zone, upangles )
{
    angles = upangles;
    
    switch ( level.mapname )
    {
        case #"hash_81b84d832a53ee33":
            if ( zone.objectivekey == "b" )
            {
                angles = ( 270, 0, 0 );
            }
            
            break;
        case #"hash_52f1fb3b7304621d":
            if ( zone.objectivekey == "b" )
            {
                angles = ( 275, 90, 0 );
            }
            
            break;
        case #"hash_b0aeb2ff7f22592":
            if ( zone.objectivekey == "a" )
            {
                angles = ( 270, 0, 0 );
            }
            
            break;
    }
    
    return angles;
}

// Namespace obj_grindzone
// Params 0
// Checksum 0x711f5484, Offset: 0x842
// Size: 0x48
function activatezone()
{
    self.onbeginuse = undefined;
    self.onuseupdate = undefined;
    self.onenduse = undefined;
    self.onuse = undefined;
    self.onunoccupied = undefined;
    self.oncontested = undefined;
    self.onuncontested = undefined;
}

// Namespace obj_grindzone
// Params 0
// Checksum 0x5ddc8253, Offset: 0x892
// Size: 0x48
function deactivatezone()
{
    self.onbeginuse = undefined;
    self.onuseupdate = undefined;
    self.onenduse = undefined;
    self.onuse = undefined;
    self.onunoccupied = undefined;
    self.oncontested = undefined;
    self.onuncontested = undefined;
}

// Namespace obj_grindzone
// Params 0
// Checksum 0xbc0b4656, Offset: 0x8e2
// Size: 0x22
function setneutral()
{
    gameobjects::setownerteam( "neutral" );
    setneutralicons();
    updateflagstate( "idle", 0 );
}

// Namespace obj_grindzone
// Params 1
// Checksum 0x3a90e510, Offset: 0x90c
// Size: 0x28
function zone_onusebegin( player )
{
    self.didstatusnotify = 0;
    thread gameobjects::useobjectdecay( player.team );
}

// Namespace obj_grindzone
// Params 4
// Checksum 0xed36b477, Offset: 0x93c
// Size: 0x64
function zone_onuseupdate( team, progress, change, capplayer )
{
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        if ( !isagent( capplayer ) )
        {
            updateflagcapturestate( team );
        }
        
        self.didstatusnotify = 1;
    }
}

// Namespace obj_grindzone
// Params 3
// Checksum 0x10367f4e, Offset: 0x9a8
// Size: 0x63
function zone_onuseend( team, player, success )
{
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        setneutralicons();
        updateflagstate( "idle", 0 );
        return;
    }
    
    setteamicons();
    updateflagstate( ownerteam, 0 );
}

// Namespace obj_grindzone
// Params 1
// Checksum 0xbab1fcf4, Offset: 0xa13
// Size: 0x3d
function zone_onuse( player )
{
    capture_team = player.team;
    setteamicons();
    updateflagstate( capture_team, 0 );
    gameobjects::setownerteam( capture_team );
}

// Namespace obj_grindzone
// Params 0
// Checksum 0xb2d6bdb0, Offset: 0xa58
// Size: 0x10
function zone_onunoccupied()
{
    setneutralicons();
    setneutral();
}

// Namespace obj_grindzone
// Params 0
// Checksum 0xf905e13b, Offset: 0xa70
// Size: 0x16
function zone_oncontested()
{
    setcontestedicons();
    updateflagstate( "contested", 0 );
}

// Namespace obj_grindzone
// Params 1
// Checksum 0xf730c02e, Offset: 0xa8e
// Size: 0x6f
function zone_onuncontested( lastclaimteam )
{
    ownerteam = gameobjects::getownerteam();
    
    if ( lastclaimteam == "none" || ownerteam == "neutral" )
    {
        setneutralicons();
    }
    else
    {
        setteamicons();
    }
    
    flagstate = ownerteam == "neutral" ? "idle" : ownerteam;
    updateflagstate( flagstate, 0 );
}

// Namespace obj_grindzone
// Params 0
// Checksum 0xfecd677d, Offset: 0xb05
// Size: 0x12
function setneutralicons()
{
    gameobjects::setobjectivestatusicons( level.iconneutral );
}

// Namespace obj_grindzone
// Params 0
// Checksum 0x18071ba9, Offset: 0xb1f
// Size: 0x1b
function setteamicons()
{
    gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
}

// Namespace obj_grindzone
// Params 0
// Checksum 0x79274e78, Offset: 0xb42
// Size: 0x12
function setcontestedicons()
{
    gameobjects::setobjectivestatusicons( level.iconfriendlycontested );
}

// Namespace obj_grindzone
// Params 2
// Checksum 0xcf3bd4bf, Offset: 0xb5c
// Size: 0x48
function updateflagstate( state, keeppulse )
{
    self.scriptable setscriptablepartstate( "flag", state );
    
    if ( !keeppulse )
    {
        self.scriptable setscriptablepartstate( "pulse", "off" );
    }
}

// Namespace obj_grindzone
// Params 1
// Checksum 0xe41742ba, Offset: 0xbac
// Size: 0x21
function updateflagcapturestate( state )
{
    self.scriptable setscriptablepartstate( "pulse", state );
}

