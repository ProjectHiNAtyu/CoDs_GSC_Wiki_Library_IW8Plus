// script_1ecac15e80f0648b  (hash_1ecac15e80f0648b.gscc) (size: 12090 Bytes / 0x2f3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca26e81e (3391547422)
// size ...... 12090 (0x2f3a)
// includes .. 14  (offset: 0x2cc6)
// strings ... 39  (offset: 0x2d36)
// dev strs .. 0   (offset: 0x2f3a)
// exports ... 35  (offset: 0x1ac2)
// cseg ...... 0x387 + 0x173b (0x1ac2)
// imports ... 106 (offset: 0x203a)
// animtree1 . 0   (offset: 0x2f3a)
// animtree2 . 0   (offset: 0x2f3a)
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\skirmish_activity_manager;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\objidpoolmanager;

#namespace namespace_7ea6f131e1a9874d;

// Namespace namespace_7ea6f131e1a9874d
// Params 0
// Checksum 0xaa22441e, Offset: 0x3a5
// Size: 0x121
function init()
{
    function_f913ba8a0b142ccd();
    level.blockcapdisabled = getmatchrulesdata( "domData", "flagBlockCapDisabled" );
    level.disablemajoritycapprogress = getmatchrulesdata( "controlData", "disableMajorityCapProgress" );
    level.domflag_setneutral = &obj_dom::domflag_setneutral;
    level.dompoint_setcaptured = &obj_dom::dompoint_setcaptured;
    level.usestrongholdhills = 1;
    level.flagcapturetime = getmatchrulesdata( "skirmishData", "captureObjTime" );
    level.var_85b177faa9935b2a.var_c5a093ef905d1289 = getdvarint( @"hash_49d774ad4f3ade95", level.gametypebundle.var_c5a093ef905d1289 );
    utility::registersharedfunc( #"hash_40d67563347fab4d", #"hash_d824fa7d72609c65", &function_f459d7a9e70e203a );
    utility::registersharedfunc( #"hash_a6619fd2a3c21adc", #"hash_5ee1271a3e3fc202", &function_7e78e646ec0be0a7 );
    utility::registersharedfunc( #"hash_a6619fd2a3c21adc", #"hash_6dd488d05199686c", &function_de622032224cefd1 );
    utility::registersharedfunc( #"hash_1cf9f03cfa3cf394", #"hash_eb206fa0ea79a96", &function_9e5bffa15724167d );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1
// Checksum 0x7747a540, Offset: 0x4ce
// Size: 0x186
function function_460ac0da13315aaf( params )
{
    assert( isstruct( params ) );
    
    if ( !isdefined( params.target ) )
    {
        assert( 0 );
        return;
    }
    
    triggers = getentarray( "skirmish_flag", #targetname );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.target == params.target )
        {
            domzone = obj_dom::setupobjective( trigger, undefined, 0, 0, 0, undefined, ( 0, 0, 0 ) );
            function_8eab38514b79538d( domzone.objidnum, getdvarint( @"hash_1e0197370cf88095", 7874 ) );
            objective_setbackground( domzone.objidnum, 0 );
            function_c97f0baa8ba1ccc6( domzone.objidnum, "sat_ui_hud_skirmish_waypoint_high_value_sector_star_tacmap" );
            domzone.activitytype = params.type;
            domzone.activityname = params.name;
            level.objectives[ domzone.objectivekey ] = domzone;
            return domzone;
        }
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2
// Checksum 0x452d5a59, Offset: 0x65d
// Size: 0x241
function function_11f45fc99e57dd8d( domflag, params )
{
    level endon( #"game_ended" );
    domflag.onuse = &dompoint_onuse;
    domflag.onbeginuse = &dom_onbeginuse;
    domflag.onenduse = &dom_onenduse;
    domflag.oncontested = &dom_oncontested;
    domflag.onuncontested = &dom_onuncontested;
    domflag.onunoccupied = &dom_onunoccupied;
    domflag.var_b555f7427386495e = &function_b555f7427386495e;
    domflag.onuseupdate = &dom_onuseupdate;
    
    if ( game_utility::getgametype() == "skirmishbt" )
    {
        domflag.onpinnedstate = &dom_onpinnedstate;
        domflag.onunpinnedstate = &dom_onunpinnedstate;
        level.var_6acc53d8aaa7d1e3 = &function_420eaefd3e54cba9;
    }
    
    domflag.oncleared = &function_759196e1bdad8cfc;
    domflag.ondecayed = &obj_dom::function_759196e1bdad8cfc;
    domflag.stompeenemyprogressupdate = &function_f34a963a85701530;
    domflag.var_5d3a98427fc9c778 = &function_5f56df64c4f83074;
    domflag.iconname = "";
    domflag.activitytype = params.type;
    domflag.activityname = params.name;
    function_ca1cc2938b2b4271( domflag.objidnum, domflag.trigger );
    var_7ee2b245024a3b63 = skirmish_util::function_afc407a06438534e( domflag ) ? "SKR_Capture_Objective_Heat" : "SKR_Capture_Objective";
    domflag game_utility::questcircle_create( var_7ee2b245024a3b63, domflag.trigger.origin, level.var_fd5a14340d3320e9 );
    domflag game_utility::questcircle_showtoall();
    domflag gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
    domflag gameobjects::setvisibleteam( "any" );
    domflag thread dom::domchevrons( domflag.trigger.target, domflag.trigger.script_label );
    domflag obj_dom::domflag_setneutral();
    domflag thread function_488ef8fbc750632c();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0xa7c6de4c, Offset: 0x8a6
// Size: 0xae
function private function_488ef8fbc750632c()
{
    waitframe();
    
    foreach ( team in level.teamnamelist )
    {
        if ( self.numtouching[ team ] > 0 )
        {
            function_e3fcb3861310bb48();
            update_chevrons();
            skirmish_util::function_27e85aa699653fa1( level.iconlosing, level.icontaking );
            break;
        }
    }
}

/#

    // Namespace namespace_7ea6f131e1a9874d
    // Params 1
    // Checksum 0xfd5405fc, Offset: 0x95c
    // Size: 0x1a, Type: dev
    function function_eb532914fbf1526( params )
    {
        assert( isstruct( params ) );
    }

#/

// Namespace namespace_7ea6f131e1a9874d
// Params 1
// Checksum 0xd3041a97, Offset: 0x97e
// Size: 0xae
function function_1f7103ac976709bd( desiredtarget )
{
    triggers = getentarray( "skirmish_flag", #targetname );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.target == desiredtarget )
        {
            return trigger.origin;
        }
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0xc705136f, Offset: 0xa34
// Size: 0x72
function private function_f913ba8a0b142ccd()
{
    level.iconcapture = "waypoint_capture";
    level.iconneutral = "waypoint_captureneutral";
    level.icondefend = "waypoint_defend";
    level.iconcontested = "waypoint_contested";
    level.icondefending = "waypoint_defending";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0xce336095, Offset: 0xaae
// Size: 0xd8
function private dompoint_onuse( credit_player )
{
    obj_dom::dompoint_onuse( credit_player, credit_player.team );
    
    if ( isdefined( level.teamscoresonkill ) )
    {
        foreach ( team in level.teamnamelist )
        {
            var_d9425977785add8f = obj_dom::getteamflagcount( team );
            level.teamscoresonkill[ team ] = var_d9425977785add8f >= level.numflagsscoreonkill && var_d9425977785add8f >= level.flagsrequiredtoscore;
        }
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2, eflags: 0x4
// Checksum 0xf24f94af, Offset: 0xb8e
// Size: 0x5e
function private function_4182d90a03106e51( var_31c256c86b8dccfe, var_d2fcf6de055fff09 )
{
    omnvar_offset = 23;
    omnvar_utility::function_8b206c75cb7ad548( "ui_objective_" + self.zone, omnvar_offset, 2, var_31c256c86b8dccfe );
    omnvar_utility::function_8b206c75cb7ad548( "ui_objective_" + self.zone, omnvar_offset + 2, 2, var_d2fcf6de055fff09 );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0x29ac0d2d, Offset: 0xbf4
// Size: 0x14c
function private function_e3fcb3861310bb48()
{
    alliescount = self.numtouching[ "allies" ];
    axiscount = self.numtouching[ "axis" ];
    
    if ( alliescount == 0 || axiscount == 0 )
    {
        function_4182d90a03106e51( 0, 0 );
        return;
    }
    
    winningcount = alliescount > axiscount ? alliescount : axiscount;
    losingcount = alliescount <= axiscount ? alliescount : axiscount;
    ratiostrength = losingcount / winningcount;
    var_311f9d9599df4d11 = abs( ratiostrength - 0.333333 );
    var_904e530aacfbbfd1 = abs( ratiostrength - 0.5 );
    var_74a793e70b69ae6c = abs( ratiostrength - 0.666667 );
    var_174c02eeeeac6438 = 3;
    var_6eef0848ddbbb502 = 2;
    
    if ( var_311f9d9599df4d11 <= var_904e530aacfbbfd1 && var_311f9d9599df4d11 <= var_74a793e70b69ae6c )
    {
        var_174c02eeeeac6438 = 3;
        var_6eef0848ddbbb502 = 1;
    }
    else if ( var_904e530aacfbbfd1 <= var_311f9d9599df4d11 && var_904e530aacfbbfd1 <= var_74a793e70b69ae6c )
    {
        var_174c02eeeeac6438 = 2;
        var_6eef0848ddbbb502 = 1;
    }
    
    if ( alliescount > axiscount )
    {
        var_31c256c86b8dccfe = var_174c02eeeeac6438;
        var_d2fcf6de055fff09 = var_6eef0848ddbbb502;
    }
    else
    {
        var_31c256c86b8dccfe = var_6eef0848ddbbb502;
        var_d2fcf6de055fff09 = var_174c02eeeeac6438;
    }
    
    function_4182d90a03106e51( var_31c256c86b8dccfe, var_d2fcf6de055fff09 );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0xb89d9f18, Offset: 0xd48
// Size: 0x41
function private function_f7c8b4e761654439()
{
    alliescount = self.numtouching[ "allies" ];
    chevroncount = minint( int( ceil( alliescount ) ), 3 );
    function_4182d90a03106e51( chevroncount, chevroncount );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0x7e6835e9, Offset: 0xd91
// Size: 0x29
function private dom_onbeginuse( player )
{
    obj_dom::dompoint_onusebegin( player );
    self.var_c6730a47f6468888 = gettime();
    update_chevrons();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 4, eflags: 0x4
// Checksum 0xd02b7413, Offset: 0xdc2
// Size: 0xe0
function private dom_onuseupdate( team, progress, change, capplayer )
{
    obj_dom::dompoint_onuseupdate( team, progress, change, capplayer );
    
    if ( !isdefined( self.currentteam ) )
    {
        self.currentteam = team;
    }
    
    if ( self.teamprogress[ team ] > 0 && self.currentteam != team )
    {
        skirmish_util::function_27e85aa699653fa1( level.iconlosing, level.icontaking );
        self.currentteam = team;
    }
    
    function_e3fcb3861310bb48();
    
    if ( self.var_c6730a47f6468888 < gettime() - 5000 )
    {
        self.var_c6730a47f6468888 = gettime();
        capturing_players = gameobjects::function_2c38b77b2ae4bfc5( team );
        skirmish_util::function_7691fe63b803b07e( capturing_players, team, #"hash_9c4353c2b7c0d93" );
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 3, eflags: 0x4
// Checksum 0x2da658e, Offset: 0xeaa
// Size: 0x155
function private function_de622032224cefd1( team, progress, capplayer )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( !isdefined( self.var_756ce2ec4a637567 ) )
    {
        self.var_756ce2ec4a637567 = 995;
    }
    
    if ( self.lastsfxplayedtime + self.var_756ce2ec4a637567 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var_4a62b0f6788ba18e = progress * 100;
        
        if ( var_4a62b0f6788ba18e < 50 )
        {
            var_b48a8b6308e3fa6a = "emt_skirmish_timer_siege_objective_tick_01";
            self.var_756ce2ec4a637567 = 1990;
        }
        else if ( var_4a62b0f6788ba18e < 75 )
        {
            var_b48a8b6308e3fa6a = "emt_skirmish_timer_siege_objective_tick_02";
            self.var_756ce2ec4a637567 = 995;
        }
        else
        {
            var_b48a8b6308e3fa6a = "emt_skirmish_timer_siege_objective_tick_03";
        }
        
        capturingplayers = gameobjects::function_2c38b77b2ae4bfc5( team );
        
        foreach ( capturingplayer in capturingplayers )
        {
            capturingplayer playsoundtoplayer( var_b48a8b6308e3fa6a, capturingplayer );
        }
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0x23fd893, Offset: 0x1007
// Size: 0x12f
function private dom_delete( domflag )
{
    if ( isdefined( domflag.flagmodel ) )
    {
        domflag.flagmodel delete();
    }
    
    if ( isdefined( domflag.scriptable ) )
    {
        domflag.scriptable delete();
    }
    
    if ( domflag game_utility::questcircle_exists() )
    {
        domflag game_utility::questcircle_delete();
    }
    
    entnum = domflag.trigger getentitynumber();
    domflag.trigger.gameobject = undefined;
    domflag gameobjects::releaseid();
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.touchtriggers ) )
        {
            player.touchtriggers[ entnum ] = undefined;
        }
    }
    
    domflag notify( #"deleted" );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 3, eflags: 0x4
// Checksum 0xf4f3d712, Offset: 0x113e
// Size: 0x318
function private dom_onenduse( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    function_e3fcb3861310bb48();
    
    if ( success )
    {
        contributingplayers = [];
        entnum = self.trigger getentitynumber();
        
        foreach ( gameplayer in level.players )
        {
            if ( gameplayer.touchtriggers && gameplayer.touchtriggers[ entnum ] && gameplayer.team == team && player::isreallyalive( gameplayer ) )
            {
                if ( !isdefined( contributingplayers ) )
                {
                    contributingplayers = [];
                }
                
                contributingplayers[ contributingplayers.size ] = gameplayer;
            }
        }
        
        if ( player.owner )
        {
            if ( gameobjects::function_e17a356e69f57699( player ) && !arraycontains( contributingplayers, player.owner ) )
            {
                player callback::callback( #"hash_a4b2d4dcbb4cda95", { #capturebot:player } );
            }
            
            player = player.owner;
        }
        
        thread set_chevron_state( player.team );
        var_86dff0e4653c8432 = skirmish_util::function_afc407a06438534e( self );
        var_f36ee1d2e1c17dba = level.var_a0c7e4f01440403c * ( var_86dff0e4653c8432 ? 2 : 1 );
        player playsoundtoplayer( "uin_t10_skirmish_dom_objective_complete", player );
        skirmish_util::function_f0219df3de59b8fc( #"hash_43bf44d1ab6b56b4", self.trigger.origin, level.var_fd5a14340d3320e9, team );
        scoreeventmsg = var_86dff0e4653c8432 ? #"hash_5867902631831a27" : #"hash_52cfaf427a7b477b";
        skirmish_util::function_9bc92b9d0f473f97( var_f36ee1d2e1c17dba, scoreeventmsg, player );
        skirmish_util::function_55c12155a11106a0( player );
        finished_players = gameobjects::function_2c38b77b2ae4bfc5( team );
        
        foreach ( finished_player in finished_players )
        {
            finished_player skirmish_util::function_362ad591e19a35be();
            
            if ( finished_player == player )
            {
                continue;
            }
            
            finished_player points::doscoreevent( scoreeventmsg );
            skirmish_util::function_55c12155a11106a0( finished_player );
        }
        
        skirmish_activity_manager::finishactivity( self.activitytype, self.activityname, team, contributingplayers );
        skirmish_util::function_3059ce0968f29709( "dom_", player, team );
        thread set_chevron_state( "off" );
        self.domended = 1;
        dom_delete( self );
        return;
    }
    
    update_chevrons();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0x6fb30ad6, Offset: 0x145e
// Size: 0x33
function private function_759196e1bdad8cfc( clearedteam )
{
    cleared_players = gameobjects::function_2c38b77b2ae4bfc5( clearedteam );
    skirmish_util::function_7691fe63b803b07e( cleared_players, clearedteam, #"hash_2b65e76b30f4f6e2" );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0x96233ce5, Offset: 0x1499
// Size: 0xdb
function private dom_oncontested()
{
    if ( game_utility::getgametype() != "skirmishbt" )
    {
        self.contestedtime = gettime();
        
        if ( skirmish_util::function_afc407a06438534e( self ) )
        {
            gameobjects::setobjectivestatusicons( "waypoint_contested_hot" );
        }
        else
        {
            gameobjects::setobjectivestatusicons( level.iconcontested );
        }
        
        objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
        thread obj_dom::oncontested_playsoundatpos( self.trigger.origin, "jup_shared_zone_contested", 3 );
        thread obj_dom::updateflagstate( "contested", 0 );
        ownerteam = gameobjects::getownerteam();
        
        if ( ownerteam == "neutral" )
        {
        }
        
        objidpoolmanager::function_84651f3f2873ee19( self.objidnum, "neutral" );
        obj_dom::function_c18eb83275e643e7( self );
    }
    else
    {
        obj_dom::dompoint_oncontested();
    }
    
    update_chevrons();
    function_f7c8b4e761654439();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0xa4121cbb, Offset: 0x157c
// Size: 0x30
function private dom_onuncontested( lastclaimteam )
{
    obj_dom::dompoint_onuncontested( lastclaimteam );
    self.var_3827ad2f44d8da54 = undefined;
    utility::delaythread( 0.05, &update_chevrons );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0xc6a36853, Offset: 0x15b4
// Size: 0x10
function private dom_onunoccupied()
{
    obj_dom::dompoint_onunoccupied();
    update_chevrons();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0x37c90d0e, Offset: 0x15cc
// Size: 0x1c
function private dom_onpinnedstate( player )
{
    obj_dom::dompoint_onpinnedstate( player );
    update_chevrons();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0xd07aaa2e, Offset: 0x15f0
// Size: 0x6d
function private dom_onunpinnedstate( player )
{
    obj_dom::dompoint_onunpinnedstate( player );
    
    if ( self.domended )
    {
        return;
    }
    
    waitframe();
    numothertouching = gameobjects::getnumtouchingexceptteam( "none" );
    
    if ( numothertouching > 1 )
    {
        if ( isdefined( self.var_3827ad2f44d8da54 ) )
        {
            gameobjects::setclaimteam( self.var_3827ad2f44d8da54 );
        }
        
        dom_oncontested();
    }
    
    update_chevrons();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0x86005a9f, Offset: 0x1665
// Size: 0x8f
function private function_f34a963a85701530( team )
{
    numtouching = gameobjects::getnumtouchingforteam( self.claimteam );
    numother = gameobjects::getnumtouchingexceptteam( self.claimteam );
    scale = min( numtouching - numother, 6 );
    var_1b63f3281d4344c0 = 1 + ( scale - 1 ) * 0.4;
    self.userate = dvars::dvarfloatvalue( "clearUseRate", 3, 0, 15 ) * var_1b63f3281d4344c0;
    function_e3fcb3861310bb48();
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0x1b80fd50, Offset: 0x16fc
// Size: 0x1b
function private function_5f56df64c4f83074()
{
    objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2, eflags: 0x4
// Checksum 0xec300f47, Offset: 0x171f
// Size: 0x70
function private function_420eaefd3e54cba9( ownerteam, lastclaimteam )
{
    if ( ownerteam != "neutral" && self.ownerteam == ownerteam )
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        return;
    }
    
    if ( lastclaimteam != "none" )
    {
        gameobjects::setobjectivestatusicons( level.iconlosing, level.icontaking );
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0xebfccf1a, Offset: 0x1797
// Size: 0x9c
function private update_chevrons()
{
    if ( isdefined( self.ownerteam ) && self.ownerteam != "neutral" )
    {
        thread set_chevron_state( self.ownerteam );
    }
    else if ( self.isunoccupied )
    {
        thread set_chevron_state( "idle" );
    }
    
    if ( !level.gametypebundle.var_f2e17118451564d8 )
    {
        if ( self.stalemate )
        {
            thread set_chevron_state( "contested" );
            return;
        }
        
        if ( !self.isunoccupied )
        {
            thread set_chevron_state( self.mostnumtouchingteam );
        }
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0xc
// Checksum 0xac0f24e2, Offset: 0x183b
// Size: 0x117
function private set_chevron_state( state )
{
    self notify( #"hash_6ff05ee004e5466d" );
    self endon( #"hash_6ff05ee004e5466d" );
    level endon( #"game_ended" );
    
    if ( state == "none" )
    {
        return;
    }
    
    while ( !isdefined( self.chevrons ) )
    {
        waitframe();
    }
    
    var_1a5d8528edba5ab0 = "chevron_";
    
    foreach ( chevron in self.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( var_1a5d8528edba5ab0 + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2, eflags: 0x4
// Checksum 0xe593e708, Offset: 0x195a
// Size: 0x42
function private function_b555f7427386495e( numclaimants, numother )
{
    scale = min( numclaimants - numother, 6 );
    self.userate = 1 + ( scale - 1 ) * 0.4;
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2
// Checksum 0xe1f65a99, Offset: 0x19a4
// Size: 0x15
function function_142303de94f5115e( dom, player )
{
    
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2
// Checksum 0x27245dab, Offset: 0x19c1
// Size: 0x15
function function_370bffd438e5e93f( dom, player )
{
    
}

// Namespace namespace_7ea6f131e1a9874d
// Params 2
// Checksum 0x7dc70d64, Offset: 0x19de
// Size: 0x15
function function_e74f0a1cc4269070( dom, player )
{
    
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0x44782b2f, Offset: 0x19fb
// Size: 0x12
function private function_f459d7a9e70e203a()
{
    skirmish_util::function_27e85aa699653fa1( level.iconneutral );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 1, eflags: 0x4
// Checksum 0xf5e0bcb3, Offset: 0x1a15
// Size: 0x8a
function private function_7e78e646ec0be0a7( player )
{
    otherteam = team_utility::getotherteam( player.team );
    
    if ( self.teamprogress[ player.team ] <= 0 && self.teamprogress[ otherteam ] > 0 )
    {
        skirmish_util::function_27e85aa699653fa1( level.iconlosing, level.iconclearing );
        return;
    }
    
    skirmish_util::function_27e85aa699653fa1( level.iconlosing, level.icontaking );
}

// Namespace namespace_7ea6f131e1a9874d
// Params 0, eflags: 0x4
// Checksum 0xcddaab92, Offset: 0x1aa7
// Size: 0x1b
function private function_9e5bffa15724167d()
{
    skirmish_util::function_27e85aa699653fa1( level.iconlosing, level.icontaking );
}

