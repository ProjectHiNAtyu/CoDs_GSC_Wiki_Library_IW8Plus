// script_6c9403ef6e857f6e  (hash_6c9403ef6e857f6e.gscc) (size: 24247 Bytes / 0x5eb7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88447f68 (2286190440)
// size ...... 24247 (0x5eb7)
// includes .. 21  (offset: 0x5a07)
// strings ... 64  (offset: 0x5aaf)
// dev strs .. 1   (offset: 0x5eab)
// exports ... 46  (offset: 0x3fb7)
// cseg ...... 0x5b0 + 0x3a07 (0x3fb7)
// imports ... 154 (offset: 0x46e7)
// animtree1 . 0   (offset: 0x5eb7)
// animtree2 . 0   (offset: 0x5eb7)
#using script_16ea1b94f0f381b3;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\emp_debuff;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace namespace_a69d9116df130921;

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x807da98, Offset: 0x5ce
// Size: 0x1b6
function brtask_getspawndata( data )
{
    level.holdprop = spawnstruct();
    level.holdprop.circleradius = getdvarint( @"scr_br_hold_circle_radius", 138 );
    level.holdprop.capturetime = getdvarfloat( @"hash_70cb1dcb1d1ac8fe", 30 );
    level.holdprop.var_d35b899be8c8b4ff = getdvarint( @"hash_cae441d87fa6374d", 0 );
    level.holdprop.var_7759627950a4cf2a = getdvarint( @"hash_d1ddb41c6c8a3af0", 4 );
    level.holdprop.var_a0ac18e67e2d97f8 = getdvarint( @"hash_ef416ac86fbcd18e", 6 );
    level.holdprop.var_66b1eab99623f8e1 = getdvarfloat( @"hash_9efddff4d4e1dc53", 0.2 );
    level.holdprop.var_2df3c2e62a93dedf = getdvarint( @"hash_631c94c8c496ec51", 5 );
    level.holdprop.var_67b9290af5995972 = getdvarfloat( @"hash_9d45aadc299781b0", 0.5 );
    level.holdprop.var_cb8c31e2461d13e7 = getdvarfloat( @"hash_cecd445a628e208d", 0 );
    level.holdprop.canemp = getdvarint( @"hash_c81ebcee034129b5", 0 );
    data.createfunc = &function_7ee3cf3d5842483d;
    
    if ( !isdefined( level._effect[ "bomb_squad_explosion" ] ) )
    {
        level._effect[ "bomb_squad_explosion" ] = loadfxasset( "vfx_iw8_mp_gamemode_search_bombsite_destroy" );
    }
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0x6dde887e, Offset: 0x78c
// Size: 0x203
function function_7ee3cf3d5842483d( activity, owner )
{
    task = dmz_task_utils::task_create( activity );
    task.owner = owner;
    owner.task = task;
    task.players = [];
    task.funcs[ "onInit" ] = &function_5c80bcd732a8b426;
    task.funcs[ "onPlayerAssigned" ] = &brtask_onplayerassigned;
    task.funcs[ "onPlayerJoined" ] = &function_a7abfcfe746c1544;
    task.funcs[ "onPlayerRemoved" ] = &function_4c802cd0e12e5637;
    task.funcs[ "onTeamStart" ] = &function_8ee11e0f40af17bf;
    task.funcs[ "onPlayerExitVolume" ] = &function_74c09c22e2417ad3;
    task.funcs[ "onPlayerExitTimeout" ] = &brtask_onplayerexittimeout;
    task.funcs[ "onPlayerReenterVolume" ] = &function_1ca0f2e1396358cc;
    task.ref = "br_hold";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.spawntrap = 0;
    task.tier = task.owner br_strongholds::function_999adf66330f4aa8();
    
    if ( task.tier == "black" )
    {
        task.mission_index = 49;
        task.mission_complete = 50;
        task.mission_fail = 0;
        task.mission_fail_warning = 0;
        task.mission_contested = 65;
    }
    else
    {
        task.mission_index = 49;
        task.mission_complete = 50;
        task.mission_fail = 0;
        task.mission_fail_warning = 0;
        task.mission_contested = 65;
    }
    
    return task;
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x5237a6f5, Offset: 0x998
// Size: 0xe5
function function_5c80bcd732a8b426()
{
    task = self;
    task.activity.origin = task.owner.origin;
    task.circleradius = level.holdprop.circleradius;
    level.iconneutral = "hold_icon_captureneutral_br";
    level.iconcapture = "hold_icon_capture_br";
    level.var_4ee2901ae300150d = "hold_icon_capture_enemy_br";
    level.icondefend = "hold_icon_defend_br";
    level.icondefending = "hold_icon_defending_br";
    level.iconcontested = "hold_icon_contested_br";
    level.icontaking = "hold_icon_taking_br";
    level.var_43e10515d4dd41d5 = "hold_icon_taking_enemy_br";
    level.iconlosing = "hold_icon_losing_br";
    level.iconovertime = "hold_icon_ot_br";
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0xde5b1942, Offset: 0xa85
// Size: 0x2ef
function function_72fb6ebcc0783fe7()
{
    task = self;
    trigger = undefined;
    
    if ( !task.owner.var_dc130884eab4ddf4 )
    {
        trigger = spawn( "trigger_radius", task.owner.loadout[ 0 ].origin, 0, level.holdprop.circleradius, 62 );
    }
    else
    {
        trigger = task.owner.secondarytrigger;
    }
    
    task.holdpoint = task brtask_setupobjective( trigger, "neutral", 0, 1, 0 );
    task.holdpoint.onuse = &function_3dd2ddb2535268ef;
    task.holdpoint.onbeginuse = &function_ffa7ffba67bc72f0;
    task.holdpoint.onenduse = &function_6f2b5734a6ffb0bc;
    task.holdpoint.id = "domFlag";
    task.holdpoint.ignorestomp = 0;
    task.holdpoint gameobjects::requestid( 0, 1, undefined, 0, 0 );
    task.holdpoint.visibilitymanuallycontrolled = 1;
    task.holdpoint.stronghold = task.owner;
    task.holdpoint.task = task;
    task.circlecenter = task.holdpoint.origin;
    objective_removeallfrommask( task.holdpoint.objidnum );
    objective_showtoplayersinmask( task.holdpoint.objidnum );
    
    if ( level.holdprop.canemp )
    {
        task.holdpoint.trigger emp_debuff::set_apply_emp_callback( &function_8485997ecaaf6cd1 );
        task.holdpoint.trigger.var_5b3dbacfeda0fd01 = &function_8485997ecaaf6cd1;
        task.holdpoint.trigger.stronghold = task.owner;
    }
    
    if ( task.owner.var_dc130884eab4ddf4 )
    {
        task.holdpoint.var_ca860f253bb33069 = [];
        task.holdpoint.var_ca860f253bb33069[ task.holdpoint.var_ca860f253bb33069.size ] = task.owner.capturedteam;
    }
    
    task function_6f1a25adbed96e8a();
}

// Namespace namespace_a69d9116df130921
// Params 5
// Checksum 0xcb0a537a, Offset: 0xd7c
// Size: 0x3e8
function brtask_setupobjective( trigger, team, var_ee9ac91f30ff8e1, skipobjid, showoncompass )
{
    task = self;
    function_9cb236439ce93630();
    trigger utility::function_8a74027bdea84771( &function_f383d0ba695c7023 );
    trigger.task = task;
    visuals[ 0 ] = spawn( "script_model", trigger.origin );
    visuals[ 0 ] setmodel( "tag_origin" );
    visuals[ 0 ].angles = task.owner.loadout[ 0 ].angles;
    
    if ( !isdefined( level.var_e56cac0580f1c92c ) )
    {
        level.var_e56cac0580f1c92c = level.holdprop.capturetime * 0.5;
    }
    
    reservedobjid = undefined;
    team = "neutral";
    domflag = gameobjects::createuseobject( team, trigger, visuals, ( 0, 0, 62 ), reservedobjid, skipobjid, showoncompass );
    domflag gameobjects::allowuse( "any" );
    domflag gameobjects::cancontestclaim( 1 );
    domflag gameobjects::setusetime( level.holdprop.capturetime );
    domflag gameobjects::pinobjiconontriggertouch();
    
    if ( isdefined( level.capturetype ) )
    {
        domflag gameobjects::setcapturebehavior( obj_dom::getcapturetype() );
    }
    
    domflag.onuse = &function_3dd2ddb2535268ef;
    domflag.onbeginuse = &function_ffa7ffba67bc72f0;
    domflag.onenduse = &function_6f2b5734a6ffb0bc;
    domflag.onuncontested = &function_14fa649d0e26086c;
    domflag.oncontested = &function_22e592a574c054e5;
    domflag.onuseupdate = &obj_dom::dompoint_onuseupdate;
    domflag.onpinnedstate = &obj_dom::dompoint_onpinnedstate;
    domflag.onunpinnedstate = &obj_dom::dompoint_onunpinnedstate;
    domflag.nousebar = 1;
    domflag.id = "domFlag";
    domflag.claimgracetime = level.holdprop.capturetime * 1000;
    domflag.firstcapture = 1;
    domflag.var_2809cba8dafcf8cf = 0;
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
    
    domflag.baseeffectpos = trigger.origin;
    
    if ( getdvarint( @"hash_ac14d98c253c4715", 1 ) == 1 )
    {
        if ( !task.owner.var_dc130884eab4ddf4 )
        {
            var_1213eb89af5eb = trigger.origin;
            vfxscriptable = spawn( "script_model", var_1213eb89af5eb );
            vfxscriptable setmodel( "stronghold_control_point" );
            vfxscriptable.angles = task.owner.loadout[ 0 ].angles;
            vfxscriptable setscriptablepartstate( "flag", "idle" );
            domflag.vfxnamemod = vfxscriptable;
            vfxscriptable.domflag = domflag;
        }
    }
    
    domflag.noscriptable = 1;
    domflag obj_dom::initializematchrecording();
    
    if ( !skipobjid )
    {
        domflag obj_dom::domflag_setneutral();
    }
    
    return domflag;
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0xfb72bef1, Offset: 0x116d
// Size: 0x55, Type: bool
function function_f383d0ba695c7023()
{
    trigger = self;
    
    if ( isdefined( trigger.task ) )
    {
        trigger.task thread function_57d132b1ab7fb139( undefined, 1, undefined, istrue( trigger.task.holdpoint.var_4107a3e26829739 ) );
    }
    
    return false;
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x4b15163c, Offset: 0x11cb
// Size: 0x154
function function_14fa649d0e26086c( lastclaimteam )
{
    if ( level.flagneutralization && !self.firstcapture )
    {
        gameobjects::setusetime( level.flagcapturetime * 0.5 );
    }
    
    self.contestedtime = undefined;
    self.didstatusnotify = 0;
    ownerteam = gameobjects::getownerteam();
    flagstate = ownerteam == "neutral" ? "idle" : ownerteam;
    thread obj_dom::updateflagstate( flagstate, 0 );
    self.task function_bdb35b1e4427275d();
    
    foreach ( player in self.task.players )
    {
        if ( player getclientomnvar( "ui_br_stronghold_mission" ) == self.task.mission_contested )
        {
            player setclientomnvar( "ui_br_stronghold_mission", self.task.mission_index );
        }
    }
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x554b5422, Offset: 0x1327
// Size: 0xde
function function_9cb236439ce93630()
{
    _setdomencountericoninfo( "hold_icon_captureneutral_br", "neutral", "hud_icon_objective_defend_point_neutral" );
    _setdomencountericoninfo( "hold_icon_defend_br", "friendly", "hud_icon_objective_defend_point_friendly" );
    _setdomencountericoninfo( "hold_icon_defending_br", "friendly", "hud_icon_objective_defend_point_friendly" );
    _setdomencountericoninfo( "hold_icon_contested_br", "contest", "hud_icon_objective_defend_point_contest" );
    _setdomencountericoninfo( "hold_icon_losing_br", "enemy", "hud_icon_objective_defend_point_enemy" );
    _setdomencountericoninfo( "hold_icon_ot_br", "friendly", "hud_icon_objective_defend_point_friendly" );
    _setdomencountericoninfo( "hold_icon_taking_br", "friendly", "hud_icon_objective_defend_point_friendly" );
    _setdomencountericoninfo( "hold_icon_taking_enemy_br", "enemy", "hud_icon_objective_defend_point_enemy" );
    _setdomencountericoninfo( "hold_icon_capture_br", "friendly", "hud_icon_objective_defend_point_friendly" );
    _setdomencountericoninfo( "hold_icon_capture_enemy_br", "enemy", "hud_icon_objective_defend_point_enemy" );
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0x1ac6c2c2, Offset: 0x140d
// Size: 0x49
function _setdomencountericoninfo( name, colors, icon )
{
    level.waypointcolors[ name ] = colors;
    level.waypointbgtype[ name ] = 1;
    level.waypointshader[ name ] = icon;
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x38b5c4e7, Offset: 0x145e
// Size: 0xde
function function_22e592a574c054e5( lastclaimteam )
{
    obj_dom::dompoint_oncontested();
    
    foreach ( player in self.task.players )
    {
        if ( player getclientomnvar( "ui_br_stronghold_mission" ) != self.task.mission_contested )
        {
            player setclientomnvar( "ui_br_stronghold_mission", self.task.mission_contested );
        }
    }
    
    self.task function_bdb35b1e4427275d();
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x9661216c, Offset: 0x1544
// Size: 0xd6
function function_ffa7ffba67bc72f0( player )
{
    if ( isdefined( self.stronghold.capturedteam ) && isdefined( self.claimteam ) )
    {
        if ( self.claimteam == self.stronghold.capturedteam )
        {
            self.task brtask_holdsetvisible( 0 );
        }
        else
        {
            self.task notify( #"hash_c62814d2175a26b2" );
        }
    }
    
    player.iscapturing = 1;
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" && isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 1 );
    }
    
    self.didstatusnotify = 1;
    self.task function_bdb35b1e4427275d();
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0xb10a03e9, Offset: 0x1622
// Size: 0x346
function function_3dd2ddb2535268ef( player )
{
    holdpoint = self;
    isvalidplayer = isplayer( player ) && isalive( player );
    
    if ( isvalidplayer )
    {
        if ( level.var_4a5de2a2eae8e2b0 )
        {
            level thread br_contract_manager::utilflare_shootflare( holdpoint.stronghold.origin, "revive", 1 );
            dropstruct = pickups::function_f71dd588dc4f6288();
            
            if ( !isdefined( holdpoint.var_ca860f253bb33069 ) )
            {
                holdpoint.var_ca860f253bb33069 = [];
            }
            
            if ( !holdpoint.var_ce60d75c005d4ea6 && !arraycontains( holdpoint.var_ca860f253bb33069, player.team ) && !holdpoint.stronghold.var_dc130884eab4ddf4 )
            {
                if ( isdefined( holdpoint.stronghold.var_e14bde166cd9881b ) && holdpoint.stronghold.var_e14bde166cd9881b != player.team && !level.var_34a63a1622060e4c )
                {
                    player br_strongholds::function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ), player.team );
                    holdpoint.var_ca860f253bb33069[ holdpoint.var_ca860f253bb33069.size ] = player.team;
                }
                
                level thread br_contract_manager::utilflare_shootflare( holdpoint.stronghold.origin, "revive", 1 );
                dropstruct = pickups::function_f71dd588dc4f6288();
                
                if ( !holdpoint.var_ce60d75c005d4ea6 && !arraycontains( holdpoint.var_ca860f253bb33069, player.team ) )
                {
                    holdpoint.stronghold.var_e14bde166cd9881b = player.team;
                    player br_strongholds::function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ), player.team );
                    holdpoint.var_ca860f253bb33069[ holdpoint.var_ca860f253bb33069.size ] = player.team;
                }
            }
            
            holdpoint.task function_57d132b1ab7fb139( player.team, 0, 1, istrue( holdpoint.var_4107a3e26829739 ) );
            holdpoint.task.owner function_5b8c20d365420726( dropstruct, player );
            return;
        }
        
        level thread br_contract_manager::utilflare_shootflare( holdpoint.stronghold.origin, "revive", 1 );
        dropstruct = pickups::function_f71dd588dc4f6288();
        holdpoint.task.owner function_5b8c20d365420726( dropstruct, player );
        dmz_task_utils::function_59e5c04599d5a456( holdpoint.task, player );
        
        if ( !holdpoint.var_ce60d75c005d4ea6 )
        {
            player br_strongholds::function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ), player.team );
        }
        
        holdpoint.task function_57d132b1ab7fb139( player.team, undefined, undefined, istrue( holdpoint.var_4107a3e26829739 ) );
    }
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0xe1f19ea5, Offset: 0x1970
// Size: 0xa9
function function_6f2b5734a6ffb0bc( team, player, success )
{
    if ( isplayer( player ) )
    {
        player.iscapturing = 0;
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        player.ui_dom_securing = undefined;
    }
    
    self.task brtask_holdsetvisible( 0 );
    self.task function_bdb35b1e4427275d();
    self.didstatusnotify = 0;
    
    if ( team == "none" || player.team != team )
    {
        return;
    }
    
    thread obj_dom::updateflagstate( team, 0 );
    self.neutralized = 0;
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x2c6f702, Offset: 0x1a21
// Size: 0xb2
function function_c7fc1d339da24aa6( player )
{
    task = self;
    teamname = player.team;
    task notify( #"strongholdneutralize" );
    task endon( #"strongholdneutralize" );
    task endon( #"stronghold_recapture" );
    task endon( #"hash_c62814d2175a26b2" );
    delaytimes = getdvarint( @"hash_d95a688350cfedbc", 30 );
    
    if ( isdefined( delaytimes ) )
    {
        wait delaytimes;
    }
    
    teamparticipants = task activity_manager::function_1a4ef82bc898efb6( teamname, 1 );
    
    if ( teamparticipants.size > 0 )
    {
        return;
    }
    
    task function_a593f57b2023ccae( player, 0, "timeout" );
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0xd47c89f4, Offset: 0x1adc
// Size: 0x2f1
function function_a593f57b2023ccae( player, fromemp, neutralizereason )
{
    task = self;
    teamname = player.team;
    
    if ( isdefined( task.holdpoint.stronghold ) )
    {
        if ( fromemp || level.var_fb0bf51d93bd969c && task.holdpoint.stronghold.capturedteam == teamname )
        {
            task.owner notify( #"fortressNeutralized" );
        }
        
        ai_fortress::function_6afabfde369e039c( task.holdpoint.stronghold, 0 );
        
        if ( task.holdpoint.stronghold.proximitytrigger.playercount > 0 && !fromemp )
        {
            ai_fortress::function_6afabfde369e039c( task.holdpoint.stronghold, 1 );
        }
        
        player br_strongholds::function_f819e58b5bd0ab06( task.holdpoint.stronghold, neutralizereason, "neutralized" );
    }
    
    if ( isdefined( task.owner ) && isdefined( task.owner.crate ) && isdefined( task.owner.crate.players ) )
    {
        foreach ( matchplayer in task.owner.crate.players )
        {
            task.owner.crate br_strongholds::function_f4e1ae6ec70d2b0d( matchplayer );
        }
        
        task.owner.crate.players = [];
    }
    
    task.holdpoint obj_dom::domflag_setneutral();
    task.holdpoint gameobjects::resetcaptureprogress();
    objidpoolmanager::objective_set_progress_team( task.holdpoint.objidnum, "none" );
    objidpoolmanager::objective_set_progress( task.holdpoint.objidnum, 0 );
    objidpoolmanager::objective_show_progress( task.holdpoint.objidnum, 0 );
    task.holdpoint.stronghold.capturedteam = undefined;
    task function_bdb35b1e4427275d();
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x962bbbbb, Offset: 0x1dd5
// Size: 0x4c
function function_789ac2c396ce370a( enable )
{
    if ( enable )
    {
        gameobjects::allowuse( "any" );
        self.trigger utility::trigger_on();
        return;
    }
    
    gameobjects::allowuse( "none" );
    self.trigger utility::trigger_off();
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0xfe067540, Offset: 0x1e29
// Size: 0x72
function brtask_holdsetvisible( enable, preview, skipunpin )
{
    task = self;
    task.holdpoint notify( #"brtask_holdsetvisible" );
    
    if ( enable )
    {
        task function_bdb35b1e4427275d();
        return;
    }
    
    task.holdpoint function_b3d9532b1a329770( task.owner, preview, skipunpin );
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0x6bbf7739, Offset: 0x1ea3
// Size: 0x64
function function_b3d9532b1a329770( owner, preview, skipunpin )
{
    holdpoint = self;
    holdpoint endon( #"brtask_holdsetvisible" );
    
    if ( !skipunpin )
    {
        objective_setpinned( holdpoint.objidnum, 0 );
        wait 1;
    }
    
    holdpoint.task function_cf3bb728f05b458c();
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0xd2304ca6, Offset: 0x1f0f
// Size: 0xdb
function function_9bb10f37566ed258( owner )
{
    holdpoint = self;
    
    if ( !isdefined( owner.proximitytrigger ) )
    {
        return;
    }
    
    objective_removeallfrommask( holdpoint.objidnum );
    
    foreach ( ent in owner.proximitytrigger.touchents )
    {
        if ( isplayer( ent ) && player::isreallyalive( ent ) )
        {
            objective_addclienttomask( holdpoint.objidnum, ent );
        }
    }
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x414d18d5, Offset: 0x1ff2
// Size: 0x43
function function_cf3bb728f05b458c()
{
    task = self;
    objective_removeallfrommask( task.holdpoint.objidnum );
    objective_removeallfrommask( task.var_25cd0eecbaab64e8.objidnum );
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0xf2924562, Offset: 0x203d
// Size: 0x1f1
function brtask_onplayerassigned( teamname, player, var_4107a3e26829739 = 0 )
{
    task = self;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    task.owner br_strongholds::function_7d3778200a9a7f9e( player, player.team );
    
    if ( !player.var_b6e8a5ee165aff86 )
    {
        player.var_b6e8a5ee165aff86 = 1;
    }
    else
    {
        return;
    }
    
    if ( !var_4107a3e26829739 )
    {
        task thread activity_manager::function_e7c5a361b3642470( task.owner.missiontrigger, 0 );
    }
    
    if ( !isdefined( task.holdpoint ) )
    {
        task function_72fb6ebcc0783fe7();
        task.holdpoint.originalteam = player.team;
        
        if ( level.holdprop.var_d35b899be8c8b4ff )
        {
            task thread br_strongholds::function_964c99021a08b9ad( task.owner, "high", level.holdprop.var_7759627950a4cf2a );
            task thread function_6e578dd1e9066ab0();
        }
    }
    
    if ( isdefined( task.holdpoint ) && !task.holdpoint.tempdisabled )
    {
        if ( level.var_4a5de2a2eae8e2b0 )
        {
            if ( !isdefined( task.holdpoint.stronghold.capturedteam ) )
            {
                ai_fortress::function_6afabfde369e039c( task.owner, 1 );
            }
        }
        else
        {
            ai_fortress::function_6afabfde369e039c( task.owner, 1 );
        }
    }
    
    if ( var_7537e34d05ee8017 )
    {
        task function_a7abfcfe746c1544( player, var_4107a3e26829739 );
        return;
    }
    
    if ( !level.br_circle_disabled )
    {
        task thread function_b9415f2f47afea88( var_4107a3e26829739 );
    }
    
    task function_a7abfcfe746c1544( player, var_4107a3e26829739 );
    player.var_b6e8a5ee165aff86 = undefined;
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x1d4b6c88, Offset: 0x2236
// Size: 0x164
function function_6e578dd1e9066ab0()
{
    level endon( #"game_ended" );
    task = self;
    task endon( #"task_ended" );
    
    while ( isdefined( task.holdpoint ) && isdefined( task.holdpoint.usetime ) && task.holdpoint.usetime * level.holdprop.var_66b1eab99623f8e1 > task.holdpoint.curprogress )
    {
        wait 0.5;
    }
    
    thread br_strongholds::function_964c99021a08b9ad( task.owner, "high", level.holdprop.var_a0ac18e67e2d97f8 );
    
    while ( isdefined( task.holdpoint ) && isdefined( task.holdpoint.usetime ) && task.holdpoint.usetime * level.holdprop.var_67b9290af5995972 > task.holdpoint.curprogress )
    {
        wait 0.5;
    }
    
    thread br_strongholds::function_964c99021a08b9ad( task.owner, "high", level.holdprop.var_2df3c2e62a93dedf );
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0x2e912024, Offset: 0x23a2
// Size: 0x1f1
function function_a7abfcfe746c1544( player, var_4107a3e26829739 = 0 )
{
    task = self;
    
    if ( task.holdpoint.tempdisabled )
    {
        return;
    }
    
    if ( !isdefined( function_f02c63b99c9614c9( task.players, player ) ) )
    {
        size = task.players.size;
        task.players[ size ] = player;
    }
    
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( var_7537e34d05ee8017 )
    {
        return;
    }
    
    var_da759e0bfcdfca64 = player getclientomnvar( "ui_br_stronghold_mission" );
    
    if ( !isdefined( task.originalteam ) )
    {
        task.originalteam = player.team;
    }
    
    if ( !task.holdpoint.tempdisabled )
    {
        task.holdpoint function_789ac2c396ce370a( 1 );
    }
    
    task brtask_holdsetvisible( 1 );
    player.initialized_gameobject_vars = 1;
    
    if ( !isdefined( player.touchtriggers ) )
    {
        player.touchtriggers = [];
    }
    
    if ( !var_4107a3e26829739 && task.holdpoint.stronghold.capturedteam != player.team )
    {
        player thread hud_message::showsplash( "stronghold_operation_hold_the_line" );
        wait 4;
    }
    
    if ( !isdefined( player ) || !arraycontains( task.players, player ) )
    {
        return;
    }
    
    if ( !var_4107a3e26829739 && var_da759e0bfcdfca64 == player getclientomnvar( "ui_br_stronghold_mission" ) )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_index );
    }
    
    task dmz_task_utils::function_6277bd2a0d5a28b9( player );
    
    /#
        if ( level.holdprop.var_cb8c31e2461d13e7 )
        {
            task thread function_89b8d0ef57f84298();
        }
    #/
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0xa4871a52, Offset: 0x259b
// Size: 0xaf
function function_4c802cd0e12e5637( player, var_4107a3e26829739 = 0 )
{
    task = self;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_4107a3e26829739 )
    {
        task.players = arrayremove( task.players, player );
    }
    
    if ( var_7537e34d05ee8017 )
    {
        return;
    }
    
    if ( !var_4107a3e26829739 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_fail );
    }
    
    task.holdpoint function_6f2b5734a6ffb0bc( player.team, player, 0 );
    task notify( #"hash_54917783280f9ea8" );
}

/#

    // Namespace namespace_a69d9116df130921
    // Params 0
    // Checksum 0x4f73eb7d, Offset: 0x2652
    // Size: 0x9a, Type: dev
    function function_89b8d0ef57f84298()
    {
        task = self;
        level endon( #"game_ended" );
        task endon( #"hash_54917783280f9ea8" );
        color = ( 0.5, 1, 1 );
        
        while ( true )
        {
            utility::draw_circle( task.holdpoint.trigger.origin + ( 0, 0, 5 ), level.holdprop.circleradius, color, 1, 1, 1 );
            waitframe();
        }
    }

#/

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x8ffcbe8b, Offset: 0x26f4
// Size: 0x1b
function function_8ee11e0f40af17bf( teamname )
{
    assert( 1, "<dev string:x24>" );
}

// Namespace namespace_a69d9116df130921
// Params 5
// Checksum 0x6d838363, Offset: 0x2717
// Size: 0x1cf
function function_27b4eb7789dec42a( teamname, omnvarstate, detonated, teamcompleted, var_4107a3e26829739 = 0 )
{
    task = self;
    teamparticipants = task activity_manager::function_1a4ef82bc898efb6( teamname, 1 );
    
    if ( !var_4107a3e26829739 )
    {
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].activities = arrayremove( level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].activities, task.activity.id );
        task.teams = arrayremove( task.teams, teamname );
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].active = 0;
    }
    
    var_4d6e568a2d8903da = !var_4107a3e26829739;
    
    foreach ( player in teamparticipants )
    {
        if ( !var_4107a3e26829739 )
        {
            task.players = arrayremove( task.players, player );
            task.holdpoint function_6f2b5734a6ffb0bc( teamname, player, teamcompleted );
        }
        
        if ( game_utility_common::isaigameparticipant( player ) )
        {
            continue;
        }
        
        if ( !var_4107a3e26829739 || !detonated )
        {
            task function_e57f298ccaa4b88c( player, detonated, omnvarstate, var_4d6e568a2d8903da );
        }
    }
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x3b19389e, Offset: 0x28ee
// Size: 0x56
function function_74c09c22e2417ad3( player )
{
    task = self;
    player.var_5111d0ec51f4ab00 = 1;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_fail_warning );
    }
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x6470454f, Offset: 0x294c
// Size: 0x8e
function function_1ca0f2e1396358cc( player )
{
    task = self;
    player.var_5111d0ec51f4ab00 = undefined;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_index );
    }
    
    if ( player.team == task.holdpoint.stronghold.capturedteam )
    {
        task notify( #"stronghold_recapture" );
    }
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x52c8e3fa, Offset: 0x29e2
// Size: 0xb6
function brtask_onplayerexittimeout( player )
{
    task = self;
    task function_4c802cd0e12e5637( player );
    player.var_5111d0ec51f4ab00 = 1;
    
    if ( isdefined( level.var_18933116083e8076 ) )
    {
        task [[ level.var_18933116083e8076 ]]( player );
    }
    
    if ( level.var_fb0bf51d93bd969c && isdefined( task.holdpoint.stronghold.capturedteam ) && player.team == task.holdpoint.stronghold.capturedteam )
    {
        task thread function_c7fc1d339da24aa6( player );
    }
}

// Namespace namespace_a69d9116df130921
// Params 4, eflags: 0x4
// Checksum 0x3089e842, Offset: 0x2aa0
// Size: 0x9f
function private function_e57f298ccaa4b88c( player, detonated, omnvarstate, var_4d6e568a2d8903da )
{
    task = self;
    
    if ( var_4d6e568a2d8903da )
    {
        player setclientomnvar( "ui_br_stronghold_mission", omnvarstate );
    }
    
    if ( omnvarstate == task.mission_complete )
    {
        player thread hud_message::showsplash( "stronghold_operation_hold_the_line_completed" );
        return;
    }
    
    if ( detonated )
    {
        player thread hud_message::showsplash( "stronghold_operation_hold_the_line_failed" );
    }
    else
    {
        player thread hud_message::showsplash( "stronghold_operation_hold_the_line_failed" );
    }
    
    if ( var_4d6e568a2d8903da )
    {
        player setclientomnvar( "ui_br_stronghold_mission", 0 );
    }
}

// Namespace namespace_a69d9116df130921
// Params 4, eflags: 0x4
// Checksum 0x911c51fd, Offset: 0x2b47
// Size: 0x54b
function private function_57d132b1ab7fb139( teamname, detonated, loop, var_4107a3e26829739 = 0 )
{
    task = self;
    
    if ( isdefined( level.var_d07dd9893f7e474b ) && isdefined( teamname ) )
    {
        task.owner [[ level.var_d07dd9893f7e474b ]]( teamname, !detonated );
    }
    
    var_4d6e568a2d8903da = !var_4107a3e26829739;
    
    if ( loop )
    {
        if ( isdefined( task.holdpoint.stronghold.capturedteam ) )
        {
            foreach ( player in teams::getteamdata( task.holdpoint.stronghold.capturedteam, "players" ) )
            {
                player thread hud_message::showsplash( "stronghold_operation_hold_the_line_stolen" );
            }
        }
        
        foreach ( team in task.teams )
        {
            teamcompleted = 0;
            
            if ( isdefined( teamname ) && isdefined( team ) )
            {
                teamcompleted = team == teamname;
            }
            
            omnvarstate = task.mission_fail;
            
            if ( teamcompleted )
            {
                omnvarstate = task.mission_complete;
            }
            
            teamparticipants = task activity_manager::function_1a4ef82bc898efb6( team, 1 );
            
            foreach ( player in teamparticipants )
            {
                if ( isdefined( task.holdpoint.stronghold.capturedteam ) )
                {
                    if ( player.team == task.holdpoint.stronghold.capturedteam )
                    {
                        continue;
                    }
                }
                
                if ( game_utility_common::isaigameparticipant( player ) )
                {
                    continue;
                }
                
                task function_e57f298ccaa4b88c( player, detonated, omnvarstate, var_4d6e568a2d8903da );
            }
        }
        
        return;
    }
    
    if ( !var_4107a3e26829739 )
    {
        task notify( #"task_ended" );
        ai_fortress::function_5b84b41b9159ad3f( task.owner );
    }
    
    deletetask = 0;
    
    foreach ( team in task.teams )
    {
        teamcompleted = 0;
        
        if ( isdefined( teamname ) && isdefined( team ) )
        {
            teamcompleted = team == teamname;
        }
        
        omnvarstate = task.mission_fail;
        
        if ( teamcompleted )
        {
            deletetask = 1;
            omnvarstate = task.mission_complete;
        }
        
        task function_27b4eb7789dec42a( team, omnvarstate, detonated, teamcompleted, var_4107a3e26829739 );
    }
    
    if ( !var_4107a3e26829739 )
    {
        task.players = [];
        task.teams = [];
        task dmz_task_utils::function_e23cad864e9e2023();
        task dmz_task_utils::function_3ff46488beb193c7();
        task function_dd1e11ad9a82f3a1();
    }
    
    if ( detonated )
    {
        task.owner.crate thread br_strongholds::function_a5a4e51b72179cb6( undefined, 0, 1, 1, 0 );
    }
    
    if ( !isdefined( detonated ) )
    {
        detonated = 0;
    }
    
    if ( !var_4107a3e26829739 )
    {
        task.starttime = undefined;
        
        if ( isdefined( task.activity ) && isdefined( task.activity.tasks ) && task.activity.tasks.size >= 1 && ( deletetask || detonated ) )
        {
            task.owner.missiontrigger notify( #"activity_ended" );
            level.var_f9ba6d6273c5cc67.activities[ task.activity.id ] = undefined;
            task.activity.tasks = undefined;
            obj_dom::removeobjective( task.holdpoint );
        }
        
        return;
    }
    
    if ( detonated )
    {
        obj_dom::removeobjective( task.holdpoint );
        
        if ( isdefined( task.holdpoint.vfxnamemod ) )
        {
            task.holdpoint.vfxnamemod setscriptablepartstate( "flag", "off" );
        }
    }
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x344dfc44, Offset: 0x309a
// Size: 0x1ab
function function_b9415f2f47afea88( var_4107a3e26829739 )
{
    task = self;
    level endon( #"game_ended" );
    
    if ( !var_4107a3e26829739 )
    {
        task endon( #"task_ended" );
        task.owner.missiontrigger endon( #"deleted" );
        task.owner.missiontrigger endon( #"activity_ended" );
    }
    
    if ( task.owner.gaswatch )
    {
        return;
    }
    
    origin = task.owner.origin + ( 0, 0, 62 );
    task.owner.gaswatch = 1;
    waitframe();
    waittillframeend();
    
    while ( br_circle_util::ispointinmulticircledanger( origin ) || br_circle_util::function_3199bf5530fd0bc2( origin ) )
    {
        wait 0.25;
    }
    
    if ( !var_4107a3e26829739 )
    {
        foreach ( player in task.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
            
            if ( var_7537e34d05ee8017 )
            {
                continue;
            }
            
            task thread brtask_onplayerexittimeout( player );
        }
    }
    
    task thread function_57d132b1ab7fb139( undefined, 1, undefined, var_4107a3e26829739 );
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0x57ae6dd2, Offset: 0x324e
// Size: 0xba
function function_5b8c20d365420726( dropstruct, player )
{
    fortress = self;
    
    if ( fortress.isblacksite )
    {
        uavtype = "directional_uav";
    }
    else
    {
        uavtype = "uav";
    }
    
    player br_strongholds::function_f819e58b5bd0ab06( fortress, "captured", "captured" );
    
    if ( level.var_4a5de2a2eae8e2b0 && fortress.captured )
    {
        fortress br_strongholds::function_fb5fbbc2fcf4a080( player, undefined, uavtype, 1 );
        return;
    }
    
    fortress br_strongholds::function_fb5fbbc2fcf4a080( player, undefined, uavtype, 1 );
    
    if ( level.var_ab7f3fc074c4fa35 )
    {
        function_efa777b574b04a2a( dropstruct, player, fortress.crate );
    }
}

// Namespace namespace_a69d9116df130921
// Params 3
// Checksum 0xd4836228, Offset: 0x3310
// Size: 0x159
function function_efa777b574b04a2a( dropstruct, player, crate )
{
    var_bb21c60dec1d102f = getdvarint( @"hash_3174d9a2553a5fa7", 1 );
    var_e7e703931fbca4 = [ "brloot_super_munitionsbox", "brloot_super_armorbox" ];
    teammatecount = undefined;
    teammates = teams::getsquadmates( player.team, player.sessionsquadid, 0 );
    
    if ( isdefined( teammates ) )
    {
        teammatecount = teammates.size;
    }
    
    if ( var_bb21c60dec1d102f >= 0 )
    {
        for ( i = 0; i < var_bb21c60dec1d102f ; i++ )
        {
            function_fcfea8f3ffb92ac2( dropstruct, player, crate );
        }
    }
    else if ( isdefined( teammatecount ) )
    {
        for ( i = 0; i < teammatecount ; i++ )
        {
            extraloot = var_e7e703931fbca4[ i % var_e7e703931fbca4.size ];
            function_fcfea8f3ffb92ac2( dropstruct, player, crate, extraloot );
        }
    }
    else
    {
        function_fcfea8f3ffb92ac2( dropstruct, player, crate );
    }
    
    if ( getdvarint( @"scr_emptypalfa_enable", 1 ) != 1 )
    {
        return;
    }
    
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( player.origin, player.angles );
    spawned = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_gascan_palfa", undefined, spawnoptions );
}

// Namespace namespace_a69d9116df130921
// Params 4
// Checksum 0x70a379fa, Offset: 0x3471
// Size: 0x114
function function_fcfea8f3ffb92ac2( dropstruct, player, crate, extraloot )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "bomb_defuse_reward" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        if ( isdefined( crate ) && getdvarint( @"hash_13c3754911cca521", 1 ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( crate.origin, crate.angles );
            common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
            return;
        }
        
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.var_185d29f84c8dc710, spawnoptions );
        
        if ( isdefined( extraloot ) )
        {
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( player.origin, player.angles );
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( extraloot, undefined, spawnoptions );
        }
    }
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x1356a280, Offset: 0x358d
// Size: 0x16a
function function_6f1a25adbed96e8a()
{
    task = self;
    task.var_25cd0eecbaab64e8 = spawnstruct();
    task.var_25cd0eecbaab64e8.curorigin = task.holdpoint.curorigin;
    task.var_25cd0eecbaab64e8.offset3d = task.holdpoint.offset3d;
    task.var_25cd0eecbaab64e8 gameobjects::requestid( 0, 1, undefined, 0, 0 );
    icon = gameobjects::getwaypointshader( level.var_4ee2901ae300150d );
    objidpoolmanager::update_objective_icon( task.var_25cd0eecbaab64e8.objidnum, icon );
    backgroundtype = gameobjects::getwaypointbackgroundtype( level.var_4ee2901ae300150d );
    objidpoolmanager::update_objective_setbackground( task.var_25cd0eecbaab64e8.objidnum, backgroundtype );
    objective_setshowprogress( task.var_25cd0eecbaab64e8.objidnum, 1 );
    objective_removeallfrommask( task.var_25cd0eecbaab64e8.objidnum );
    objective_showtoplayersinmask( task.var_25cd0eecbaab64e8.objidnum );
    task thread function_2ab73bd584775d4b( task.holdpoint, task.var_25cd0eecbaab64e8 );
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x4d135d7f, Offset: 0x36ff
// Size: 0x52
function function_dd1e11ad9a82f3a1()
{
    task = self;
    
    if ( isdefined( task.var_25cd0eecbaab64e8 ) )
    {
        objidpoolmanager::returnobjectiveid( task.var_25cd0eecbaab64e8.objidnum );
        task.var_25cd0eecbaab64e8.objidnum = -1;
    }
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0x1f34b52f, Offset: 0x3759
// Size: 0xa0
function function_2ab73bd584775d4b( holdpoint, enemyobjective )
{
    task = self;
    level endon( #"game_ended" );
    task endon( #"task_ended" );
    
    while ( isdefined( enemyobjective.objidnum ) && enemyobjective.objidnum != -1 )
    {
        uiprogress = min( holdpoint.curprogress / holdpoint.usetime, 1 );
        objidpoolmanager::objective_set_progress( enemyobjective.objidnum, uiprogress );
        wait 0.2;
    }
}

// Namespace namespace_a69d9116df130921
// Params 0
// Checksum 0x27224208, Offset: 0x3801
// Size: 0x3ce
function function_bdb35b1e4427275d()
{
    task = self;
    holdpoint = task.holdpoint;
    var_25cd0eecbaab64e8 = task.var_25cd0eecbaab64e8;
    claimteam = holdpoint.claimteam;
    contested = isdefined( holdpoint.contestedtime );
    neutral = !isdefined( claimteam ) || claimteam == "none";
    alreadycaptured = holdpoint.claimteam == holdpoint.stronghold.capturedteam;
    
    if ( contested )
    {
        holdpoint gameobjects::setobjectivestatusicons( level.iconcontested );
        objidpoolmanager::update_objective_icon( holdpoint.stronghold.objectiveiconid, holdpoint.stronghold.var_bfe798e040aa00e3 );
    }
    else if ( neutral )
    {
        holdpoint gameobjects::setobjectivestatusicons( level.iconneutral );
        ai_fortress::function_6afabfde369e039c( holdpoint.stronghold, 1 );
    }
    else
    {
        holdpoint gameobjects::setobjectivestatusicons( level.icontaking );
        objidpoolmanager::function_84651f3f2873ee19( holdpoint.objidnum, claimteam );
        objidpoolmanager::objective_set_progress_team( holdpoint.objidnum, claimteam );
        objidpoolmanager::function_84651f3f2873ee19( var_25cd0eecbaab64e8.objidnum, claimteam );
        objidpoolmanager::objective_set_progress_team( var_25cd0eecbaab64e8.objidnum, claimteam );
        ai_fortress::function_6afabfde369e039c( holdpoint.stronghold, 1 );
    }
    
    holdpoint gameobjects::setvisibleteam( "any" );
    holdpoint gameobjects::setownerteam( "neutral" );
    
    if ( isdefined( holdpoint.objidnum ) )
    {
        objective_removeallfrommask( holdpoint.objidnum );
    }
    
    if ( isdefined( var_25cd0eecbaab64e8.objidnum ) )
    {
        objective_removeallfrommask( var_25cd0eecbaab64e8.objidnum );
    }
    
    foreach ( player in task.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !alreadycaptured )
        {
            if ( contested || neutral || player.team == claimteam )
            {
                objective_addclienttomask( holdpoint.objidnum, player );
            }
        }
        else if ( !contested && !neutral && player.team != claimteam )
        {
            objective_addclienttomask( var_25cd0eecbaab64e8.objidnum, player );
        }
        
        var_3e213c81b2e0a57d = undefined;
        
        if ( isdefined( holdpoint.vfxnamemod ) )
        {
            if ( neutral )
            {
                var_3e213c81b2e0a57d = 0;
                holdpoint.vfxnamemod setscriptablepartstate( "flag", "idle" );
            }
            else if ( contested )
            {
                var_3e213c81b2e0a57d = 3;
                holdpoint.vfxnamemod setscriptablepartstate( "flag", "contested" );
            }
            else if ( player.team == claimteam )
            {
                var_3e213c81b2e0a57d = 1;
                holdpoint.vfxnamemod setscriptablepartstate( "flag", "blue_red" );
            }
            else
            {
                var_3e213c81b2e0a57d = 2;
                holdpoint.vfxnamemod setscriptablepartstate( "flag", "blue_red" );
            }
        }
        else if ( neutral )
        {
            var_3e213c81b2e0a57d = 0;
        }
        else if ( contested )
        {
            var_3e213c81b2e0a57d = 3;
        }
        else if ( player.team == claimteam )
        {
            var_3e213c81b2e0a57d = 1;
        }
        else
        {
            var_3e213c81b2e0a57d = 2;
        }
        
        player setclientomnvar( "ui_br_stronghold_mission_status", var_3e213c81b2e0a57d );
    }
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x38a30fc8, Offset: 0x3bd7
// Size: 0x51
function function_8485997ecaaf6cd1( data )
{
    task = self.task;
    task function_a593f57b2023ccae( data.attacker, 1, "EMP_" + data.reason );
    thread brtask_holddisablefortime( data );
}

// Namespace namespace_a69d9116df130921
// Params 1
// Checksum 0x35b2eccf, Offset: 0x3c30
// Size: 0x268
function brtask_holddisablefortime( data )
{
    self notify( #"brtask_holddisablefortime" );
    self endon( #"brtask_holddisablefortime" );
    self.task.holdpoint function_789ac2c396ce370a( 0 );
    self.task.holdpoint.tempdisabled = 1;
    ai_fortress::function_6afabfde369e039c( self.task.owner, 0 );
    self.task.players = [];
    
    if ( !isdefined( self.temptrigger ) )
    {
        self.temptrigger = spawn( "trigger_radius", self.origin, 0, level.holdprop.circleradius, 62 );
        trigger::makeenterexittrigger( self.temptrigger, &function_71d1dabc3adaa30c, &playerexitholdpointdisabled );
        self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
    }
    else if ( isdefined( self.temptrigger.triggerenterents ) )
    {
        self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
        
        foreach ( player in self.temptrigger.triggerenterents )
        {
            player lower_message::setlowermessageomnvar( "uav_offline", self.temptrigger.endtime );
        }
    }
    
    wait data.time;
    self.task.holdpoint function_789ac2c396ce370a( 1 );
    self.task.holdpoint.tempdisabled = undefined;
    ai_fortress::function_6afabfde369e039c( self.task.owner, 1 );
    self.temptrigger delete();
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0x534f7426, Offset: 0x3ea0
// Size: 0x91
function function_71d1dabc3adaa30c( player, trigger )
{
    self endon( #"playerexitholdpointdisabled" );
    lower_message::setlowermessageomnvar( "uav_offline", trigger.endtime );
    timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() );
    
    while ( isdefined( trigger ) && timeleft > 0 )
    {
        timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() );
        wait timeleft;
    }
    
    waitframe();
    thread playerexitholdpointdisabled( player, trigger );
}

// Namespace namespace_a69d9116df130921
// Params 2
// Checksum 0xfaf76e56, Offset: 0x3f39
// Size: 0x2d
function playerexitholdpointdisabled( player, trigger )
{
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self notify( #"playerexitholdpointdisabled" );
}

/#

    // Namespace namespace_a69d9116df130921
    // Params 1
    // Checksum 0x10b7064e, Offset: 0x3f6e
    // Size: 0x49, Type: dev
    function function_f188fefbf96f3998( delaytimes )
    {
        task = self;
        
        if ( isdefined( delaytimes ) )
        {
            wait delaytimes;
        }
        
        task function_57d132b1ab7fb139( undefined, 1, undefined, istrue( task.holdpoint.var_4107a3e26829739 ) );
        return;
    }

#/
