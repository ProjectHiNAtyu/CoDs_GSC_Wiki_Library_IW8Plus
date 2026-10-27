// scripts\mp\gametypes\obj_dom.gsc  (hash_6663215f917210ae.gscc) (size: 31943 Bytes / 0x7cc7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1b12a62 (3786484322)
// size ...... 31943 (0x7cc7)
// includes .. 29  (offset: 0x74cf)
// strings ... 90  (offset: 0x75b7)
// dev strs .. 6   (offset: 0x7c77)
// exports ... 58  (offset: 0x55bf)
// cseg ...... 0x520 + 0x509f (0x55bf)
// imports ... 165 (offset: 0x5ecf)
// animtree1 . 0   (offset: 0x7cc7)
// animtree2 . 0   (offset: 0x7cc7)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\siege;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace obj_dom;

// Namespace obj_dom
// Params 7
// Checksum 0x6227f339, Offset: 0x53e
// Size: 0x8f4
function setupobjective( trigger, team, var_ee9ac91f30ff8e1, skipobjid, showoncompass, icons, var_441b8d5f798c04a7 = ( 0, 0, 100 ) )
{
    visuals = [];
    
    if ( level.usestrongholdhills || getdvarint( @"t10", 0 ) > 0 )
    {
        visuals[ 0 ] = trigger;
        assert( isdefined( trigger ) );
    }
    else if ( isdefined( trigger.target ) )
    {
        if ( !isdefined( trigger.visuals ) || trigger.visuals.size == 0 )
        {
            visuals[ 0 ] = getent( trigger.target, #targetname ) ?? trigger;
        }
        else
        {
            visuals = trigger.visuals;
        }
        
        assert( visuals.size > 0, "<dev string:x24>" + ( trigger.target ?? "<dev string:x5d>" ) );
    }
    
    if ( !isarray( visuals ) || visuals.size == 0 )
    {
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        visuals[ 0 ].angles = trigger.angles;
    }
    
    if ( !isdefined( level.flagcapturetime ) )
    {
        level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 10, 0, 30 );
    }
    
    if ( !isdefined( level.flagcapturemintime ) )
    {
        level.flagcapturemintime = dvars::dvarfloatvalue( "flagCaptureTimeMin", 0, 0, 30 );
    }
    
    if ( !isdefined( level.var_e56cac0580f1c92c ) )
    {
        level.var_e56cac0580f1c92c = level.flagcapturetime * 0.5;
    }
    
    if ( isdefined( trigger.objectivekey ) )
    {
        objectivekey = trigger.objectivekey;
    }
    else if ( isdefined( trigger.script_label ) )
    {
        objectivekey = trigger.script_label;
    }
    else
    {
        assertmsg( "<dev string:x74>" );
        objectivekey = "";
    }
    
    if ( isdefined( trigger.iconname ) )
    {
        iconname = trigger.iconname;
    }
    else
    {
        iconname = trigger.script_label;
    }
    
    if ( var_ee9ac91f30ff8e1 )
    {
        reservedobjid = getreservedobjid( objectivekey );
    }
    else
    {
        reservedobjid = undefined;
    }
    
    if ( !isdefined( team ) )
    {
        team = "neutral";
    }
    
    if ( isdefined( trigger.target ) )
    {
        var_b6a962ec973ce64d = utility::getstruct( trigger.target, "targetname" );
        
        if ( isdefined( var_b6a962ec973ce64d ) )
        {
            var_441b8d5f798c04a7 = var_b6a962ec973ce64d.origin - trigger.origin;
        }
    }
    
    domflag = gameobjects::createuseobject( team, trigger, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid, showoncompass );
    bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_dom" );
    
    if ( bundle && bundle.var_d73055eaaaabc06a && !flags::gameflag( "prematch_done" ) )
    {
        domflag thread function_ef4a7e25fb9986bf();
    }
    else
    {
        domflag gameobjects::allowuse( "enemy" );
    }
    
    domflag gameobjects::cancontestclaim( 1 );
    domflag gameobjects::setusetime( level.flagcapturetime );
    domflag.icons = icons;
    
    if ( isdefined( level.capturetype ) )
    {
        domflag gameobjects::setcapturebehavior( getcapturetype() );
    }
    
    domflag.objectivekey = objectivekey;
    domflag.iconname = iconname;
    
    if ( isdefined( level.gametypebundle.var_aa0311acd75b0f66 ) )
    {
        foreach ( domkey in level.gametypebundle.var_aa0311acd75b0f66 )
        {
            if ( domflag.objectivekey == domkey.var_1f7504fb4ac23cc0 )
            {
                domflag.var_98076e259d94a508 = domkey.var_24caf1be79593923;
                break;
            }
        }
    }
    
    if ( !skipobjid )
    {
        domflag gameobjects::setvisibleteam( "any", undefined, 1 );
        domflag.onuse = &dompoint_onuse;
        domflag.onbeginuse = &dompoint_onusebegin;
        domflag.onuseupdate = &dompoint_onuseupdate;
        domflag.onenduse = &dompoint_onuseend;
        domflag.oncontested = &dompoint_oncontested;
        domflag.onuncontested = &dompoint_onuncontested;
        domflag.onunoccupied = &dompoint_onunoccupied;
        domflag.onpinnedstate = &dompoint_onpinnedstate;
        domflag.onunpinnedstate = &dompoint_onunpinnedstate;
        domflag.stompprogressreward = &dompoint_stompprogressreward;
    }
    
    domflag.nousebar = 1;
    domflag.id = "domFlag";
    domflag.claimgracetime = level.flagcapturetime * 1000;
    domflag.firstcapture = 1;
    domflag gameobjects::pinobjiconontriggertouch();
    domflag.var_2809cba8dafcf8cf = level.flagreinforcement;
    domflag.var_c95f5d841e441c5b = level.flagmodelhidden;
    
    if ( domflag.var_2809cba8dafcf8cf )
    {
        domflag.reinforcementmax = domflag.usetime - 1;
        domflag.reinforcementstompscalar = level.reinforcementstompscalar;
        
        if ( level.flagdecaytime > 0 )
        {
            domflag.decayrate = domflag.usetime * level.framedurationseconds / level.flagdecaytime;
        }
    }
    
    tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
    traceend = visuals[ 0 ].origin + ( 0, 0, -32 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    offset = checkmapoffsets( domflag );
    domflag.baseeffectpos = trace[ "position" ] + offset;
    upangles = vectortoangles( trace[ "normal" ] );
    modifiedupangles = checkmapfxangles( domflag, upangles );
    domflag.baseeffectforward = anglestoforward( modifiedupangles );
    scriptable = spawn( "script_model", domflag.baseeffectpos );
    scriptable setmodel( "dom_flag_scriptable" );
    scriptable.angles = generateaxisanglesfromforwardvector( domflag.baseeffectforward, scriptable.angles );
    domflag.scriptable = scriptable;
    
    if ( getdvarint( @"hash_33af98c375b98d29" ) == 1 )
    {
        var_1213eb89af5eb = trigger.origin + ( 0, 0, 20 );
        vfxscriptable = spawnscriptable( "mgl_dom_flag", var_1213eb89af5eb );
        vfxscriptable.angles = ( 90, 0, 0 );
        vfxscriptable setscriptablepartstate( "flag", "idle" );
        domflag.vfxnamemod = vfxscriptable;
    }
    else
    {
        domflag.vfxnamemod = "";
    }
    
    domflag.noscriptable = 1;
    
    if ( level.multiteambased )
    {
        domflag.noscriptable = 1;
    }
    
    domflag.flagmodel = spawn( "script_model", domflag.baseeffectpos );
    domflag.flagmodel.angles = checkmapflagangles( domflag );
    
    if ( !domflag.var_c95f5d841e441c5b )
    {
        domflag.flagmodel setmodel( level.gametypebundle.var_834f51977cd32b4c ?? "military_dom_flag_neutral" );
        
        if ( domflag.flagmodel isscriptable() )
        {
            domflag.flagmodel setscriptablepartstate( "flag", "idle" );
        }
    }
    
    domflag.outlineent = domflag.flagmodel;
    domflag initializematchrecording();
    
    if ( !skipobjid )
    {
        domflag domflag_setneutral();
    }
    
    return domflag;
}

// Namespace obj_dom
// Params 0, eflags: 0x4
// Checksum 0x682f0928, Offset: 0xe3b
// Size: 0x1b
function private function_ef4a7e25fb9986bf()
{
    level waittill( #"prematch_done" );
    gameobjects::allowuse( "enemy" );
}

// Namespace obj_dom
// Params 1
// Checksum 0xa30a1941, Offset: 0xe5e
// Size: 0x27
function function_c18eb83275e643e7( zone )
{
    if ( isdefined( level.var_c18eb83275e643e7 ) )
    {
        zone [[ level.var_c18eb83275e643e7 ]]();
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0xbe24f2a5, Offset: 0xe8d
// Size: 0x53
function removeobjective( domflag )
{
    if ( isdefined( domflag.flagmodel ) )
    {
        domflag.flagmodel delete();
    }
    
    if ( isdefined( domflag.scriptable ) )
    {
        domflag.scriptable delete();
    }
    
    domflag gameobjects::deleteuseobject();
}

// Namespace obj_dom
// Params 1
// Checksum 0xcec4a005, Offset: 0xee8
// Size: 0x63
function getreservedobjid( objectivekey )
{
    if ( objectivekey == "_a" )
    {
        reservedid = 0;
    }
    else if ( objectivekey == "_b" )
    {
        reservedid = 1;
    }
    else if ( objectivekey == "_d" )
    {
        reservedid = 3;
    }
    else if ( objectivekey == "_e" )
    {
        reservedid = 4;
    }
    else
    {
        reservedid = 2;
    }
    
    return reservedid;
}

// Namespace obj_dom
// Params 0
// Checksum 0x79dc4f84, Offset: 0xf54
// Size: 0x44
function getcapturetype()
{
    capturetype = "normal";
    
    if ( level.capturetype == 2 )
    {
        capturetype = "neutralize";
    }
    else if ( level.capturetype == 3 )
    {
        capturetype = "persistent";
    }
    
    return capturetype;
}

// Namespace obj_dom
// Params 1
// Checksum 0x1a68846a, Offset: 0xfa1
// Size: 0x27
function checkmapflagangles( domflag )
{
    angles = ( 0, 0, 0 );
    return angles;
}

// Namespace obj_dom
// Params 1
// Checksum 0x69b68956, Offset: 0xfd1
// Size: 0x27
function checkmapoffsets( domflag )
{
    offset = ( 0, 0, 0 );
    return offset;
}

// Namespace obj_dom
// Params 2
// Checksum 0x45322957, Offset: 0x1001
// Size: 0x25
function checkmapfxangles( domflag, upangles )
{
    angles = upangles;
    return angles;
}

// Namespace obj_dom
// Params 0
// Checksum 0xdddec840, Offset: 0x102f
// Size: 0x1ab
function initializematchrecording()
{
    if ( isdefined( level.matchrecording_logevent ) )
    {
        assert( isdefined( level.matchrecording_generateid ), "<dev string:xb0>" );
        self.logid = [[ level.matchrecording_generateid ]]();
        flagletter = "A";
        
        switch ( self.objectivekey )
        {
            case #"hash_fac2c5f6bddd49bd":
                flagletter = "A";
                break;
            case #"hash_fac2c2f6bddd4504":
                flagletter = "B";
                break;
            case #"hash_fac2c3f6bddd4697":
                flagletter = "C";
                break;
            case #"hash_fac2c0f6bddd41de":
                flagletter = "D";
                break;
            case #"hash_fac2c1f6bddd4371":
                flagletter = "E";
                break;
            case #"hash_311010bc01bd3a0f":
                flagletter = "0";
                break;
            case #"hash_31100fbc01bd387c":
                flagletter = "1";
                break;
            case #"hash_311012bc01bd3d35":
                flagletter = "2";
                break;
            case #"hash_311011bc01bd3ba2":
                flagletter = "3";
                break;
            case #"hash_31100cbc01bd33c3":
                flagletter = "4";
                break;
            default:
                assertmsg( "<dev string:xe2>" + self.script_label );
                break;
        }
        
        self.logeventflag = "FLAG_" + flagletter;
    }
    
    if ( level.var_dc61a9eb0da4d624 ?? analyticslog::function_f432eaae9387e0e4() )
    {
        self.analyticslogid = analyticslog::getuniqueobjectid();
        self.analyticslogtype = "dom_flag" + self.objectivekey;
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0xd6c946cd, Offset: 0x11e2
// Size: 0x14d
function domflag_setneutral( keeppulse )
{
    self notify( #"flag_neutral" );
    
    if ( utility::issharedfuncdefined( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) )
    {
        [[ utility::getsharedfunc( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) ]]();
    }
    else
    {
        gameobjects::setobjectivestatusicons( self.icons.iconneutral ?? level.iconneutral, undefined, undefined, undefined, 1 );
    }
    
    gameobjects::setownerteam( "neutral" );
    function_98c658171dfa958e();
    thread updateflagstate( "idle", istrue( keeppulse ) );
    
    if ( isdefined( level.matchrecording_logevent ) && isdefined( self.logid ) && isdefined( self.logeventflag ) )
    {
        [[ level.matchrecording_logevent ]]( self.logid, undefined, self.logeventflag, self.visuals[ 0 ].origin[ 0 ], self.visuals[ 0 ].origin[ 1 ], gettime(), 0 );
    }
    
    analyticslog::logevent_gameobject( self.analyticslogtype, self.analyticslogid, self.visuals[ 0 ].origin, -1, "neutral" );
}

// Namespace obj_dom
// Params 2
// Checksum 0xeff70d4e, Offset: 0x1337
// Size: 0x325
function dompoint_setcaptured( team, credit_player )
{
    gameobjects::setownerteam( team );
    function_53dac00aa4dc7c59( team );
    
    if ( isdefined( credit_player ) )
    {
        credit_player notify( #"domflag_captured" );
        self notify( #"capture", credit_player );
        self notify( #"assault", credit_player );
        credit_player notify( #"player_zone_captured", self.objectivekey );
    }
    
    friendlyicon = self.var_2809cba8dafcf8cf ? self.icons.iconreinforcing ?? level.iconreinforcing : self.icons.icondefending ?? level.icondefending;
    gameobjects::setobjectivestatusicons( friendlyicon, self.icons.iconcapture ?? level.iconcapture );
    
    if ( game_utility::getgametype() == "btm" )
    {
        level thread hud_message::updatematchstatushintforallplayers( self.ownerteam, #"flag_defend", #"flag_capture" );
    }
    
    self.neutralized = 0;
    thread updateflagstate( team, 0, team );
    
    if ( self.touchlist[ team ].size == 0 && isdefined( self.oldtouchlist ) )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    foreach ( name in level.teamnamelist )
    {
        if ( isdefined( self.assisttouchlist[ name ] ) && name != team )
        {
            self.assisttouchlist[ name ] = [];
        }
    }
    
    if ( level.usestrongholdscoring )
    {
        ownedflags = getteamflagcount( team );
        
        if ( ownedflags == level.flagsrequiredtoscore )
        {
            dialog::statusdialog( "friendly_scoring", team );
            dialog::statusdialog( "enemy_scoring", team_utility::getotherteam( team ) );
        }
    }
    
    if ( isdefined( credit_player ) && ( !isagent( credit_player ) || gameobjects::function_e17a356e69f57699( credit_player ) ) )
    {
        thread function_800ad8847b209fee( self.touchlist[ team ], credit_player, team );
    }
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        [[ level.matchrecording_logevent ]]( self.logid, undefined, self.logeventflag, self.visuals[ 0 ].origin[ 0 ], self.visuals[ 0 ].origin[ 1 ], gettime(), team == "allies" ? 1 : 2 );
    }
    
    analyticslog::logevent_gameobject( self.analyticslogtype, self.analyticslogid, self.visuals[ 0 ].origin, -1, "captured_" + team );
}

// Namespace obj_dom
// Params 2
// Checksum 0x1d6352e0, Offset: 0x1664
// Size: 0x2c3
function dompoint_onuse( credit_player, team = credit_player.team )
{
    if ( self.var_2809cba8dafcf8cf )
    {
        if ( self.ownerteam == team )
        {
            if ( !self.reinforced )
            {
                self.reinforced = 1;
                
                if ( self.decayrate > 0 )
                {
                    thread gameobjects::useobjectdecay( team );
                }
            }
            
            self.curprogress = self.reinforcementmax;
            self.teamprogress[ self.ownerteam ] = self.curprogress;
            return;
        }
        else
        {
            gameobjects::allowuse( "any" );
        }
    }
    
    oldteam = gameobjects::getownerteam();
    self.oldteam = oldteam;
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    self.capturetime = gettime();
    self.neutralized = 0;
    
    if ( level.flagneutralization )
    {
        ownerteam = gameobjects::getownerteam();
        
        if ( ownerteam == "neutral" )
        {
            dompoint_setcaptured( team, credit_player );
            
            if ( isdefined( self.var_13edf71915945035 ) )
            {
                [[ self.var_13edf71915945035 ]]( credit_player );
            }
        }
        else
        {
            thread domflag_setneutral( 1 );
            self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( #"hash_4f047ea7e601fbf", ownerteam );
            level.lastcaptime = gettime();
            thread giveflagassistedcapturepoints( self.touchlist[ team ] );
            self.neutralized = 1;
        }
    }
    else
    {
        dompoint_setcaptured( team, credit_player );
        
        if ( isdefined( self.var_13edf71915945035 ) )
        {
            [[ self.var_13edf71915945035 ]]( credit_player );
        }
    }
    
    if ( !self.neutralized && !isdefined( self.forceneutralized ) )
    {
        announcementextradata = 3;
        
        if ( self.objectivekey == "_a" )
        {
            announcementextradata = 1;
        }
        else if ( self.objectivekey == "_b" )
        {
            announcementextradata = 2;
        }
        else if ( self.objectivekey == "_d" )
        {
            announcementextradata = 4;
        }
        else if ( self.objectivekey == "_e" )
        {
            announcementextradata = 5;
        }
        
        if ( isdefined( credit_player ) && !isagent( credit_player ) )
        {
            codcaster_utils::function_3038b6eafc46c037( 21, team, credit_player getentitynumber(), announcementextradata );
        }
        
        if ( isdefined( level.onobjectivecomplete ) )
        {
            [[ level.onobjectivecomplete ]]( "dompoint", self.objectivekey, credit_player, team, oldteam, self );
        }
    }
    
    self.forceneutralized = undefined;
    self.firstcapture = 0;
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 1
// Checksum 0xbc88de83, Offset: 0x192f
// Size: 0x296
function dompoint_onusebegin( player )
{
    ownerteam = gameobjects::getownerteam();
    player.isonobjective = 1;
    self.neutralizing = level.flagneutralization && ownerteam != "neutral";
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    
    if ( self.neutralizing )
    {
        if ( ownerteam != player.team )
        {
            objectivestate = getdomneutralizeomnvarvalue();
        }
        else
        {
            objectivestate = 0;
        }
    }
    else if ( ownerteam != player.team )
    {
        objectivestate = 1;
    }
    else
    {
        objectivestate = 0;
    }
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", objectivestate );
    }
    
    if ( !isdefined( self.statusnotifytime ) )
    {
        self.statusnotifytime = gettime();
    }
    
    if ( !self.neutralized && self.statusnotifytime > self.statusnotifytime + 5000 )
    {
        self.didstatusnotify = 0;
        self.statusnotifytime = gettime();
    }
    
    usetime = level.flagcapturetime;
    
    if ( level.flagneutralization && !self.firstcapture )
    {
        usetime = level.var_e56cac0580f1c92c;
        gameobjects::setusetime( usetime, 1 );
    }
    else if ( isdefined( self.prevusetime ) )
    {
        usetime = self.prevusetime;
        gameobjects::setusetime( self.prevusetime );
    }
    
    if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
    {
        self.useratemultiplier = player getclientomnvar( "ui_voxel_head_size" );
    }
    
    if ( usetime > 0 )
    {
        self.prevownerteam = team_utility::getotherteam( player.team );
        updateflagcapturestate( player.team );
        
        if ( utility::issharedfuncdefined( #"hash_a6619fd2a3c21adc", #"hash_5ee1271a3e3fc202" ) )
        {
            [[ utility::getsharedfunc( #"hash_a6619fd2a3c21adc", #"hash_5ee1271a3e3fc202" ) ]]( player );
        }
        else
        {
            gameobjects::setobjectivestatusicons( self.icons.iconlosing ?? level.iconlosing, self.icons.icontaking ?? level.icontaking );
        }
    }
    
    if ( level.hideenemyfobs )
    {
        if ( player.team != ownerteam )
        {
            gameobjects::setvisibleteam( "any" );
        }
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 4
// Checksum 0x1b401022, Offset: 0x1bcd
// Size: 0x592
function dompoint_onuseupdate( team, progress, change, capplayer )
{
    objidpoolmanager::function_84651f3f2873ee19( self.objidnum, team );
    ownerteam = gameobjects::getownerteam();
    
    if ( !self.stalemate && !self.capblocked && progress < 1 && !level.gameended && !game_utility_mp::isanymlgmatch() )
    {
        if ( utility::issharedfuncdefined( #"hash_a6619fd2a3c21adc", #"hash_6dd488d05199686c" ) )
        {
            utility::callsharedfunc( #"hash_a6619fd2a3c21adc", #"hash_6dd488d05199686c", team, progress, capplayer );
        }
        else
        {
            function_de622032224cefd1( progress, team );
        }
    }
    
    if ( level.capturesegments )
    {
        var_a38be239d50f19de = 0;
        
        for ( i = 0; i < level.capturesegments ; i++ )
        {
            if ( !isdefined( self.segmentupdate ) )
            {
                self.segmentupdate = 0;
            }
            
            segmentprogress = ( i + 1 ) / level.capturesegments;
            
            if ( progress >= segmentprogress && self.segmentupdate <= i )
            {
                self.segmentupdate = i + 1;
                var_a38be239d50f19de = 1;
            }
        }
        
        if ( var_a38be239d50f19de )
        {
            foreach ( struct in self.touchlist[ team ] )
            {
                player = struct.player;
                
                if ( self.segmentupdate != level.capturesegments )
                {
                    player thread rank::scoreeventpopup( #"segment_captured" );
                    player notify( #"segment_captured" );
                    
                    if ( gameobjects::function_e17a356e69f57699( player ) )
                    {
                        player.owner setclientomnvar( "ui_segment_captured", self.segmentupdate );
                    }
                    else
                    {
                        player setclientomnvar( "ui_segment_captured", self.segmentupdate );
                    }
                }
                
                player codcasterclientmatchdata::function_8ecc753b54a5740f( 8, 1 );
            }
            
            if ( isdefined( self.var_c054f1da22a3a72a ) )
            {
                self [[ self.var_c054f1da22a3a72a ]]( team, capplayer, self.segmentupdate );
            }
            
            if ( self.segmentupdate != level.capturesegments )
            {
                segmentid = 2;
                
                if ( self.objectivekey == "_a" )
                {
                    segmentid = 1;
                }
                
                codcaster_utils::function_3038b6eafc46c037( 23, team, capplayer getentitynumber(), segmentid );
            }
            
            telemetry_data = spawnstruct();
            telemetry_data.objective_entity = self;
            telemetry_data.credit_player = capplayer;
            telemetry_utils::function_af2d366f9522f76f( "callback_objective_state_changed", telemetry_data );
        }
    }
    
    if ( progress > 0 && change && !self.didstatusnotify )
    {
        if ( isdefined( self.objectivekey ) || !level.var_4a5de2a2eae8e2b0 )
        {
            if ( ownerteam == "neutral" )
            {
                if ( level.flagcapturetime > 0.05 )
                {
                    dialog::statusdialog( "securing" + ( self.var_98076e259d94a508 ?? self.objectivekey ), team );
                    var_4ee838025213e3dc = isdefined( level.objectives ) && level.objectives.size == 3 && !level.ingraceperiod;
                    var_b617e7b2d7aeb3d5 = isdefined( level.objectives ) && level.objectives.size == 5 && ( self.objectivekey == "_b" || self.objectivekey == "_c" || self.objectivekey == "_d" );
                    
                    if ( var_4ee838025213e3dc || var_b617e7b2d7aeb3d5 )
                    {
                        otherteam = team_utility::getotherteam( team );
                        dialog::statusdialog( "losing" + ( self.var_98076e259d94a508 ?? self.objectivekey ), otherteam );
                    }
                }
            }
            else if ( level.flagcapturetime > 0.05 && ( !self.var_2809cba8dafcf8cf || team != ownerteam ) )
            {
                if ( function_3e4359c70d90ca13( team ) )
                {
                    dialog::statusdialog( #"hash_2c21297e7650d68c", ownerteam );
                    dialog::statusdialog( #"hash_7141bb476a58b2be", team );
                    
                    foreach ( flag in level.objectives )
                    {
                        flag.didstatusnotify = 1;
                    }
                }
                else
                {
                    dialog::statusdialog( "losing" + ( self.var_98076e259d94a508 ?? self.objectivekey ), ownerteam );
                    dialog::statusdialog( "securing" + ( self.var_98076e259d94a508 ?? self.objectivekey ), team );
                }
            }
        }
        
        self.didstatusnotify = 1;
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 1
// Checksum 0x611eb95f, Offset: 0x2167
// Size: 0xbf, Type: bool
function function_3e4359c70d90ca13( attackingteam )
{
    foreach ( flag in level.objectives )
    {
        if ( flag.isunoccupied || flag.stalemate || !( flag.lastprogressteam == attackingteam ) || level.var_3be9a1b658ae8cda > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace obj_dom
// Params 3
// Checksum 0x6634a626, Offset: 0x222f
// Size: 0x190
function dompoint_onuseend( team, player, success )
{
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    }
    
    if ( level.gametypebundle.var_92077063b6317032 )
    {
        thread function_ac0067bf9a2ec6c1();
    }
    
    if ( isdefined( player ) )
    {
        player.isonobjective = 0;
    }
    
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        if ( utility::issharedfuncdefined( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) )
        {
            [[ utility::getsharedfunc( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) ]]();
        }
        else
        {
            gameobjects::setobjectivestatusicons( self.icons.iconneutral ?? level.iconneutral );
        }
        
        thread updateflagstate( "idle", 0 );
    }
    else
    {
        if ( utility::issharedfuncdefined( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) )
        {
            [[ utility::getsharedfunc( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) ]]();
        }
        else
        {
            gameobjects::setobjectivestatusicons( self.icons.icondefend ?? level.icondefend, self.icons.iconcapture ?? level.iconcapture );
        }
        
        thread updateflagstate( ownerteam, 0 );
    }
    
    if ( !success )
    {
        self.neutralized = 0;
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 0
// Checksum 0xbfee335b, Offset: 0x23c7
// Size: 0x85, Type: bool
function function_35288bf4ad0690c()
{
    foreach ( flag in level.objectives )
    {
        if ( !flag.stalemate )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace obj_dom
// Params 0
// Checksum 0xdd85f841, Offset: 0x2455
// Size: 0x187
function dompoint_oncontested()
{
    self.contestedtime = gettime();
    gameobjects::setobjectivestatusicons( self.icons.iconcontested ?? level.iconcontested );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    thread updateflagstate( "contested", 0 );
    thread oncontested_playsoundatpos( self.trigger.origin, #"hash_d56f1d46a102937a", 2.8 );
    
    if ( level.gametypebundle.var_92077063b6317032 )
    {
        thread function_ac0067bf9a2ec6c1();
    }
    
    if ( level.gametypebundle.var_5fec0bea1f3da71 )
    {
        self notify( #"hash_8202753dc71a29c3" );
    }
    
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        notifyteam = self.claimteam;
    }
    else
    {
        notifyteam = ownerteam;
    }
    
    if ( isdefined( self.iconname ) )
    {
        if ( function_35288bf4ad0690c() )
        {
            dialog::statusdialog( #"defending_contested_all", notifyteam );
            dialog::statusdialog( #"attacking_contested_all", team_utility::getotherteam( notifyteam ) );
        }
        else
        {
            dialog::statusdialog( "defending_contested" + self.iconname, notifyteam );
            dialog::statusdialog( "attacking_contested" + self.iconname, team_utility::getotherteam( notifyteam ) );
        }
    }
    
    objidpoolmanager::function_84651f3f2873ee19( self.objidnum, "neutral" );
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 1
// Checksum 0x9c5a61e, Offset: 0x25e4
// Size: 0x270
function dompoint_onuncontested( lastclaimteam )
{
    if ( level.flagneutralization && !self.firstcapture )
    {
        gameobjects::setusetime( level.flagcapturetime * 0.5 );
    }
    
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        if ( lastclaimteam != "none" )
        {
            objidpoolmanager::objective_set_progress_team( self.objidnum, lastclaimteam );
        }
        else if ( isdefined( self.lastprogressteam ) )
        {
            objidpoolmanager::objective_set_progress_team( self.objidnum, self.lastprogressteam );
        }
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( self.objidnum, team_utility::getotherteam( ownerteam ) );
    }
    
    if ( lastclaimteam == "none" && ownerteam == "neutral" )
    {
        if ( utility::issharedfuncdefined( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) )
        {
            [[ utility::getsharedfunc( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) ]]();
        }
        else
        {
            gameobjects::setobjectivestatusicons( self.icons.iconneutral ?? level.iconneutral );
        }
        
        self.didstatusnotify = 0;
    }
    else if ( isdefined( level.var_6acc53d8aaa7d1e3 ) )
    {
        self thread [[ level.var_6acc53d8aaa7d1e3 ]]( ownerteam, lastclaimteam );
    }
    else if ( utility::issharedfuncdefined( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) )
    {
        [[ utility::getsharedfunc( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) ]]();
    }
    else
    {
        gameobjects::setobjectivestatusicons( self.icons.icondefend ?? level.icondefend, self.icons.iconcapture ?? level.iconcapture );
    }
    
    self.contestedtime = undefined;
    flagstate = ownerteam == "neutral" ? "idle" : ownerteam;
    thread updateflagstate( flagstate, 0 );
    objidpoolmanager::function_84651f3f2873ee19( self.objidnum, "neutral" );
    thread onuncontested_playsoundatpos( self.trigger.origin, #"hash_b3d5c9bad6c5ceb", 2.8 );
    
    if ( level.gametypebundle.var_92077063b6317032 )
    {
        thread function_ac0067bf9a2ec6c1();
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 2
// Checksum 0x716810db, Offset: 0x285c
// Size: 0x11d
function function_de622032224cefd1( progress, team )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    otherteam = team_utility::getotherteam( team );
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        progress = int( floor( progress * 10 ) );
        var_8eb35fb703d61a67 = "shared_obj_capturing_tick_0" + progress;
        
        if ( level.gametypebundle.var_92077063b6317032 )
        {
            thread function_171000b4e9b66c33( progress );
        }
        
        if ( level.gametypebundle.var_855b8e35bccbcf29 )
        {
            if ( self.owner != team )
            {
                var_d6e4ee0539bd45d7 = var_8eb35fb703d61a67 + "_neg";
                self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( var_8eb35fb703d61a67, team );
                self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( var_d6e4ee0539bd45d7, otherteam );
            }
            
            return;
        }
        
        self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( var_8eb35fb703d61a67, team );
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0x2d9b8aa0, Offset: 0x2981
// Size: 0x8e
function function_171000b4e9b66c33( progress )
{
    if ( !self.var_5488028bd3140f73 )
    {
        self.var_5488028bd3140f73 = 0;
    }
    
    if ( level.gametypebundle.var_679e331ce06ae75e )
    {
        self.visuals[ 0 ] function_70576dbab4f88e19( level.gametypebundle.var_679e331ce06ae75e, progress );
    }
    
    if ( self.var_5488028bd3140f73 == 0 )
    {
        self.visuals[ 0 ] gameplay_sound_fx::function_8219c402fc8c37a3( "shared_obj_capturing_lp" );
        self.var_5488028bd3140f73 = 1;
    }
}

// Namespace obj_dom
// Params 0
// Checksum 0xa950131b, Offset: 0x2a17
// Size: 0x40
function function_ac0067bf9a2ec6c1()
{
    if ( !self.var_5488028bd3140f73 )
    {
        return;
    }
    
    if ( self.var_5488028bd3140f73 == 1 )
    {
        self.visuals[ 0 ] gameplay_sound_fx::function_9d2677406f9212a5( "shared_obj_capturing_lp" );
        self.var_5488028bd3140f73 = 0;
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0x698503e7, Offset: 0x2a5f
// Size: 0xa5
function function_61f5c7ff08767888( team )
{
    self notify( #"hash_20772615e2071833" );
    self endon( #"hash_20772615e2071833" );
    self endon( #"hash_8202753dc71a29c3" );
    level endon( #"game_ended" );
    otherteam = team_utility::getotherteam( team );
    
    while ( true )
    {
        if ( self.curprogress == 0 )
        {
            break;
        }
        
        self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( "shared_obj_clearing_tick", team );
        self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( "shared_obj_clearing_tick", otherteam );
        wait 0.995;
    }
}

// Namespace obj_dom
// Params 0
// Checksum 0x7872c198, Offset: 0x2b0c
// Size: 0x11e
function dompoint_onunoccupied()
{
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        if ( utility::issharedfuncdefined( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) )
        {
            [[ utility::getsharedfunc( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65" ) ]]();
        }
        else
        {
            gameobjects::setobjectivestatusicons( self.icons.iconneutral ?? level.iconneutral );
        }
    }
    else if ( utility::issharedfuncdefined( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) )
    {
        [[ utility::getsharedfunc( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) ]]();
    }
    else
    {
        gameobjects::setobjectivestatusicons( self.icons.icondefend ?? level.icondefend, self.icons.iconcapture ?? level.iconcapture );
    }
    
    self.didstatusnotify = 0;
    objidpoolmanager::function_84651f3f2873ee19( self.objidnum, "neutral" );
}

// Namespace obj_dom
// Params 1
// Checksum 0xd6f63aa7, Offset: 0x2c32
// Size: 0x244
function dompoint_onpinnedstate( player )
{
    if ( self.ownerteam != "neutral" && self.numtouching[ self.ownerteam ] && !self.stalemate )
    {
        var_cb110530e0fe11f = 0;
        
        if ( isdefined( self.segmentupdate ) )
        {
            lockedprogress = self.usetime * self.segmentupdate / level.capturesegments;
            var_cb110530e0fe11f = self.teamprogress[ self.lastprogressteam ] <= lockedprogress;
        }
        
        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 && self.teamprogress[ self.claimteam ] == 0 && !var_cb110530e0fe11f )
        {
            gameobjects::setobjectivestatusicons( self.icons.iconclearing ?? level.iconclearing, self.icons.iconcapture ?? level.iconcapture );
            
            if ( player.team == self.ownerteam )
            {
                objidpoolmanager::function_9d3f184285ca25e4( &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", player );
                
                if ( level.gametypebundle.var_5fec0bea1f3da71 )
                {
                    thread function_61f5c7ff08767888( player.team );
                }
            }
        }
        else
        {
            friendlyicon = self.var_2809cba8dafcf8cf ? self.icons.iconreinforcing ?? level.iconreinforcing : self.icons.icondefending ?? level.icondefending;
            gameobjects::setobjectivestatusicons( friendlyicon, self.icons.iconcapture ?? level.iconcapture );
            
            if ( player.team == self.ownerteam )
            {
                objidpoolmanager::function_9d3f184285ca25e4( &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player );
            }
        }
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 1
// Checksum 0x8c142f04, Offset: 0x2e7e
// Size: 0xf3
function dompoint_onunpinnedstate( player )
{
    if ( !self.stalemate )
    {
        if ( self.isunoccupied && ( self.ownerteam != "neutral" || self.lastclaimteam != "neutral" ) )
        {
            if ( utility::issharedfuncdefined( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) )
            {
                [[ utility::getsharedfunc( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96" ) ]]();
            }
            else
            {
                gameobjects::setobjectivestatusicons( self.icons.icondefend ?? level.icondefend, self.icons.iconcapture ?? level.iconcapture );
            }
        }
    }
    
    if ( level.gametypebundle.var_5fec0bea1f3da71 )
    {
        self notify( #"hash_8202753dc71a29c3" );
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 1
// Checksum 0xa8f029c0, Offset: 0x2f79
// Size: 0x5e
function function_759196e1bdad8cfc( team )
{
    if ( self.var_2809cba8dafcf8cf )
    {
        if ( isdefined( self.ownerteam ) && self.ownerteam != "neutral" && team != self.ownerteam )
        {
            self.reinforced = 0;
            self notify( #"hash_f7b4b7d01e743143" );
        }
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0xad0e6155, Offset: 0x2fdf
// Size: 0x105
function dompoint_stompprogressreward( player )
{
    if ( gameobjects::function_e17a356e69f57699( player ) )
    {
        player.owner thread points::doscoreevent( #"obj_prog_defend_capture_bot" );
    }
    else if ( isdefined( player ) )
    {
        player events::function_a7d373228760063b();
        
        if ( isdefined( self.entnum ) && player.defenderskilled[ self.entnum ] >= 2 )
        {
            player thread points::doscoreevent( #"hash_d0f5c98414382d61" );
            player.defenderskilled[ self.entnum ] = 0;
        }
    }
    
    gameobjects::setobjectivestatusicons( self.icons.icondefending ?? level.icondefending, self.icons.iconcapture ?? level.iconcapture );
    
    if ( isdefined( player ) )
    {
        objidpoolmanager::function_9d3f184285ca25e4( &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player );
        player gameplay_sound_fx::playlocalsoundfx( #"hash_5125eb00c212d734" );
    }
}

// Namespace obj_dom
// Params 0
// Checksum 0xbe086a30, Offset: 0x30ec
// Size: 0x331
function function_13edf71915945035()
{
    tstartoffset = 20;
    var_2b71db98eef20ee8 = 600;
    origin = self.flagmodel.origin;
    tstart = origin + ( 0, 0, tstartoffset );
    tend = origin + ( 0, 0, var_2b71db98eef20ee8 );
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    ignoreents = level.players;
    ignoreents[ ignoreents.size ] = self.flagmodel;
    trace = trace::ray_trace( tstart, tend, ignoreents, contentoverride, 0 );
    
    if ( isplayer( trace[ "entity" ] ) )
    {
        trace[ "entity" ] = undefined;
    }
    
    if ( isdefined( trace[ "entity" ] ) && trace[ "entity" ].code_classname == "script_vehicle" )
    {
        ignoreents[ ignoreents.size ] = trace[ "entity" ];
        trace = trace::ray_trace( tstart, tend, ignoreents, contentoverride, 0 );
    }
    
    if ( trace[ "fraction" ] != 1 )
    {
        tstartoffset = 4000;
        var_2b71db98eef20ee8 = 20;
        origin = self.flagmodel.origin;
        tstart = origin + ( 0, 0, tstartoffset );
        tend = origin + ( 0, 0, var_2b71db98eef20ee8 );
        contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
        ignoreents = [];
        ignoreents = level.players;
        ignoreents[ ignoreents.size ] = self.flagmodel;
        trace = trace::ray_trace( tstart, tend, ignoreents, contentoverride, 0 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            trace[ "entity" ] = undefined;
        }
        
        if ( isdefined( trace[ "entity" ] ) && trace[ "entity" ].code_classname == "script_vehicle" )
        {
            ignoreents[ ignoreents.size ] = trace[ "entity" ];
            trace = trace::ray_trace( tstart, tend, ignoreents, contentoverride, 0 );
        }
        
        if ( trace[ "fraction" ] != 1 )
        {
            playfx( level.gos_fx[ "gos_fireworks" ], trace[ "position" ] );
            playfx( level.gos_fx[ "gos_fireworks" ], trace[ "position" ], anglestoforward( self.flagmodel.angles ) + ( -10, -10, 0 ) );
            playfx( level.gos_fx[ "gos_fireworks" ], trace[ "position" ], anglestoforward( self.flagmodel.angles ) + ( 10, 10, 0 ) );
            level thread common::function_fe04807712ae0304( trace[ "position" ] );
        }
        
        return;
    }
    
    playfx( level.gos_fx[ "gos_fireworks" ], origin );
    playfx( level.gos_fx[ "gos_fireworks" ], origin, anglestoforward( self.flagmodel.angles ) + ( -10, -10, 0 ) );
    playfx( level.gos_fx[ "gos_fireworks" ], origin, anglestoforward( self.flagmodel.angles ) + ( 10, 10, 0 ) );
    level thread common::function_fe04807712ae0304( origin );
}

// Namespace obj_dom
// Params 0
// Checksum 0xa1d83c3, Offset: 0x3425
// Size: 0x1e
function dompoint_setupflagmodels()
{
    game[ "flagmodels" ] = [];
    game[ "flagmodels" ][ "neutral" ] = "prop_flag_neutral";
}

// Namespace obj_dom
// Params 3
// Checksum 0x860f082d, Offset: 0x344b
// Size: 0x25b
function updateflagstate( state, keeppulse, ownerteam )
{
    self notify( #"hash_89d071c9fa9b8613" );
    self endon( #"hash_89d071c9fa9b8613" );
    
    if ( isdefined( ownerteam ) && !self.var_c95f5d841e441c5b )
    {
        if ( getdvarint( @"hash_33af98c375b98d29" ) == 1 )
        {
            if ( ownerteam == "allies" )
            {
                self.flagmodel setmodel( "military_dom_flag_west" );
                self.vfxnamemod setscriptablepartstate( "flag", "allies" );
            }
            else if ( ownerteam == "axis" )
            {
                self.flagmodel setmodel( "military_dom_flag_east" );
                self.vfxnamemod setscriptablepartstate( "flag", "axis" );
            }
            else
            {
                self.flagmodel setmodel( "military_dom_flag_neutral" );
                self.vfxnamemod setscriptablepartstate( "flag", "idle" );
            }
        }
        else if ( !isdefined( level.gametypebundle.var_f5aa48dc14c98203 ) )
        {
            if ( ownerteam == "allies" )
            {
                self.flagmodel setmodel( level.gametypebundle.var_2c36988efe2e833 ?? "military_dom_flag_west" );
            }
            else if ( ownerteam == "axis" )
            {
                self.flagmodel setmodel( level.gametypebundle.var_a5e47e320e7e02f6 ?? "military_dom_flag_east" );
            }
            else
            {
                self.flagmodel setmodel( level.gametypebundle.var_834f51977cd32b4c ?? "military_dom_flag_neutral" );
            }
        }
    }
    
    if ( isdefined( self.noscriptable ) )
    {
        return;
    }
    
    while ( !isdefined( self.scriptable ) )
    {
        waitframe();
    }
    
    if ( game_utility::getgametype() == "defcon" )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
    {
        return;
    }
    
    if ( isdefined( self.scriptable ) )
    {
        if ( state == "off" )
        {
            setdomscriptablepartstate( "flag", state );
        }
        else
        {
            setdomscriptablepartstate( "flag", state, self.vfxnamemod );
        }
        
        if ( !keeppulse )
        {
            setdomscriptablepartstate( "pulse", "off" );
        }
    }
    
    function_c18eb83275e643e7( self );
}

// Namespace obj_dom
// Params 3
// Checksum 0xdf82a8c5, Offset: 0x36ae
// Size: 0x6a
function setdomscriptablepartstate( part, state, statemod )
{
    if ( !isdefined( self.scriptable ) )
    {
        return;
    }
    
    if ( isdefined( level.setdomscriptablepartstatefunc ) )
    {
        if ( [[ level.setdomscriptablepartstatefunc ]]( part, state, statemod ) )
        {
            return;
        }
    }
    
    if ( isdefined( statemod ) )
    {
        state += statemod;
    }
    
    self.scriptable setscriptablepartstate( part, state );
}

// Namespace obj_dom
// Params 1
// Checksum 0x70856baf, Offset: 0x3720
// Size: 0x6d
function updateflagcapturestate( state )
{
    if ( isdefined( self.noscriptable ) )
    {
        return;
    }
    
    if ( game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" && game_utility::getgametype() != "defcon" )
    {
        if ( isdefined( self.scriptable ) )
        {
            setdomscriptablepartstate( "pulse", state, self.vfxnamemod );
        }
    }
}

// Namespace obj_dom
// Params 0
// Checksum 0x59b72ff9, Offset: 0x3795
// Size: 0x107
function ondisconnect()
{
    self waittill( #"disconnect" );
    
    foreach ( effect in self._domflageffect )
    {
        if ( isdefined( effect ) )
        {
            effect delete();
        }
    }
    
    foreach ( pulseeffect in self._domflagpulseeffect )
    {
        if ( isdefined( pulseeffect ) )
        {
            pulseeffect delete();
        }
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0x18858a0f, Offset: 0x38a4
// Size: 0x171
function giveflagassistedcapturepoints( touchlist )
{
    level endon( #"game_ended" );
    players_touching = getarraykeys( touchlist );
    
    for ( index = 0; index < players_touching.size ; index++ )
    {
        player = touchlist[ players_touching[ index ] ].player;
        var_c92a6378b3d76d77 = touchlist[ players_touching[ index ] ].player;
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( level.flagneutralization )
        {
            if ( gameobjects::function_e17a356e69f57699( var_c92a6378b3d76d77 ) )
            {
                player thread rank::scoreeventpopup( #"neutralized_capture_bot" );
            }
            else
            {
                player thread rank::function_d2aa8986c506e985( #"neutralized" );
            }
        }
        else if ( gameobjects::function_e17a356e69f57699( var_c92a6378b3d76d77 ) )
        {
            player thread rank::scoreeventpopup( #"capture_capture_bot" );
        }
        else
        {
            player thread rank::function_d2aa8986c506e985( #"capture" );
        }
        
        if ( gameobjects::function_e17a356e69f57699( var_c92a6378b3d76d77 ) )
        {
            player thread points::doscoreevent( #"mode_dom_neutralized_capture_bot" );
        }
        else
        {
            player thread points::doscoreevent( #"mode_dom_neutralized" );
        }
        
        if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
        {
            player [[ level.var_f0e13be5ddad6cd1 ]]( player );
        }
        
        wait 0.05;
    }
}

// Namespace obj_dom
// Params 3
// Checksum 0xe4b2b73e, Offset: 0x3a1d
// Size: 0x36b
function function_800ad8847b209fee( touchlist, credit_player, team )
{
    level endon( #"game_ended" );
    first_player = credit_player;
    
    if ( isdefined( first_player.owner ) )
    {
        first_player = first_player.owner;
    }
    
    level.lastcaptime = gettime();
    level.playholdtwovo = 1;
    
    if ( isplayer( first_player ) )
    {
        if ( level.gametypebundle.var_4604a4307c97de29 )
        {
            level thread hud_util::teamplayercardsplash( "callout_securedposition", first_player );
        }
        else
        {
            level thread hud_util::teamplayercardsplash( "callout_securedposition" + self.objectivekey, first_player );
        }
        
        telemetry_data = spawnstruct();
        telemetry_data.player = first_player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = first_player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    }
    
    if ( self.firstcapture == 1 )
    {
        isneutral = 1;
    }
    else
    {
        isneutral = 0;
    }
    
    if ( isdefined( touchlist ) )
    {
        players_touching = getarraykeys( touchlist );
        
        for ( index = 0; index < players_touching.size ; index++ )
        {
            player = touchlist[ players_touching[ index ] ].player;
            var_732a274f9955b037 = 0;
            
            if ( isdefined( player.owner ) )
            {
                if ( gameobjects::function_e17a356e69f57699( player ) && !arraycontains( players_touching, player.owner ) )
                {
                    var_732a274f9955b037 = 1;
                    player callback::callback( #"hash_a4b2d4dcbb4cda95", { #capturebot:player } );
                }
                
                player = player.owner;
            }
            
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player setcapturestats();
            givecaptureawards( player, isneutral, 0, var_732a274f9955b037 );
            
            if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
            {
                player [[ level.var_f0e13be5ddad6cd1 ]]( player );
            }
            
            objidpoolmanager::function_9d3f184285ca25e4( &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player );
            wait 0.05;
        }
        
        if ( isdefined( self.assisttouchlist ) )
        {
            if ( self.assisttouchlist[ team ].size > 0 )
            {
                var_e1fea56171575e06 = getarraykeys( self.assisttouchlist[ team ] );
                
                foreach ( id in players_touching )
                {
                    foreach ( assistid in var_e1fea56171575e06 )
                    {
                        if ( assistid == id )
                        {
                            self.assisttouchlist[ team ][ assistid ] = undefined;
                        }
                    }
                }
            }
            
            if ( self.assisttouchlist[ team ].size > 0 )
            {
                thread giveflagcaptureassistxp( team, isneutral );
            }
        }
    }
}

// Namespace obj_dom
// Params 2
// Checksum 0xeb5a818c, Offset: 0x3d90
// Size: 0x12d
function giveflagcaptureassistxp( team, isneutral )
{
    level endon( #"game_ended" );
    var_e1fea56171575e06 = getarraykeys( self.assisttouchlist[ team ] );
    
    if ( var_e1fea56171575e06.size > 0 )
    {
        for ( index = 0; index < var_e1fea56171575e06.size ; index++ )
        {
            var_579594a526a2bc81 = self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ];
            var_732a274f9955b037 = istrue( var_579594a526a2bc81.var_6bb8fd38a10ae39b );
            
            if ( var_732a274f9955b037 )
            {
                if ( isdefined( var_579594a526a2bc81.owner ) )
                {
                    player = var_579594a526a2bc81.owner;
                    
                    if ( gameobjects::function_e17a356e69f57699( player ) )
                    {
                        var_732a274f9955b037 = 1;
                    }
                }
                else
                {
                    player = undefined;
                }
            }
            else
            {
                player = var_579594a526a2bc81.player;
            }
            
            if ( isdefined( player ) )
            {
                player setcapturestats();
                givecaptureawards( player, isneutral, 1, var_732a274f9955b037 );
                
                if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
                {
                    player [[ level.var_f0e13be5ddad6cd1 ]]( player );
                }
            }
            
            self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ] = undefined;
            wait 0.05;
        }
    }
}

// Namespace obj_dom
// Params 4
// Checksum 0x6c4ab86d, Offset: 0x3ec5
// Size: 0x319
function givecaptureawards( player, isneutral, isassist, iscapturebot )
{
    givestreakpoint = 0;
    awardtype = #"";
    
    if ( isassist && !level.gamemodebundle.var_9a091b8fbf3b4e70 )
    {
        if ( iscapturebot )
        {
            awardtype = #"capture_assist_capture_bot";
        }
        else
        {
            player thread rank::function_d2aa8986c506e985( #"capture_assist" );
            awardtype = #"mode_dom_secure_assist";
        }
    }
    else if ( isneutral )
    {
        isarm = game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "gwai";
        ismidpoint = !isarm && self.objectivekey == "_b" || isarm && self.objectivekey == "_c";
        var_b59d802ee604b141 = isarm && ( self.objectivekey == "_b" || self.objectivekey == "_d" );
        
        if ( ismidpoint )
        {
            if ( isarm )
            {
                if ( iscapturebot )
                {
                    awardtype = #"neutral_capture_capture_bot";
                }
                else
                {
                    player thread rank::function_d2aa8986c506e985( #"neutral_capture" );
                    awardtype = #"mode_arm_secure_mid";
                }
            }
            else if ( iscapturebot )
            {
                awardtype = #"neutral_b_capture_capture_bot";
            }
            else
            {
                player thread rank::function_d2aa8986c506e985( #"neutral_b_capture", self.objectivekey );
                awardtype = #"mode_dom_secure_b";
                player thread smoke_grenade::function_99543ad5d551cdb5();
            }
        }
        else if ( var_b59d802ee604b141 )
        {
            if ( iscapturebot )
            {
                awardtype = #"neutral_capture_capture_bot";
            }
            else
            {
                player thread rank::function_d2aa8986c506e985( #"neutral_capture" );
                awardtype = #"mode_arm_secure_outer_mid";
            }
        }
        else if ( isarm )
        {
            if ( iscapturebot )
            {
                awardtype = #"neutral_capture_capture_bot";
            }
            else
            {
                player thread rank::function_d2aa8986c506e985( #"neutral_capture" );
                awardtype = #"mode_arm_secure_outer";
            }
        }
        else if ( iscapturebot )
        {
            awardtype = #"neutral_capture_capture_bot";
        }
        else
        {
            player thread rank::function_d2aa8986c506e985( #"neutral_capture", self.objectivekey );
            awardtype = #"mode_dom_secure_neutral";
            player thread smoke_grenade::function_99543ad5d551cdb5();
        }
    }
    else if ( level.flagneutralization )
    {
        if ( iscapturebot )
        {
            awardtype = #"capture_capture_bot";
        }
        else
        {
            player thread rank::function_d2aa8986c506e985( #"capture" );
            awardtype = #"mode_dom_neutralized_cap";
        }
    }
    else if ( iscapturebot )
    {
        awardtype = #"capture_capture_bot";
    }
    else
    {
        player thread rank::function_d2aa8986c506e985( #"capture", self.objectivekey );
        awardtype = #"mode_dom_secure";
        player thread smoke_grenade::function_99543ad5d551cdb5();
    }
    
    player thread points::doscoreevent( awardtype );
    
    if ( givestreakpoint )
    {
        player killstreaks::givestreakpoints( #"capture", 1, 0 );
    }
}

// Namespace obj_dom
// Params 0
// Checksum 0x2f1b1afd, Offset: 0x41e6
// Size: 0x131
function setcapturestats()
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "captures" ] ) )
        {
            self.leaderboarddata[ "captures" ] = self.leaderboarddata[ "captures" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
        {
            [[ level.leaderboardfunc[ "captures" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xfc>" );
        
        if ( isdefined( self.pers[ "captures" ] ) )
        {
            self.pers[ "captures" ] = self.pers[ "captures" ] + 1;
        }
    }
    
    if ( isdefined( self.pers[ "captures" ] ) )
    {
        persistence::statsetchild( "round", "captures", self.pers[ "captures" ] );
        
        if ( game_utility::getgametype() != "arena" )
        {
            stats::setextrascore0( self.pers[ "captures" ], "captures" );
        }
    }
}

// Namespace obj_dom
// Params 1
// Checksum 0x563b6652, Offset: 0x431f
// Size: 0x126
function precap( var_dbd5a51302ba33e0 )
{
    storecenterflag( var_dbd5a51302ba33e0 );
    excludedflags = [];
    excludedflags[ excludedflags.size ] = level.centerflag;
    
    if ( game[ "switchedsides" ] )
    {
        level.closestalliesflag = getunownedflagneareststart( "axis", level.centerflag );
        excludedflags[ excludedflags.size ] = level.closestalliesflag;
        level.closestaxisflag = getunownedflagneareststart( "allies", excludedflags );
    }
    else
    {
        level.closestalliesflag = getunownedflagneareststart( "allies", level.centerflag );
        excludedflags[ excludedflags.size ] = level.closestalliesflag;
        level.closestaxisflag = getunownedflagneareststart( "axis", excludedflags );
    }
    
    level.closestalliesflag setflagcaptured( "allies", "neutral", undefined, 1 );
    level.closestalliesflag function_53dac00aa4dc7c59( "allies" );
    level.closestaxisflag setflagcaptured( "axis", "neutral", undefined, 1 );
    level.closestaxisflag function_53dac00aa4dc7c59( "axis" );
}

// Namespace obj_dom
// Params 1
// Checksum 0xb18e20a, Offset: 0x444d
// Size: 0xbf
function storecenterflag( var_dbd5a51302ba33e0 )
{
    foreach ( flag in level.objectives )
    {
        if ( var_dbd5a51302ba33e0 )
        {
            if ( flag.objectivekey == "_c" )
            {
                level.centerflag = flag;
            }
        }
        
        if ( flag.objectivekey == "_b" )
        {
            level.centerflag = flag;
        }
    }
}

// Namespace obj_dom
// Params 4
// Checksum 0xd1eb2732, Offset: 0x4514
// Size: 0x18b
function setflagcaptured( team, oldteam, credit_player, var_8d37b46d4cfd0995 )
{
    gameobjects::setownerteam( team );
    gameobjects::setobjectivestatusicons( self.icons.icondefending ?? level.icondefending, self.icons.iconcapture ?? level.iconcapture );
    thread updateflagstate( team, 0, team );
    self.capturetime = gettime();
    gametype = game_utility::getgametype();
    
    if ( gametype == "siege" )
    {
        siege::watchflagenduse( team );
    }
    
    if ( !isdefined( var_8d37b46d4cfd0995 ) )
    {
        if ( oldteam != "neutral" )
        {
            ownedflags = getteamflagcount( team );
            
            if ( ownedflags == 2 )
            {
                dialog::statusdialog( "friendly_captured_2", team );
                dialog::statusdialog( "enemy_captured_2", oldteam );
            }
            else
            {
                dialog::statusdialog( "secured" + ( self.var_98076e259d94a508 ?? self.objectivekey ), team );
                dialog::statusdialog( "lost" + ( self.var_98076e259d94a508 ?? self.objectivekey ), oldteam );
            }
            
            level.lastcaptime = gettime();
        }
        
        if ( gametype == "siege" )
        {
            siege::teamrespawn( team, credit_player );
        }
        
        self.firstcapture = 0;
    }
    
    if ( self.var_2809cba8dafcf8cf )
    {
        gameobjects::allowuse( "any" );
    }
}

// Namespace obj_dom
// Params 2
// Checksum 0x49b49a36, Offset: 0x46a7
// Size: 0xf2
function getteamflagcount( team, evaluatecontested )
{
    score = 0;
    
    foreach ( objective in level.objectives )
    {
        if ( evaluatecontested )
        {
            if ( objective.stalemate || objective.captureblocked || objective.claimteam != "none" && objective.claimteam != team )
            {
                continue;
            }
        }
        
        if ( objective.ownerteam == team )
        {
            score++;
        }
    }
    
    return score;
}

// Namespace obj_dom
// Params 2
// Checksum 0xd378f812, Offset: 0x47a2
// Size: 0xb0
function isflagexcluded( var_e2063b0b33353f7, excludeflag )
{
    excluded = 0;
    
    if ( isarray( excludeflag ) )
    {
        foreach ( flag in excludeflag )
        {
            if ( var_e2063b0b33353f7 == flag )
            {
                excluded = 1;
                break;
            }
        }
    }
    else if ( var_e2063b0b33353f7 == excludeflag )
    {
        excluded = 1;
    }
    
    return excluded;
}

// Namespace obj_dom
// Params 2
// Checksum 0xe469512e, Offset: 0x485b
// Size: 0x125
function getunownedflagneareststart( team, excludeflag )
{
    best = undefined;
    bestdistsq = undefined;
    
    foreach ( flag in level.objectives )
    {
        if ( flag gameobjects::getownerteam() != "neutral" )
        {
            continue;
        }
        
        distsq = distancesquared( flag.trigger.origin, level.startpos[ team ] );
        
        if ( isdefined( excludeflag ) )
        {
            if ( !isflagexcluded( flag, excludeflag ) && ( !isdefined( best ) || distsq < bestdistsq ) )
            {
                bestdistsq = distsq;
                best = flag;
            }
            
            continue;
        }
        
        if ( !isdefined( best ) || distsq < bestdistsq )
        {
            bestdistsq = distsq;
            best = flag;
        }
    }
    
    return best;
}

// Namespace obj_dom
// Params 10
// Checksum 0xacdc6a0f, Offset: 0x4989
// Size: 0x736
function awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( isagent( attacker ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker ) && isdefined( self ) ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker.team ) && isdefined( self.team ) ) )
    {
        return;
    }
    
    if ( !attacker player_utility::isenemy( self ) )
    {
        return;
    }
    
    awardedassault = 0;
    awardeddefend = 0;
    victim = self;
    victimpos = victim.origin;
    attackerpos = einflictor.origin ?? attacker.origin;
    
    foreach ( flag in level.objectives )
    {
        if ( !isdefined( flag.trigger ) || flag.trigger.trigger_off )
        {
            continue;
        }
        
        ownerteam = flag gameobjects::getownerteam();
        attackertouching = attacker istouching( flag.trigger );
        victimtouching = victim istouching( flag.trigger );
        sitekey = flag.objectivekey;
        
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && attackertouching && attacker.team != ownerteam )
        {
            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
            flag notify( #"assault", attacker );
            awardedassault = 1;
        }
        
        if ( attackertouching && ownerteam === attacker.team && isdefined( attacker.var_c36e159445e2a48b ) )
        {
            attacker.var_c36e159445e2a48b += 1;
            
            if ( attacker.var_c36e159445e2a48b == 5 )
            {
                attacker thread events::function_d4fd7d540188e407();
            }
        }
        
        if ( ownerteam == "neutral" )
        {
            if ( attackertouching || victimtouching )
            {
                if ( flag.claimteam == victim.team )
                {
                    if ( !awardedassault )
                    {
                        awardedassault = 1;
                        attacker thread rank::function_d2aa8986c506e985( #"assault" );
                        attacker events::function_58da673c1c3fc9f2();
                        flag notify( #"assault", attacker );
                        thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                        continue;
                    }
                }
                else if ( flag.claimteam == attacker.team )
                {
                    if ( !awardeddefend )
                    {
                        awardeddefend = 1;
                        attacker thread rank::function_d2aa8986c506e985( #"defend", sitekey );
                        attacker events::function_20a5f572df6afd43( { #extraparam:sitekey } );
                        flag notify( #"defend", attacker );
                        
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                            {
                                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                            {
                                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xfc>" );
                            
                            if ( isdefined( attacker.pers[ "defends" ] ) )
                            {
                                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                            }
                        }
                        
                        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                        attacker stats::setextrascore1( attacker.pers[ "defends" ], "defends" );
                        thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
                        continue;
                    }
                }
            }
            
            continue;
        }
        
        if ( ownerteam != attacker.team )
        {
            if ( !awardedassault )
            {
                giveassault = attackertouching || victimtouching || !level.scoreeventglobals.var_4c03945aaec4f6b7 && distsquaredcheck( flag.trigger, attackerpos, victimpos );
                
                if ( giveassault )
                {
                    awardedassault = 1;
                    attacker thread rank::function_d2aa8986c506e985( #"assault" );
                    attacker events::function_58da673c1c3fc9f2();
                    flag notify( #"assault", attacker );
                    
                    if ( victimtouching )
                    {
                        attacker thread events::function_f3b6ddfecdb144fa( sitekey );
                    }
                    
                    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                    continue;
                }
            }
            
            continue;
        }
        
        if ( !awardeddefend )
        {
            givedefend = victimtouching || !level.scoreeventglobals.var_4c03945aaec4f6b7 && distsquaredcheck( flag.trigger, attackerpos, victimpos );
            
            if ( givedefend )
            {
                awardeddefend = 1;
                attacker thread rank::function_d2aa8986c506e985( #"defend", sitekey );
                attacker events::function_20a5f572df6afd43( { #extraparam:sitekey } );
                flag notify( #"defend", attacker );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                    {
                        attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                    {
                        [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xfc>" );
                    
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                    }
                }
                
                attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                attacker stats::setextrascore1( attacker.pers[ "defends" ], "defends" );
                thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
            }
        }
    }
}

// Namespace obj_dom
// Params 3
// Checksum 0xa70f6455, Offset: 0x50c7
// Size: 0xfd
function distsquaredcheck( trigger, attackerpos, victimpos )
{
    var_239d2a4c215037cd = distancesquared( trigger.origin, attackerpos );
    var_675b1291697b281a = distancesquared( trigger.origin, victimpos );
    var_55a2287e66607fa2 = game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict";
    var_b521e3a631793c30 = var_55a2287e66607fa2 ? 422500 : 105625;
    
    if ( var_239d2a4c215037cd < var_b521e3a631793c30 || var_675b1291697b281a < var_b521e3a631793c30 )
    {
        if ( !isdefined( trigger.modifieddefendcheck ) )
        {
            return 1;
        }
        else if ( attackerpos[ 2 ] - trigger.origin[ 2 ] < 100 || victimpos[ 2 ] - trigger.origin[ 2 ] < 100 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace obj_dom
// Params 0
// Checksum 0xa7ebdad8, Offset: 0x51cc
// Size: 0x4f
function getdomneutralizeomnvarvalue()
{
    switch ( self.objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 6;
        case #"hash_fac2c2f6bddd4504":
            return 7;
        case #"hash_fac2c3f6bddd4697":
            return 8;
        default:
            return 6;
    }
}

// Namespace obj_dom
// Params 0
// Checksum 0xf0affad8, Offset: 0x5223
// Size: 0x7f
function getobjectiveflag()
{
    switch ( self.objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return "A";
        case #"hash_fac2c2f6bddd4504":
            return "B";
        case #"hash_fac2c3f6bddd4697":
            return "C";
        case #"hash_fac2c0f6bddd41de":
            return "D";
        case #"hash_fac2c1f6bddd4371":
            return "E";
        default:
            return "";
    }
}

// Namespace obj_dom
// Params 3
// Checksum 0x972a9d3c, Offset: 0x52aa
// Size: 0x52
function oncontested_playsoundatpos( posorigin, soundref, timer )
{
    if ( !isdefined( self.contestedbool ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( posorigin, soundref );
        self.contestedbool = 1;
        wait timer;
        self.contestedbool = undefined;
        return;
    }
    
    return;
}

// Namespace obj_dom
// Params 3
// Checksum 0xbb4955c5, Offset: 0x5304
// Size: 0x52
function onuncontested_playsoundatpos( posorigin, soundref, timer )
{
    if ( !isdefined( self.uncontestedbool ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( posorigin, soundref );
        self.uncontestedbool = 1;
        wait timer;
        self.uncontestedbool = undefined;
        return;
    }
    
    return;
}

// Namespace obj_dom
// Params 0
// Checksum 0xfec96dff, Offset: 0x535e
// Size: 0x9b
function function_45132b4fe3e00ecc()
{
    if ( !isdefined( self.influencers ) )
    {
        self.influencers = [];
    }
    
    foreach ( influencer in self.influencers )
    {
        spawnlogic::removespawninfluencer( influencer );
    }
    
    self.influencers = [];
}

// Namespace obj_dom
// Params 0
// Checksum 0xf5a36736, Offset: 0x5401
// Size: 0x84
function function_b0f6c7bb3c2c7e74()
{
    foreach ( influencer in self.influencers )
    {
        spawnlogic::influencersetspawnpointlist( influencer, self.spawnset );
    }
}

// Namespace obj_dom
// Params 2
// Checksum 0xc1355b75, Offset: 0x548d
// Size: 0xe7
function function_490ad82155077d38( keys, team )
{
    function_45132b4fe3e00ecc();
    
    if ( !isdefined( self.spawnset ) )
    {
        return;
    }
    
    foreach ( key in keys )
    {
        if ( isdefined( self.influencerkeys[ key ] ) )
        {
            self.influencers[ self.influencers.size ] = spawnlogic::addspawninfluencer( self.influencerkeys[ key ], self.trigger.origin, team );
        }
    }
    
    function_b0f6c7bb3c2c7e74();
}

// Namespace obj_dom
// Params 0
// Checksum 0xa7bf1fd9, Offset: 0x557c
// Size: 0x13
function function_98c658171dfa958e()
{
    function_490ad82155077d38( [ "neutral" ] );
}

// Namespace obj_dom
// Params 1
// Checksum 0xe0639fb9, Offset: 0x5597
// Size: 0x28
function function_53dac00aa4dc7c59( team )
{
    function_490ad82155077d38( [ "other", "owner" ], team );
}

