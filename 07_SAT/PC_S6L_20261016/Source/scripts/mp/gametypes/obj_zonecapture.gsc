// scripts\mp\gametypes\obj_zonecapture.gsc  (hash_1b18a05a284d55c2.gscc) (size: 26697 Bytes / 0x6849 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe73d2140 (3879543104)
// size ...... 26697 (0x6849)
// includes .. 23  (offset: 0x62f5)
// strings ... 69  (offset: 0x63ad)
// dev strs .. 7   (offset: 0x67f5)
// exports ... 50  (offset: 0x47e5)
// cseg ...... 0x44e + 0x4397 (0x47e5)
// imports ... 142 (offset: 0x4fb5)
// animtree1 . 0   (offset: 0x6849)
// animtree2 . 0   (offset: 0x6849)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\hq;
#using scripts\mp\gametypes\koth;
#using scripts\mp\hostmigration;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnutils;

#namespace obj_zonecapture;

// Namespace obj_zonecapture
// Params 5
// Checksum 0xa7de0e31, Offset: 0x46c
// Size: 0x290
function setupobjective( trigger, visuals, var_ee9ac91f30ff8e1, skipobjid, icons )
{
    zone = trigger;
    
    if ( !isdefined( visuals ) )
    {
        visuals = [];
        visuals[ 0 ] = zone;
    }
    
    if ( var_ee9ac91f30ff8e1 )
    {
        reservedobjid = 0;
    }
    else
    {
        reservedobjid = undefined;
    }
    
    var_441b8d5f798c04a7 = ( 0, 0, 0 );
    
    if ( isdefined( trigger.target ) )
    {
        var_b6a962ec973ce64d = utility::getstruct( trigger.target, "targetname" );
        
        if ( isdefined( var_b6a962ec973ce64d ) )
        {
            var_441b8d5f798c04a7 = var_b6a962ec973ce64d.origin - trigger.origin;
        }
    }
    
    zone = gameobjects::createuseobject( "neutral", zone, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid );
    zone gameobjects::disableobject();
    zone.icons = icons;
    
    if ( level.gametypebundle.var_97fb7e2f957576b4 )
    {
        for ( index = 0; index < zone.visuals.size ; index++ )
        {
            zone.visuals[ index ] hide();
        }
    }
    else if ( isdefined( level.gametypebundle.var_1014aea47d89466c.id ) )
    {
        zone.visuals[ 0 ] scriptmodelplayanim( level.gametypebundle.var_1014aea47d89466c.id );
    }
    
    zone gameobjects::cancontestclaim( 1 );
    zone.claimgracetime = level.zonecapturetime * 1000;
    zone gameobjects::pinobjiconontriggertouch();
    
    if ( isdefined( trigger.objectivekey ) )
    {
        zone.objectivekey = trigger.objectivekey;
    }
    else
    {
        zone.objectivekey = zone gameobjects::getlabel();
    }
    
    zone gameobjects::mustmaintainclaim( istrue( level.gametypebundle.var_97fb7e2f957576b4 ) );
    zone.id = "hardpoint";
    
    if ( isdefined( zone.trigger.target ) && level.gametypebundle.var_204e7aa6b9e01102 )
    {
        zone thread assignchevrons( zone.trigger.target, zone.trigger.script_label );
    }
    
    return zone;
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x51b111d1, Offset: 0x705
// Size: 0x27
function function_c18eb83275e643e7( zone )
{
    if ( isdefined( level.var_c18eb83275e643e7 ) )
    {
        zone [[ level.var_c18eb83275e643e7 ]]();
    }
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x4a61867a, Offset: 0x734
// Size: 0x232
function assignchevrons( target, label )
{
    zone = self;
    wait 1;
    override_dvar = getdvar( @"hash_2b544e23b7b49386" );
    
    if ( override_dvar )
    {
        target = override_dvar + label;
    }
    
    othervisuals = getentitylessscriptablearray( target, #targetname );
    othervisuals = removechevronsfromarray( othervisuals, label );
    othervisuals = postshipmodifychevrons( othervisuals, label );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
        
        if ( isdefined( visual.script_noteworthy ) )
        {
            if ( visual.script_noteworthy == "2" )
            {
                chevrons[ index ].numchevrons = 2;
            }
            else if ( visual.script_noteworthy == "3" )
            {
                chevrons[ index ].numchevrons = 3;
            }
            else if ( visual.script_noteworthy == "4" )
            {
                chevrons[ index ].numchevrons = 4;
            }
        }
        
        if ( level.gametypebundle.var_350c19e6e97cf670 )
        {
            for ( i = 0; i < chevrons[ index ].numchevrons ; i++ )
            {
                visual setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), level.gametypebundle.var_350c19e6e97cf670 );
            }
        }
    }
    
    zone.chevrons = chevrons;
    flags::gameflaginit( "chevrons_ready", 0 );
    flags::gameflagset( "chevrons_ready" );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x5e2ac61a, Offset: 0x96e
// Size: 0x127
function updatechevrons( state )
{
    if ( !level.gametypebundle.var_204e7aa6b9e01102 )
    {
        return;
    }
    
    zone = self;
    zone notify( #"hash_4b8378ba629fc7e4" );
    zone endon( #"hash_4b8378ba629fc7e4" );
    
    while ( !isdefined( zone.chevrons ) )
    {
        waitframe();
    }
    
    foreach ( chevron in zone.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
    
    function_c18eb83275e643e7( zone );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0x47f0ba7a, Offset: 0xa9d
// Size: 0xf9
function function_19aca0cff8c1573b()
{
    if ( !level.gametypebundle.var_204e7aa6b9e01102 )
    {
        return;
    }
    
    zone = self;
    
    if ( !zone.active )
    {
        zone thread updatechevrons( "off" );
        return;
    }
    
    if ( zone.stalemate )
    {
        zone thread updatechevrons( "contested" );
        return;
    }
    
    if ( zone.ownerteam != "neutral" )
    {
        zone thread updatechevrons( zone.ownerteam );
        return;
    }
    
    if ( zone.isunoccupied || level.zoneislocked )
    {
        zone thread updatechevrons( "idle" );
        return;
    }
    
    if ( !level.gametypebundle.var_f2e17118451564d8 )
    {
        zone thread updatechevrons( zone.mostnumtouchingteam );
        return;
    }
    
    zone thread updatechevrons( "idle" );
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x8a5d5431, Offset: 0xb9e
// Size: 0x21d
function activatezone( objid, skipobjid )
{
    zone = self;
    zone.onuse = &zone_onuse;
    zone.onbeginuse = &zone_onusebegin;
    zone.onuseupdate = &zone_onuseupdate;
    zone.onenduse = &zone_onuseend;
    zone.onunoccupied = &zone_onunoccupied;
    zone.oncontested = &zone_oncontested;
    zone.onuncontested = &zone_onuncontested;
    zone.stompprogressreward = &zone_stompprogressreward;
    zone.onpinnedstate = &zone_onpinnedstate;
    zone.onunpinnedstate = &zone_onunpinnedstate;
    zone.didstatusnotify = 0;
    
    if ( !skipobjid )
    {
        if ( isdefined( objid ) )
        {
            zone gameobjects::requestid( 1, 1, objid, 1, 0 );
        }
        else
        {
            zone gameobjects::requestid( 1, 1, 0, 1, 0 );
        }
    }
    
    zone.ignorestomp = istrue( level.gametypebundle.var_7aefa783472942fe );
    
    if ( zone.ignorestomp )
    {
        zone.alwaysstalemate = 1;
        
        if ( level.zonemajoritycapture )
        {
            zone.alwaysstalemate = 0;
            zone.var_dca8426b95acfcc0 = 1;
        }
    }
    else
    {
        zone.stompeenemyprogressupdate = &function_44190f6c3a173bc4;
        objidpoolmanager::update_objective_position( zone.objidnum, zone.visuals[ 0 ].origin + ( 0, 0, 70 ) );
    }
    
    function_ca1cc2938b2b4271( zone.objidnum, zone.trigger );
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", zone.objectivekey, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 1 ] );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0x52e48450, Offset: 0xdc3
// Size: 0x22b
function deactivatezone()
{
    zone = self;
    zone.onuse = undefined;
    zone.onbeginuse = undefined;
    zone.onuseupdate = undefined;
    zone.onunoccupied = undefined;
    zone.oncontested = undefined;
    zone.onuncontested = undefined;
    zone.stompprogressreward = undefined;
    zone.onpinnedstate = undefined;
    zone.onunpinnedstate = undefined;
    zone.stalemate = 0;
    zone.wasstalemate = 0;
    zone.didstatusnotify = 0;
    zone thread updatechevrons( "off" );
    
    foreach ( player in level.players )
    {
        objidpoolmanager::objective_unpin_player( zone.objidnum, player );
    }
    
    function_ca30be9f04600a82( zone.objidnum );
    zone.trigger utility::trigger_off();
    zone thread waitthensetvisibleteam();
    zone gameobjects::releaseid( 1, 0 );
    
    if ( zone.visuals[ 0 ] isscriptable() )
    {
        zone.visuals[ 0 ] setscriptablepartstate( "main", "off" );
    }
    else if ( isdefined( level.gametypebundle.var_2ee9e1585f1e8889.id ) )
    {
        zone.visuals[ 0 ] scriptmodelplayanim( level.gametypebundle.var_2ee9e1585f1e8889.id );
    }
    
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", zone.objectivekey, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 0 ] );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0xa1d01e0b, Offset: 0xff6
// Size: 0x84
function zonetimerwait()
{
    level endon( #"game_ended" );
    level endon( #"hash_a5281c9480b32767" );
    var_706b83b036d3d887 = int( level.zonemovetime * 1000 + gettime() );
    
    if ( !isdefined( level.zoneselectiondelay ) || level.zoneselectiondelay < 10 )
    {
        thread hp_move_soon( level.zonemovetime );
    }
    
    level thread handlehostmigration( var_706b83b036d3d887 );
    hostmigration::waitlongdurationwithhostmigrationpause( level.zonemovetime );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xe1ea967e, Offset: 0x1082
// Size: 0x261
function hp_move_soon( timer )
{
    level endon( #"game_ended" );
    
    /#
        level endon( #"hash_6e4a7f22a3ba828e" );
    #/
    
    gametypexhash = getxhash( game_utility::getgametype() );
    
    if ( gametypexhash == #"hq" )
    {
        level endon( #"zone_destroyed" );
    }
    
    if ( isdefined( level.nextzonerevealtime ) )
    {
        timer = max( timer - level.nextzonerevealtime, 0 );
    }
    
    hostmigration::waitlongdurationwithhostmigrationpause( timer );
    
    if ( isdefined( level.futurezone ) && level.nextzonerevealtime > 0 )
    {
        objid = 1;
        objidpoolmanager::objective_set_play_intro( objid, 0 );
        objidpoolmanager::objective_set_play_outro( objid, 0 );
        objidpoolmanager::update_objective_state( objid, "current" );
        objidpoolmanager::update_objective_position( objid, level.futurezone.visuals[ 0 ].origin + level.futurezone.offset3d );
        level.futurezone gameobjects::setvisibleteam( "any", objid );
        level.futurezone gameobjects::setobjectivestatusicons( level.futurezone.icons.iconnext ?? level.iconnext, level.futurezone.icons.iconnext ?? level.iconnext, objid );
    }
    else if ( isdefined( level.futurezoneindex ) && isdefined( level.var_5c43edbf9ac329aa ) )
    {
        level thread [[ level.var_5c43edbf9ac329aa ]]();
    }
    
    if ( timer < 3 )
    {
        wait 3;
    }
    
    gameplay_sound_fx::function_28103d3430792dce( level.futurezone.curorigin, #"hash_5c14173456f7a177" );
    
    foreach ( entry in level.teamnamelist )
    {
        level dialog::statusdialog( "hp_move_soon", entry );
    }
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xc2b30d57, Offset: 0x12eb
// Size: 0xa5
function handlehostmigration( var_706b83b036d3d887 )
{
    level endon( #"game_ended" );
    level endon( #"bomb_defused" );
    level endon( #"disconnect" );
    level endon( #"zone_captured" );
    level waittill( #"host_migration_begin" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    timepassed = hostmigration::waittillhostmigrationdone();
    setomnvar( "ui_objective_timer_stopped", 0 );
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_hardpoint_timer", level.zoneendtime + timepassed );
        return;
    }
    
    setomnvar( "ui_hardpoint_timer", level.zoneendtime );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0xb7b20565, Offset: 0x1398
// Size: 0x3f
function hardpoint_setneutral()
{
    zone = self;
    zone notify( #"flag_neutral" );
    zone gameobjects::setownerteam( "neutral" );
    playhardpointneutralfx();
    zone thread updatechevrons( "idle" );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0xd1f372aa, Offset: 0x13df
// Size: 0xd2
function trackgametypevips()
{
    thread cleanupgametypevips();
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    zone = self;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( zone.trigger ) )
            {
                player setgametypevip( 1 );
                continue;
            }
            
            player setgametypevip( 0 );
        }
        
        wait 0.5;
    }
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0x8c7f2e09, Offset: 0x14b9
// Size: 0x8c
function cleanupgametypevips()
{
    level utility::waittill_any( "game_ended", "zone_moved" );
    
    foreach ( player in level.players )
    {
        player setgametypevip( 0 );
    }
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x919a58a2, Offset: 0x154d
// Size: 0x4e4
function zone_onuse( credit_player )
{
    if ( !( isdefined( credit_player ) && isdefined( credit_player.team ) ) )
    {
        return;
    }
    
    zone = self;
    objidpoolmanager::objective_set_progress( zone.objidnum, 0 );
    objidpoolmanager::objective_show_progress( zone.objidnum, 0 );
    capture_team = credit_player.team;
    capturetime = gettime();
    touchlist = [];
    touchkeys = getarraykeys( zone.touchlist[ capture_team ] );
    
    for ( i = 0; i < touchkeys.size ; i++ )
    {
        touchlist[ touchkeys[ i ] ] = zone.touchlist[ capture_team ][ touchkeys[ i ] ];
    }
    
    gametypexhash = getxhash( game_utility::getgametype() );
    
    if ( gametypexhash == #"koth" )
    {
        level notify( #"objective_statechanged", zone.objidnum );
    }
    
    if ( zone.ownerteam != "neutral" )
    {
        credit_player notify( #"player_zone_captured", self.objectivekey );
    }
    
    if ( gametypexhash == #"hq" && zone.ownerteam != "neutral" )
    {
        setomnvar( "ui_hq_ownerteam", 0 );
        level notify( #"zone_destroyed" );
        
        foreach ( player in level.players )
        {
            objidpoolmanager::objective_unpin_player( zone.objidnum, player );
        }
        
        zone thread waitthensetvisibleteam();
        level updateservericons( "zone_shift", 0 );
        
        if ( isdefined( touchlist ) )
        {
            players_touching = getarraykeys( touchlist );
            
            foreach ( playerid in players_touching )
            {
                player = zone.touchlist[ capture_team ][ playerid ].player;
                challenges::function_a3678ff124a05f01( player );
            }
        }
        
        level thread hq::give_capture_credit( touchlist, capturetime, capture_team, undefined, credit_player, zone );
        level dialog::statusdialog( #"hp_timeout", credit_player.team );
        level dialog::statusdialog( #"hp_owned_lost", zone.ownerteam );
        return;
    }
    
    otherteam = team_utility::getotherteam( capture_team );
    zone gameobjects::setownerteam( capture_team );
    
    if ( isdefined( level.var_1e1962e4a4e8622 ) )
    {
        level thread [[ level.var_1e1962e4a4e8622 ]]( zone, credit_player, touchlist, capturetime );
    }
    else
    {
        level thread koth::awardcapturepoints();
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::pausetimer();
        }
        
        if ( level.lastcaptureteam != capture_team )
        {
            assert( capture_team != "<dev string:x24>" );
            level thread koth::give_capture_credit( touchlist, capturetime, capture_team, level.lastcaptureteam, credit_player, zone );
            level dialog::statusdialog( #"hp_captured_friendly", capture_team );
            level dialog::statusdialog( #"hp_captured_enemy", otherteam );
        }
    }
    
    level.usestartspawns = 0;
    zone gameobjects::setobjectivestatusicons( zone.icons.icondefending ?? level.icondefending, zone.icons.iconcapture ?? level.iconcapture );
    level updateservericons( capture_team, 0 );
    
    foreach ( var_7fdff2037d22152f in level.players )
    {
        zone showcapturedhardpointeffecttoplayer( capture_team, var_7fdff2037d22152f );
    }
    
    zone thread updatechevrons( capture_team );
    level.hpcapteam = capture_team;
    zone.capturecount++;
    level.lastcaptureteam = capture_team;
    level notify( #"zone_captured" );
    level notify( "zone_captured" + capture_team );
    callback::callback( "zone_captured", { #team:capture_team } );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0xff52c6c3, Offset: 0x1a39
// Size: 0x1e
function waitthensetvisibleteam()
{
    zone = self;
    waitframe();
    zone gameobjects::setvisibleteam( "none" );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xb1b27dae, Offset: 0x1a5f
// Size: 0x21b
function zone_onusebegin( player )
{
    player.isonobjective = 1;
    zone = self;
    gametypexhash = getxhash( game_utility_mp::getbasegametype() );
    ownerteam = zone gameobjects::getownerteam();
    objidpoolmanager::objective_show_progress( zone.objidnum, 1 );
    enemyicon = zone.icons.icontaking ?? level.icontaking;
    
    if ( gametypexhash == #"hq" )
    {
        if ( ownerteam != "neutral" && zone.claimteam != ownerteam )
        {
            adjustmatchtimerpausedstatefromscore( ownerteam, 1 );
            enemyicon = zone.icons.icondisabling ?? level.icondisabling;
        }
        
        if ( !zone.stalemate && isplayer( player ) )
        {
            if ( ownerteam == "neutral" )
            {
                player setclientomnvar( "ui_objective_pinned_text_param", 1 );
            }
            else
            {
                player setclientomnvar( "ui_objective_pinned_text_param", 2 );
            }
        }
        
        zone function_19aca0cff8c1573b();
    }
    else if ( gametypexhash == #"landgrab" && ownerteam == "neutral" )
    {
        zone function_19aca0cff8c1573b();
    }
    
    if ( !isdefined( zone.statusnotifytime ) )
    {
        zone.statusnotifytime = gettime();
    }
    
    if ( zone.statusnotifytime > zone.statusnotifytime + 10000 )
    {
        zone.didstatusnotify = 0;
        zone.statusnotifytime = gettime();
    }
    
    zone gameobjects::setusetime( level.zonecapturetime );
    
    if ( level.zonecapturetime > 0 )
    {
        zone.prevownerteam = team_utility::getotherteam( player.team );
        zone gameobjects::setobjectivestatusicons( zone.icons.iconlosing ?? level.iconlosing, enemyicon );
    }
}

// Namespace obj_zonecapture
// Params 4
// Checksum 0x617abac2, Offset: 0x1c82
// Size: 0x25d
function zone_onuseupdate( team, progress, change, capplayer )
{
    zone = self;
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, team );
    ownerteam = zone gameobjects::getownerteam();
    gametypexhash = getxhash( game_utility_mp::getbasegametype() );
    
    if ( gametypexhash == #"hq" || gametypexhash == #"wm" )
    {
        if ( level.mapname != "mp_jup_skydiving" && ( zone.objectivekey == "_e" || zone.objectivekey == "_f" ) )
        {
            if ( progress < 1 && !level.gameended )
            {
                playcapturesound( progress, team );
            }
        }
    }
    
    if ( gametypexhash == #"push_zone" )
    {
        playcapturesound( progress, team );
    }
    
    if ( gametypexhash == #"hq" )
    {
        if ( ownerteam == "neutral" && zone.claimteam != ownerteam )
        {
            adjustmatchtimerpausedstatefromscore( zone.claimteam );
        }
        else if ( ownerteam != "neutral" && zone.claimteam != ownerteam )
        {
            adjustmatchtimerpausedstatefromscore( ownerteam, 1 );
        }
        else if ( level.pausemodetimer )
        {
            level gamelogic_mp::pausetimer();
        }
    }
    else if ( level.pausemodetimer )
    {
        level gamelogic_mp::pausetimer();
    }
    
    ownerteam = zone gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    
    if ( progress > 0.05 && change && !zone.didstatusnotify )
    {
        if ( ownerteam == "neutral" )
        {
            dialog::statusdialog( "hp_capturing_friendly", team );
            dialog::statusdialog( "hp_capturing_enemy", otherteam );
        }
        else if ( gametypexhash == #"hq" )
        {
            dialog::statusdialog( "hp_disabling_friendly", ownerteam );
            dialog::statusdialog( "hp_disabling_enemy", team );
        }
        else
        {
            dialog::statusdialog( "hp_capturing_enemy", ownerteam );
            dialog::statusdialog( "hp_capturing_friendly", team );
        }
        
        zone.didstatusnotify = 1;
    }
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x27e3851, Offset: 0x1ee7
// Size: 0x9f
function playcapturesound( progress, team )
{
    zone = self;
    
    if ( !isdefined( zone.lastsfxplayedtime ) )
    {
        zone.lastsfxplayedtime = gettime();
    }
    
    if ( zone.lastsfxplayedtime + 995 < gettime() )
    {
        zone.lastsfxplayedtime = gettime();
        progress = int( floor( progress * 10 ) );
        var_8eb35fb703d61a67 = "shared_obj_capturing_tick_0" + progress;
        zone.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( var_8eb35fb703d61a67, team );
    }
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0x7ea7265d, Offset: 0x1f8e
// Size: 0x236
function zone_onuseend( team, player, success )
{
    if ( isdefined( player ) )
    {
        player.isonobjective = 0;
    }
    
    zone = self;
    ownerteam = zone gameobjects::getownerteam();
    level notify( #"hash_cbc7e4fe8790aa90" );
    
    if ( !success )
    {
        gametypexhash = getxhash( game_utility_mp::getbasegametype() );
        
        if ( gametypexhash == #"hq" )
        {
            if ( ownerteam != "neutral" )
            {
                adjustmatchtimerpausedstatefromscore( ownerteam );
            }
        }
        else if ( level.pausemodetimer )
        {
            level gamelogic_mp::resumetimer();
        }
    }
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    }
    
    if ( ownerteam == "neutral" )
    {
        zone gameobjects::setobjectivestatusicons( zone.icons.iconneutral ?? level.iconneutral );
        
        if ( level.usehpzonebrushes )
        {
            foreach ( player in level.players )
            {
                zone showzoneneutralbrush( player );
            }
        }
        
        return;
    }
    
    zone gameobjects::setobjectivestatusicons( zone.icons.icondefend ?? level.icondefend, zone.icons.iconcapture ?? level.iconcapture );
    
    foreach ( player in level.players )
    {
        zone showcapturedhardpointeffecttoplayer( ownerteam, player );
    }
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0xf81e8a3a, Offset: 0x21cc
// Size: 0x209
function zone_onunoccupied()
{
    zone = self;
    gametypexhash = getxhash( game_utility_mp::getbasegametype() );
    
    if ( gametypexhash == #"hq" && zone.ownerteam != "neutral" )
    {
        zone gameobjects::setobjectivestatusicons( zone.icons.icondefend ?? level.icondefend, zone.icons.iconcapture ?? level.iconcapture );
        adjustmatchtimerpausedstatefromscore( zone.ownerteam );
        zone function_19aca0cff8c1573b();
    }
    else if ( ( gametypexhash == #"landgrab" || gametypexhash == #"wm" || gametypexhash == #"push_zone" ) && zone.ownerteam != "neutral" )
    {
        zone gameobjects::setobjectivestatusicons( zone.icons.icondefend ?? level.icondefend, zone.icons.iconcapture ?? level.iconcapture );
        zone function_19aca0cff8c1573b();
    }
    else
    {
        level notify( #"zone_destroyed" );
        level.hpcapteam = "neutral";
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::resumetimer();
        }
        
        level updateservericons( "neutral", 0 );
        zone.wasleftunoccupied = 1;
        zone gameobjects::setobjectivestatusicons( zone.icons.iconneutral ?? level.iconneutral );
        zone playhardpointneutralfx();
        zone thread updatechevrons( "idle" );
    }
    
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, "neutral" );
    callback::callback( "zone_unoccupied", {} );
    zone notify( #"zone_unoccupied" );
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0x7190b7f4, Offset: 0x23dd
// Size: 0x4d1
function zone_oncontested()
{
    zone = self;
    zone thread koth::function_7c13860f63af063f();
    
    if ( level.pausemodetimer )
    {
        level gamelogic_mp::resumetimer();
    }
    
    zone.contestedtime = gettime();
    ownerteam = zone gameobjects::getownerteam();
    zone gameobjects::setobjectivestatusicons( zone.icons.iconcontested ?? level.iconcontested );
    level updateservericons( ownerteam, 1 );
    zone thread updatechevrons( "contested" );
    
    foreach ( team in level.teamnamelist )
    {
        if ( zone.touchlist[ team ].size )
        {
            touchlist = zone.touchlist[ team ];
            players_touching = getarraykeys( touchlist );
            
            for ( index = 0; index < players_touching.size ; index++ )
            {
                player = touchlist[ players_touching[ index ] ].player;
                
                if ( isplayer( player ) )
                {
                    player setclientomnvar( "ui_objective_pinned_text_param", 3 );
                }
            }
        }
    }
    
    foreach ( player in level.players )
    {
        zone showcapturedhardpointeffecttoplayer( ownerteam, player );
    }
    
    if ( ownerteam == "neutral" )
    {
        notifyteam = zone.claimteam;
    }
    else
    {
        notifyteam = ownerteam;
    }
    
    assert( isdefined( notifyteam ), "<dev string:x2c>" );
    enemyteam = team_utility::getotherteam( notifyteam );
    var_7ab4ff8db55b194d = hashcat( #"attacking_contested", zone.iconname );
    var_b163fe8f8d4fa181 = hashcat( #"defending_contested", zone.iconname );
    var_3f6d0a35e368fe6a = zone.iconname && dialog_utility::dialogueexists( var_7ab4ff8db55b194d, notifyteam ) && dialog_utility::dialogueexists( var_b163fe8f8d4fa181, enemyteam );
    
    if ( var_3f6d0a35e368fe6a )
    {
        if ( isdefined( level.var_5578c6cd6f2db7dd ) && [[ level.var_5578c6cd6f2db7dd ]]() )
        {
            dialog::statusdialog( #"defending_contested_all", notifyteam );
            dialog::statusdialog( #"attacking_contested_all", enemyteam );
        }
        else
        {
            dialog::statusdialog( var_b163fe8f8d4fa181, notifyteam );
            dialog::statusdialog( var_7ab4ff8db55b194d, enemyteam );
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"hp_contested", entry );
        }
    }
    
    gametypexhash = getxhash( game_utility::getgametype() );
    
    if ( gametypexhash == #"landgrab" )
    {
        zone function_19aca0cff8c1573b();
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = zone;
    telemetry_data.eventname = "hill_contested";
    telemetry_data.position = zone.trigger.origin;
    
    if ( gametypexhash == #"push_zone" )
    {
        soundref = #"push_contested";
    }
    else
    {
        soundref = #"hash_3622b759df4b5afb";
    }
    
    if ( isdefined( self.callbacks[ #"hash_b58aae7268714e80" ] ) || isdefined( level.callbacks[ #"hash_b58aae7268714e80" ] ) )
    {
        callback::callback( #"hash_b58aae7268714e80", { #zone:zone } );
    }
    
    zone thread oncontested_playsoundatpos( zone.trigger.origin, soundref, 3 );
    zone.didstatusnotify = 1;
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, "neutral" );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xa14c56cc, Offset: 0x28b6
// Size: 0x4a4
function zone_onuncontested( lastclaimteam )
{
    zone = self;
    level notify( #"hash_cbc7e4fe8790aa90" );
    
    if ( getxhash( game_utility::getgametype() ) == #"push_zone" )
    {
        soundref = #"push_uncontested";
    }
    else
    {
        soundref = #"hash_bb142d973fe563ce";
    }
    
    zone thread onuncontested_playsoundatpos( zone.trigger.origin, soundref, 3 );
    
    if ( level.pausemodetimer )
    {
        level gamelogic_mp::pausetimer();
    }
    
    ownerteam = zone gameobjects::getownerteam();
    gametypexhash = getxhash( game_utility::getgametype() );
    
    if ( lastclaimteam == "none" || ownerteam == "neutral" )
    {
        zone gameobjects::setobjectivestatusicons( zone.icons.iconneutral ?? level.iconneutral );
        
        if ( level.usehpzonebrushes )
        {
            foreach ( player in level.players )
            {
                zone showzoneneutralbrush( player );
            }
        }
        
        telemetry_data = spawnstruct();
        telemetry_data.player = zone;
        telemetry_data.eventname = "hill_empty";
        telemetry_data.position = zone.trigger.origin;
        
        if ( ownerteam == "neutral" )
        {
            gameplay_sound_fx::function_28103d3430792dce( zone.trigger.origin, #"hash_2a5685e9e7ba93f2" );
        }
        
        if ( lastclaimteam != "none" )
        {
            zone gameobjects::setobjectivestatusicons( zone.icons.iconlosing ?? level.iconlosing, zone.icons.icontaking ?? level.icontaking );
        }
    }
    else
    {
        gametypexhash = getxhash( game_utility_mp::getbasegametype() );
        
        if ( gametypexhash == #"koth" )
        {
            otherteam = team_utility::getotherteam( ownerteam );
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_8934f6f529f89464", teams::getteamdata( ownerteam, "players" ) );
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_6e7daae1df44022c", teams::getteamdata( otherteam, "players" ) );
        }
        else if ( gametypexhash == #"grnd" )
        {
            otherteam = team_utility::getotherteam( ownerteam );
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_b15d17ff4d630695", teams::getteamdata( ownerteam, "players" ) );
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_6d11794f45e5cae1", teams::getteamdata( otherteam, "players" ) );
        }
        
        zone function_f8d54cc23fb7b924( zone.icons.icondefend ?? level.icondefend, zone.icons.iconcapture ?? level.iconcapture );
        
        foreach ( player in level.players )
        {
            zone showcapturedhardpointeffecttoplayer( ownerteam, player );
        }
        
        telemetry_data = spawnstruct();
        telemetry_data.player = zone;
        telemetry_data.eventname = "hill_uncontested";
        telemetry_data.position = zone.trigger.origin;
    }
    
    if ( isdefined( self.callbacks[ #"hash_22ee4439898d01bd" ] ) || isdefined( level.callbacks[ #"hash_22ee4439898d01bd" ] ) )
    {
        callback::callback( #"hash_22ee4439898d01bd", { #zone:zone } );
    }
    
    zone.contestedtime = undefined;
    zone function_19aca0cff8c1573b();
    level updateservericons( ownerteam, 0 );
    zone.didstatusnotify = 0;
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, "neutral" );
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x3b3eb25b, Offset: 0x2d62
// Size: 0xa1
function updateservericons( state, contested )
{
    omnvarval = -1;
    
    if ( contested )
    {
        omnvarval = -2;
    }
    else if ( team_utility::isgameplayteam( state ) )
    {
        player = getownerteamplayer( state );
        
        if ( isdefined( player ) )
        {
            omnvarval = player getentitynumber();
        }
    }
    else
    {
        switch ( state )
        {
            case #"hash_3bf8ec5fe1d42da8":
                omnvarval = -3;
                break;
            case #"hash_c312107e6bce703c":
            default:
                break;
        }
    }
    
    setomnvar( "ui_hardpoint", omnvarval );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xa503341, Offset: 0x2e0b
// Size: 0xa1
function getownerteamplayer( ownerteam )
{
    ownerplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.team == ownerteam )
        {
            ownerplayer = player;
            break;
        }
    }
    
    return ownerplayer;
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xca8b416e, Offset: 0x2eb5
// Size: 0x15
function function_44190f6c3a173bc4( team )
{
    adjustmatchtimerpausedstatefromscore( team );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xb9835ed4, Offset: 0x2ed2
// Size: 0x7f
function zone_stompprogressreward( player )
{
    zone = self;
    player thread rank::function_d2aa8986c506e985( #"defend" );
    player events::function_a7d373228760063b();
    zone gameobjects::setobjectivestatusicons( zone.icons.icondefending ?? level.icondefending, zone.icons.iconcapture ?? level.iconcapture );
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x89b97feb, Offset: 0x2f59
// Size: 0xdb
function function_f8d54cc23fb7b924( friendlyicon, enemyicon )
{
    if ( getxhash( game_utility::getgametype() ) == #"wm" && !self.stalemate )
    {
        if ( self.numtouching[ self.ownerteam ] )
        {
            friendlyicon = self.icons.icondefending ?? level.icondefending;
        }
        
        if ( self.numtouching[ team_utility::getotherteam( self.ownerteam )[ 0 ] ] )
        {
            enemyicon = self.icons.icontaking ?? level.icontaking;
            friendlyicon = self.icons.iconlosing ?? level.iconlosing;
        }
    }
    
    gameobjects::setobjectivestatusicons( friendlyicon, enemyicon );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xbb9421d6, Offset: 0x303c
// Size: 0xee
function zone_onpinnedstate( player )
{
    zone = self;
    
    if ( !zone.stalemate )
    {
        if ( zone.ownerteam != "neutral" && zone.numtouching[ zone.ownerteam ] || getxhash( game_utility::getgametype() ) == #"wm" && isdefined( player.team ) && zone.numtouching[ player.team ] )
        {
            zone function_f8d54cc23fb7b924( zone.icons.icondefending ?? level.icondefending, zone.icons.iconcapture ?? level.iconcapture );
        }
    }
    
    function_c18eb83275e643e7( zone );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xa1e79dc7, Offset: 0x3132
// Size: 0xd8
function zone_onunpinnedstate( player )
{
    zone = self;
    
    if ( !zone.stalemate )
    {
        if ( zone.ownerteam != "neutral" && !zone.numtouching[ zone.ownerteam ] || isdefined( player.team ) && !zone.numtouching[ player.team ] )
        {
            zone function_f8d54cc23fb7b924( zone.icons.icondefend ?? level.icondefend, zone.icons.iconcapture ?? level.iconcapture );
        }
    }
    
    function_c18eb83275e643e7( zone );
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x28d05817, Offset: 0x3212
// Size: 0x8b
function adjustmatchtimerpausedstatefromscore( team, var_c67d13fc4b16c608 )
{
    if ( !level.pausemodetimer )
    {
        return;
    }
    
    ownerteamscore = gamescore::getteamscore( team );
    otherteamscore = gamescore::getteamscore( team_utility::getotherteam( team ) );
    
    if ( var_c67d13fc4b16c608 )
    {
        if ( otherteamscore > ownerteamscore )
        {
            level gamelogic_mp::resumetimer();
        }
        else
        {
            level gamelogic_mp::pausetimer();
        }
        
        return;
    }
    
    if ( ownerteamscore > otherteamscore )
    {
        level gamelogic_mp::resumetimer();
        return;
    }
    
    level gamelogic_mp::pausetimer();
}

// Namespace obj_zonecapture
// Params 0
// Checksum 0xccb6821a, Offset: 0x32a5
// Size: 0x87
function playhardpointneutralfx()
{
    if ( level.usehpzonebrushes )
    {
        foreach ( player in level.players )
        {
            showzoneneutralbrush( player );
        }
    }
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x334e7f0f, Offset: 0x3334
// Size: 0xb3
function showcapturedhardpointeffecttoplayer( capture_team, player )
{
    zone = self;
    viewerteam = player.team;
    iscodcaster = player iscodcaster();
    
    if ( iscodcaster )
    {
        if ( player ismlgfreecamenabled() || player ismlgaerialcamenabled() )
        {
            viewerteam = "allies";
        }
        else
        {
            viewerteam = player getcodcasterteam();
        }
    }
    
    if ( level.usehpzonebrushes )
    {
        if ( zone.stalemate )
        {
            showzonecontestedbrush( player );
            return;
        }
        
        if ( viewerteam == capture_team )
        {
            showzonefriendlybrush( player );
            return;
        }
        
        showzoneenemybrush( player );
    }
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x82a32eee, Offset: 0x33ef
// Size: 0x61
function showzoneneutralbrush( player )
{
    zone = self;
    zone.friendlybrush hidefromplayer( player );
    zone.enemybrush hidefromplayer( player );
    zone.contestedbrush hidefromplayer( player );
    zone.neutralbrush showtoplayer( player );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xfc9365ee, Offset: 0x3458
// Size: 0x61
function showzonefriendlybrush( player )
{
    zone = self;
    zone.friendlybrush showtoplayer( player );
    zone.enemybrush hidefromplayer( player );
    zone.contestedbrush hidefromplayer( player );
    zone.neutralbrush hidefromplayer( player );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x28c4522a, Offset: 0x34c1
// Size: 0x61
function showzoneenemybrush( player )
{
    zone = self;
    zone.friendlybrush hidefromplayer( player );
    zone.enemybrush showtoplayer( player );
    zone.contestedbrush hidefromplayer( player );
    zone.neutralbrush hidefromplayer( player );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x5cbbc203, Offset: 0x352a
// Size: 0x61
function showzonecontestedbrush( player )
{
    zone = self;
    zone.friendlybrush hidefromplayer( player );
    zone.enemybrush hidefromplayer( player );
    zone.contestedbrush showtoplayer( player );
    zone.neutralbrush hidefromplayer( player );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xf4a22bd3, Offset: 0x3593
// Size: 0x61
function hideplayerspecificbrushes( player )
{
    zone = self;
    zone.friendlybrush hidefromplayer( player );
    zone.enemybrush hidefromplayer( player );
    zone.neutralbrush hidefromplayer( player );
    zone.contestedbrush hidefromplayer( player );
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0x42efd4d, Offset: 0x35fc
// Size: 0x58
function onplayerjoinedteam( player )
{
    zone = self;
    
    if ( player.team != "spectator" && zone.ownerteam != "neutral" )
    {
        zone showcapturedhardpointeffecttoplayer( zone.ownerteam, player );
    }
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x54d82c6a, Offset: 0x365c
// Size: 0x2a2
function removechevronsfromarray( othervisuals, label )
{
    modifiedvisuals = [];
    var_98c9d5bd477d820b = [];
    
    switch ( level.mapname )
    {
        case #"hash_9de262a7132ec180":
            var_98c9d5bd477d820b[ "1" ] = [ ( -564, 1848, 24 ) ];
            var_98c9d5bd477d820b[ "2" ] = [ ( -1314, 440, 24 ), ( -1362, 816, 24 ) ];
            break;
        case #"hash_66ce5cdcd3b547f3":
        case #"hash_ff009e5fab42b778":
            var_98c9d5bd477d820b[ "3" ] = [ ( -692, 1828, 42 ), ( -300, 1548, 76 ) ];
            break;
        case #"hash_f09747c9feb47eb1":
            var_98c9d5bd477d820b[ "8" ] = [ ( 688, 256, 280 ) ];
            var_98c9d5bd477d820b[ "20" ] = [ ( 212, 1436, 338 ) ];
            break;
        case #"hash_81b84d832a53ee33":
            var_98c9d5bd477d820b[ "5" ] = [ ( 778, -1458, 136 ), ( 860, -1226, 158 ) ];
            break;
        case #"hash_dfa04d97b4cc9b44":
            var_98c9d5bd477d820b[ "5" ] = [ ( -6792, 42420, 221 ), ( -6680, 42778, 213 ) ];
            break;
        default:
            break;
    }
    
    if ( isdefined( var_98c9d5bd477d820b[ label ] ) )
    {
        foreach ( visual in othervisuals )
        {
            foreach ( entry in var_98c9d5bd477d820b[ label ] )
            {
                if ( distance( visual.origin, entry ) < 10 )
                {
                    modifiedvisuals[ modifiedvisuals.size ] = visual;
                    break;
                }
            }
        }
    }
    
    othervisuals = arrayremove( othervisuals, modifiedvisuals );
    return othervisuals;
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x14f51de7, Offset: 0x3907
// Size: 0xe1
function postshipmodifychevrons( othervisuals, label )
{
    newchevrons = [];
    modifiedvisuals = [];
    
    if ( isdefined( newchevrons[ label ] ) )
    {
        foreach ( entry in newchevrons[ label ] )
        {
            origin = entry[ 0 ];
            angles = entry[ 1 ];
            scriptable = spawnscriptable( "hardpoint_chevron", origin, angles );
            modifiedvisuals[ modifiedvisuals.size ] = scriptable;
        }
    }
    
    othervisuals = arraycombine( othervisuals, modifiedvisuals );
    return othervisuals;
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0x670df956, Offset: 0x39f1
// Size: 0x3c
function createvisualsinfo( scriptable, origin, angles )
{
    scriptable.origin = origin;
    scriptable.angles = angles;
    return scriptable;
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0x659195eb, Offset: 0x3a36
// Size: 0x5c
function oncontested_playsoundatpos( posorigin, soundref, timer )
{
    if ( !isdefined( self.contestedbool ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( posorigin + ( 0, 0, 15 ), soundref );
        self.contestedbool = 1;
        wait timer;
        self.contestedbool = undefined;
    }
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0x49f25d12, Offset: 0x3a9a
// Size: 0x5c
function onuncontested_playsoundatpos( posorigin, soundref, timer )
{
    if ( !isdefined( self.uncontestedbool ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( posorigin + ( 0, 0, 15 ), soundref );
        self.uncontestedbool = 1;
        wait timer;
        self.uncontestedbool = undefined;
    }
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x80117838, Offset: 0x3afe
// Size: 0x12a
function calculatespawndisttozones( spawnpoint, maxdistance )
{
    spawnpoint.scriptdata.var_a881d5343a45f1a6 = [];
    
    foreach ( zone in level.objectives )
    {
        dist = distance( spawnpoint.origin, zone.origin );
        
        if ( dist < 0 )
        {
            dist = distance2dsquared( spawnpoint.origin, zone.origin );
        }
        else
        {
            dist *= dist;
        }
        
        spawnpoint.scriptdata.var_a881d5343a45f1a6[ zone getentitynumber() ] = dist;
        
        if ( dist > zone.furthestspawndistsq )
        {
            zone.furthestspawndistsq = dist;
        }
    }
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0x14c2a650, Offset: 0x3c30
// Size: 0x149
function function_89b5ddbb5b7acc0f( spawnpoint, zones, maxdistance )
{
    spawnpoint.scriptdata.var_a881d5343a45f1a6 = [];
    
    foreach ( zone in zones )
    {
        dist = distance( spawnpoint.origin, zone.trigger.origin );
        
        if ( dist < 0 )
        {
            dist = distance2dsquared( spawnpoint.origin, zone.trigger.origin );
        }
        else
        {
            dist *= dist;
        }
        
        spawnpoint.scriptdata.var_a881d5343a45f1a6[ zone.trigger getentitynumber() ] = dist;
        
        if ( dist > zone.furthestspawndistsq )
        {
            zone.furthestspawndistsq = dist;
        }
    }
}

// Namespace obj_zonecapture
// Params 1
// Checksum 0xa6273f30, Offset: 0x3d81
// Size: 0x200
function function_95de38e816107658( spawnsetname )
{
    spawnset = spawnlogic::getspawnset( spawnsetname );
    
    foreach ( spawnpoint in spawnset )
    {
        var_43b2a31d7fb4a45f = [];
        
        if ( spawnpoint.script_noteworthy )
        {
            zoneindicies = [];
            zoneindicies = strtok( spawnpoint.script_noteworthy, " " );
            
            foreach ( zoneindex in zoneindicies )
            {
                zone = level.objectives[ zoneindex ];
                assert( isdefined( zone ), "<dev string:x91>" + zoneindex + "<dev string:x9e>" );
                
                if ( isdefined( zone ) )
                {
                    var_43b2a31d7fb4a45f[ var_43b2a31d7fb4a45f.size ] = zone;
                }
            }
        }
        
        if ( var_43b2a31d7fb4a45f.size == 0 )
        {
            var_43b2a31d7fb4a45f = level.objectives;
        }
        
        foreach ( zone in var_43b2a31d7fb4a45f )
        {
            zone.spawnpoints[ spawnsetname ][ zone.spawnpoints[ spawnsetname ].size ] = spawnpoint;
        }
        
        function_89b5ddbb5b7acc0f( spawnpoint, var_43b2a31d7fb4a45f );
    }
}

// Namespace obj_zonecapture
// Params 2
// Checksum 0x49b91170, Offset: 0x3f89
// Size: 0x320
function function_70ffdd1af0cfa91d( zones, spawnkey )
{
    var_bd7a5c86657f1141 = [ "zone1", "zone2", "zone3", "zone4", "zone5", "zone6", "zone7", "zone8", "zone9", "zone10" ];
    assert( var_bd7a5c86657f1141.size >= level.objectives.size, "<dev string:xeb>" + var_bd7a5c86657f1141.size + "<dev string:x11b>" );
    
    foreach ( zone in zones )
    {
        zone.furthestspawndistsq = 0;
        zone.spawnpoints = [];
        zone.spawnpoints[ #"primary" ] = [];
        zone.spawnpoints[ #"fallback" ] = [];
        zoneindex = int( zone.objectivekey ) - 1;
        assert( zoneindex >= 0 && zoneindex < var_bd7a5c86657f1141.size );
        zone.spawnpointvalue = var_bd7a5c86657f1141[ int( zone.objectivekey ) - 1 ];
    }
    
    function_95de38e816107658( #"primary" );
    function_95de38e816107658( #"fallback" );
    teams = [];
    teams[ teams.size ] = game[ "attackers" ];
    teams[ teams.size ] = game[ "defenders" ];
    
    foreach ( objid, zone in zones )
    {
        zone.spawngroup = #"primary";
        zone.spawnset = hashcat( #"zone_", string( objid ) );
        zone.spawnsetanchor = hashcat( #"hash_b2f6d8e9f1a4b782", string( objid ) );
        zone.spawnsetother = zone.spawnset;
        zone.fallbackspawnset = hashcat( #"hash_27132d2a1ef8b993", string( objid ) );
        spawnlogic::registerspawnset( zone.spawnset, zone.spawnpoints[ #"primary" ], teams );
        spawnlogic::registerspawnset( zone.fallbackspawnset, zone.spawnpoints[ #"fallback" ], teams );
    }
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0xdf76a936, Offset: 0x42b1
// Size: 0x1df
function function_cb0ebea2021bd19f( zones, spawnsetname, spawnkey )
{
    spawnset = spawnlogic::getspawnset( spawnsetname );
    
    foreach ( spawnpoint in spawnset )
    {
        var_43b2a31d7fb4a45f = [];
        
        foreach ( zone in zones )
        {
            assert( isdefined( zone.spawnpointvalue ), "<dev string:x123>" );
            
            if ( function_a7814f6d26155db9( spawnpoint.index, spawnkey, zone.spawnpointvalue ) )
            {
                var_43b2a31d7fb4a45f[ var_43b2a31d7fb4a45f.size ] = zone;
            }
        }
        
        if ( var_43b2a31d7fb4a45f.size == 0 )
        {
            var_43b2a31d7fb4a45f = zones;
        }
        
        foreach ( zone in var_43b2a31d7fb4a45f )
        {
            zone.spawnpoints[ spawnsetname ][ zone.spawnpoints[ spawnsetname ].size ] = spawnpoint;
        }
        
        function_89b5ddbb5b7acc0f( spawnpoint, var_43b2a31d7fb4a45f );
    }
}

// Namespace obj_zonecapture
// Params 3
// Checksum 0x420cc086, Offset: 0x4498
// Size: 0x34d
function function_c563aafed90e555e( zones, spawnkey, var_c7f973de127fddfb )
{
    if ( !spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        return function_70ffdd1af0cfa91d( zones, spawnkey );
    }
    
    teams = [];
    teams[ teams.size ] = game[ "attackers" ];
    teams[ teams.size ] = game[ "defenders" ];
    generalspawns = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, "spawn" );
    
    foreach ( objid, zone in zones )
    {
        zone.spawngroup = hashcat( #"zone_", string( objid ) );
        zone.spawnset = hashcat( #"zone_", string( objid ) );
        zone.spawnsetanchor = hashcat( #"hash_b2f6d8e9f1a4b782", string( objid ) );
        zone.spawnsetother = hashcat( #"hash_1faa092f6719232f", string( objid ) );
        zone.spawnvalue = "zone" + objid;
        zone.var_a92e9b52497279d3 = "zone" + objid + "_anchor";
        zone.spawnarray = [];
        zone.spawnarray[ "zone" ] = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, zone.spawnvalue );
        zone.spawnarray[ "anchor" ] = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, zone.var_a92e9b52497279d3 );
    }
    
    foreach ( objid, zone in zones )
    {
        spawnlogic::addspawnpoints( zone.spawngroup, zone.spawnset, teams, zone.spawnarray[ "zone" ], spawnlogic::getspawnpointarraykey( "mp_spawn_point", spawnkey, zone.spawnvalue ) );
        spawnlogic::addspawnpoints( zone.spawngroup, zone.spawnsetanchor, teams, zone.spawnarray[ "anchor" ], spawnlogic::getspawnpointarraykey( "mp_spawn_point", spawnkey, zone.var_a92e9b52497279d3 ) );
        otherspawns = spawnutils::spawnarray_difference( generalspawns, zone.spawnarray[ "zone" ], zone.spawnarray[ "anchor" ] );
        spawnlogic::addspawnpoints( zone.spawngroup, zone.spawnsetother, teams, otherspawns, spawnlogic::getspawnpointarraykey( "mp_spawn_point", spawnkey, zone.spawnvalue + "Other" ) );
        zone.spawnarray = undefined;
    }
}

